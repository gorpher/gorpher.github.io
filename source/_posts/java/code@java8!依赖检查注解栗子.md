# 插件检查器
```java
package checker;

import javax.annotation.processing.ProcessingEnvironment;
import javax.annotation.processing.RoundEnvironment;
import javax.annotation.processing.SupportedAnnotationTypes;
import javax.annotation.processing.SupportedSourceVersion;
import javax.lang.model.SourceVersion;
import javax.lang.model.element.Element;
import javax.lang.model.element.TypeElement;
import javax.tools.Diagnostic;
import javax.xml.bind.JAXBContext;
import java.io.File;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import javax.xml.bind.JAXBException;

/**
 * Reads the device configuration from the XML file specified by -Adevice=device.xml.
 * For each class in a project, checks required modules. If the device doesn't have
 * the required module, then a compilation error will be shown.
 */
@SupportedAnnotationTypes("checker.RequireContainer")
@SupportedSourceVersion(SourceVersion.RELEASE_8)
public class PluginChecker extends javax.annotation.processing.AbstractProcessor {

    /**
     * Name of the option to get the path to the xml with device configuration.
     */
    public static final String DEVICE_OPTION = "device";
    private Device device;

    /**
     * Only the device option is supported.
     *
     * {@inheritDoc}
     */
    @Override
    public Set<String> getSupportedOptions() {
        return new HashSet<>(Arrays.asList(DEVICE_OPTION));
    }

    /**
     * Initializes the processor by loading the device configuration.
     *
     * {@inheritDoc}
     */
    @Override
    public synchronized void init(ProcessingEnvironment processingEnv) {
        super.init(processingEnv);
        try {
            String deviceOption = processingEnv.getOptions().get(DEVICE_OPTION);
            device = (Device) JAXBContext.newInstance(Device.class)
                    .createUnmarshaller().unmarshal(new File(deviceOption));
        } catch (JAXBException e) {
            throw new RuntimeException(
                    "Please specify device by -Adevice=device.xml\n"
                    + e.toString(), e);
        }
    }

    /**
     * Processes @Require annotations and checks that Device meets requirements.
     *
     * {@inheritDoc}
     */
    @Override
    public boolean process(Set<? extends TypeElement> annotations,
            RoundEnvironment roundEnv) {
        for (Element el : roundEnv.getElementsAnnotatedWith(RequireContainer.class)) {
            for (Require req : el.getAnnotationsByType(Require.class)) {
                //for every Require annotation checks if device has module of required version.
                Integer version = device.getSupportedModules().get(req.value());

                if (version == null
                        || version < req.minVersion()
                        || version > req.maxVersion()) {
                    //if module is optional then show only warning not error
                    if (req.optional()) {
                        processingEnv.getMessager()
                                .printMessage(Diagnostic.Kind.WARNING,
                                        "Plugin [" + el + "] requires " + req
                                        + "\n but device " + (version == null
                                        ? "doesn't have such module."
                                        + " This module is optional."
                                        + " So plugin will work but miss"
                                        + " some functionality"
                                        : "has " + version
                                        + " version of that module"));
                    } else {
                        processingEnv.getMessager()
                                .printMessage(Diagnostic.Kind.ERROR,
                                        "Plugin [" + el + "] requires " + req
                                        + "\n but device "
                                        + (version == null
                                        ? "doesn't have such module"
                                        : "has " + version
                                        + " version of that module"));
                    }
                }
            }
            return true;
        }
        return false;
    }
}
```
```java
package checker;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.Collections;
import java.util.EnumMap;
import java.util.Map;

/**
 * Represents the device configuration. The values are loaded from an XML file by JAXB.
 */
@XmlRootElement
public class Device {

    @XmlElement()
    private Map<Module, Integer> supportedModules = new EnumMap<>(Module.class);

    /**
     * Returns map of supported modules. The map key is module. The map value is version.
     *
     * @return map of supported modules.
     */
    public Map<Module, Integer> getSupportedModules() {
        return Collections.unmodifiableMap(supportedModules);
    }
}

```

```java
public enum Module {

    DISPLAY, CLOCK, THERMOMETER, HEATER, SPEAKER, GSM, LED;
}

```
```java
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * A container for the repeatable @Require annotation.
 */
@Retention(RetentionPolicy.CLASS)
public @interface RequireContainer {

    Require[] value();
}
```
```java
import java.lang.annotation.Repeatable;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * Indicates that a plug-in depends on a module.
 */
@Retention(RetentionPolicy.CLASS)
@Repeatable(RequireContainer.class)
public @interface Require {

    /**
     * Returns the required module.
     *
     * @return required module.
     */
    Module value();

    /**
     * Returns the minimum supported version of a module.
     *
     * @return minimum supported version of a module.
     */
    int minVersion() default 1;

    /**
     * Returns the maximum supported version of a module.
     *
     * @return maximum supported version of a module.
     */
    int maxVersion() default Integer.MAX_VALUE;

    /**
     * Returns true if a module is optional. A module is optional if a system
     * works without that module but is missing some functionality. Returns false if a system
     * won't work without the specified module.
     *
     * @return true if module is optional. False otherwise.
     */
    boolean optional() default false;
}

```
Kettle.xml
```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<device>
    <supportedModules>
        <entry>
            <key>DISPLAY</key>
            <value>2</value>
        </entry>
        <entry>
            <key>THERMOMETER</key>
            <value>1</value>
        </entry>
        <entry>
            <key>CLOCK</key>
            <value>4</value>
        </entry>
    </supportedModules>
</device>
```
# plugins
```java

package plugins;

import checker.Module;
import checker.Require;

/**
 * BoilerPlugin provides support for boiling water and keeping water warm.
 */
@Require(value = Module.CLOCK, maxVersion = 3)
@Require(value = Module.THERMOMETER)
@Require(value = Module.HEATER)
@Require(value = Module.LED, optional = true) //will use if present
public class BoilerPlugin {

    /**
     * Heats water up to 100 degrees Celsius.
     */
    public void boil() {
        boil(100);
    }

    /**
     * Heats water up to temperature.
     *
     * @param temperature - desired temperature of the water in the boiler
     */
    public void boil(int temperature) {
        /*
         * Turn on heater and wait while temperature reaches desired temperature
         * in Celsius. Finally, turn off heater.
         * If present, the LED light changes color according to the temperature.
         */
    }

    /**
     * Keeps desired temperature.
     *
     * @param temperature - desired temperature of the water in the boiler
     * @param seconds - period of time for checking temperature in seconds
     */
    public void keepWarm(int temperature, int seconds) {
        //Every n seconds check temperature and warm up, if necessary.
    }

}

```
```java

package plugins;

import checker.Module;
import checker.Require;
import java.util.Calendar;

/**
 * Introduces new features for BoilerPlugin. Features are boiling water by an
 * SMS and boiling water by date with notification by a phone call.
 */
@Require(value = Module.SPEAKER)
@Require(value = Module.GSM, minVersion = 3)
@Require(value = Module.DISPLAY)
public class ExtendedBoilerPlugin extends BoilerPlugin {

    /**
     * Boils water at the appointed time and wakes you up by a ring and phone
     * call. Shows "Good morning" and a quote of the day from the Internet on the
     * display.
     *
     * @param calendar - date and time when water should be boiled
     * @param phoneNumber - phone number to call
     */
    public void boilAndWakeUp(Calendar calendar, int phoneNumber) {
        //implementation
    }

    /**
     * Boils water at the appointed time by getting an SMS of fixed format.
     * Sends an SMS on finish.
     *
     * @param sms - text of SMS
     */
    public void boilBySMS(String sms) {
        //implementation
    }
}
```
```java
package plugins;

import checker.Module;
import checker.Require;

/**
 * Timer plug-in is used to support an alarm and a timer. It depends on Display and
 * Clock modules.
 */
@Require(Module.DISPLAY)
@Require(value = Module.CLOCK, maxVersion = 3)
public class TimerPlugin {

    /**
     * Sets timer.
     *
     * @param time - the remaining time.
     */
    public void timer(long time) {
        //start timer
        //show the remaining time on display
    }

    /**
     * Sets alarm.
     *
     * @param time - the alarm time.
     */
    public void alarm(long time) {
        //start alarm
        //show current time and alarm time on display
    }
}

```