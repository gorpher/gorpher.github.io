<?xml version="1.0" encoding="UTF-8" ?>

<!-- 这个是default-Struts文件 在自己配置Struts.xml文件的时候 package会默认extend一个default-struts 然而这个就是他的原文件 -->
<!DOCTYPE struts PUBLIC
    "-//Apache Software Foundation//DTD Struts Configuration 2.1.7//EN"
    "http://struts.apache.org/dtds/struts-2.1.7.dtd">
<struts>

    <bean class="com.opensymphony.xwork2.ObjectFactory" name="xwork" />
    <bean type="com.opensymphony.xwork2.ObjectFactory" name="struts" class="org.apache.struts2.impl.StrutsObjectFactory" />

    <bean type="com.opensymphony.xwork2.ActionProxyFactory" name="xwork" class="com.opensymphony.xwork2.DefaultActionProxyFactory"/>
    <bean type="com.opensymphony.xwork2.ActionProxyFactory" name="struts" class="org.apache.struts2.impl.StrutsActionProxyFactory"/>
    <!--    下面配置了Struts 2 的3个类型检测器 Bean-->
    <bean type="com.opensymphony.xwork2.conversion.ObjectTypeDeterminer" name="tiger" class="com.opensymphony.xwork2.conversion.impl.DefaultObjectTypeDeterminer"/>
    <bean type="com.opensymphony.xwork2.conversion.ObjectTypeDeterminer" name="notiger" class="com.opensymphony.xwork2.conversion.impl.DefaultObjectTypeDeterminer"/>
    <bean type="com.opensymphony.xwork2.conversion.ObjectTypeDeterminer" name="struts" class="com.opensymphony.xwork2.conversion.impl.DefaultObjectTypeDeterminer"/>

    <bean type="com.opensymphony.xwork2.util.PatternMatcher" name="struts" class="com.opensymphony.xwork2.util.WildcardHelper" />
    <bean type="com.opensymphony.xwork2.util.PatternMatcher" name="namedVariable" class="com.opensymphony.xwork2.util.NamedVariablePatternMatcher"/>

    <bean type="org.apache.struts2.dispatcher.mapper.ActionMapper" name="struts" class="org.apache.struts2.dispatcher.mapper.DefaultActionMapper" />
    <bean type="org.apache.struts2.dispatcher.mapper.ActionMapper" name="composite" class="org.apache.struts2.dispatcher.mapper.CompositeActionMapper" />
    <bean type="org.apache.struts2.dispatcher.mapper.ActionMapper" name="restful" class="org.apache.struts2.dispatcher.mapper.RestfulActionMapper" />
    <bean type="org.apache.struts2.dispatcher.mapper.ActionMapper" name="restful2" class="org.apache.struts2.dispatcher.mapper.Restful2ActionMapper" />
      <!--    下面配置了Struts 2 的2个文件上传处理器 Bean-->
    <bean type="org.apache.struts2.dispatcher.multipart.MultiPartRequest" name="struts" class="org.apache.struts2.dispatcher.multipart.JakartaMultiPartRequest" scope="default"/>
    <bean type="org.apache.struts2.dispatcher.multipart.MultiPartRequest" name="jakarta" class="org.apache.struts2.dispatcher.multipart.JakartaMultiPartRequest" scope="default" />
    <constant name="struts.multipart.handler" value="jakarta" />

    <bean type="org.apache.struts2.views.TagLibrary" name="s" class="org.apache.struts2.views.DefaultTagLibrary" />

    <bean class="org.apache.struts2.views.freemarker.FreemarkerManager" name="struts" />
    <bean class="org.apache.struts2.views.velocity.VelocityManager" name="struts" optional="true" />
      <!--    下面配置了Struts 2 的3个模板引擎管理器 Bean-->
    <bean class="org.apache.struts2.components.template.TemplateEngineManager" />
    <bean type="org.apache.struts2.components.template.TemplateEngine" name="ftl" class="org.apache.struts2.components.template.FreemarkerTemplateEngine" />
    <bean type="org.apache.struts2.components.template.TemplateEngine" name="vm" class="org.apache.struts2.components.template.VelocityTemplateEngine" />
    <bean type="org.apache.struts2.components.template.TemplateEngine" name="jsp" class="org.apache.struts2.components.template.JspTemplateEngine" />

    <bean type="com.opensymphony.xwork2.conversion.impl.XWorkConverter" name="struts" class="com.opensymphony.xwork2.conversion.impl.XWorkConverter" />
    <bean type="com.opensymphony.xwork2.conversion.impl.XWorkConverter" name="xwork1" class="com.opensymphony.xwork2.conversion.impl.XWorkConverter" />
    <bean class="com.opensymphony.xwork2.conversion.impl.XWorkBasicConverter" />

    <bean type="com.opensymphony.xwork2.TextProvider" name="xwork1" class="com.opensymphony.xwork2.TextProviderSupport" scope="default" />
    <bean type="com.opensymphony.xwork2.TextProvider" name="struts" class="com.opensymphony.xwork2.TextProviderSupport" scope="default" />

    <bean type="org.apache.struts2.components.UrlRenderer" name="struts" class="org.apache.struts2.components.ServletUrlRenderer"/>

    <bean type="com.opensymphony.xwork2.util.ValueStackFactory" name="struts" class="com.opensymphony.xwork2.ognl.OgnlValueStackFactory" />
    <bean type="com.opensymphony.xwork2.util.reflection.ReflectionProvider" name="struts" class="com.opensymphony.xwork2.ognl.OgnlReflectionProvider" />
    <bean type="com.opensymphony.xwork2.util.reflection.ReflectionContextFactory" name="struts" class="com.opensymphony.xwork2.ognl.OgnlReflectionContextFactory" />

    <bean type="com.opensymphony.xwork2.TextProvider" name="system" class="com.opensymphony.xwork2.DefaultTextProvider" />
    <bean type="com.opensymphony.xwork2.conversion.NullHandler" name="java.lang.Object" class="com.opensymphony.xwork2.conversion.impl.InstantiatingNullHandler" />

    <bean type="com.opensymphony.xwork2.validator.ActionValidatorManager" name="struts" class="com.opensymphony.xwork2.validator.AnnotationActionValidatorManager" />
    <bean type="com.opensymphony.xwork2.validator.ActionValidatorManager" name="no-annotations" class="com.opensymphony.xwork2.validator.DefaultActionValidatorManager" />

    <bean type="com.opensymphony.xwork2.validator.ValidatorFactory" class="com.opensymphony.xwork2.validator.DefaultValidatorFactory"/>
    <bean type="com.opensymphony.xwork2.validator.ValidatorFileParser" class="com.opensymphony.xwork2.validator.DefaultValidatorFileParser" />

    <bean class="com.opensymphony.xwork2.ognl.OgnlUtil" />

    <bean type="ognl.PropertyAccessor" name="com.opensymphony.xwork2.util.CompoundRoot" class="com.opensymphony.xwork2.ognl.accessor.CompoundRootAccessor" />
    <bean type="ognl.PropertyAccessor" name="java.lang.Object" class="com.opensymphony.xwork2.ognl.accessor.ObjectAccessor" />
    <bean type="ognl.PropertyAccessor" name="java.util.Iterator" class="com.opensymphony.xwork2.ognl.accessor.XWorkIteratorPropertyAccessor" />
    <bean type="ognl.PropertyAccessor" name="java.util.Enumeration" class="com.opensymphony.xwork2.ognl.accessor.XWorkEnumerationAccessor" />
    <bean type="ognl.PropertyAccessor" name="java.util.List" class="com.opensymphony.xwork2.ognl.accessor.XWorkListPropertyAccessor" />
    <bean type="ognl.PropertyAccessor" name="java.util.Set" class="com.opensymphony.xwork2.ognl.accessor.XWorkCollectionPropertyAccessor" />
    <bean type="ognl.PropertyAccessor" name="java.util.Map" class="com.opensymphony.xwork2.ognl.accessor.XWorkMapPropertyAccessor" />
    <bean type="ognl.PropertyAccessor" name="java.util.Collection" class="com.opensymphony.xwork2.ognl.accessor.XWorkCollectionPropertyAccessor" />
    <bean type="ognl.PropertyAccessor" name="com.opensymphony.xwork2.ognl.ObjectProxy" class="com.opensymphony.xwork2.ognl.accessor.ObjectProxyPropertyAccessor" />

    <bean type="ognl.MethodAccessor" name="java.lang.Object" class="com.opensymphony.xwork2.ognl.accessor.XWorkMethodAccessor" />
    <bean type="ognl.MethodAccessor" name="com.opensymphony.xwork2.util.CompoundRoot" class="com.opensymphony.xwork2.ognl.accessor.CompoundRootAccessor" />

    <bean class="org.apache.struts2.views.jsp.ui.OgnlTool" />

    <bean type="org.apache.struts2.dispatcher.StaticContentLoader" class="org.apache.struts2.dispatcher.DefaultStaticContentLoader" name="struts" />
    <bean type="com.opensymphony.xwork2.UnknownHandlerManager" class="com.opensymphony.xwork2.DefaultUnknownHandlerManager" name="struts" />

    <!--  Silly workarounds for OGNL since there is currently no way to flush its internal caches -->
    <bean type="ognl.PropertyAccessor" name="java.util.ArrayList" class="com.opensymphony.xwork2.ognl.accessor.XWorkListPropertyAccessor" />
    <bean type="ognl.PropertyAccessor" name="java.util.HashSet" class="com.opensymphony.xwork2.ognl.accessor.XWorkCollectionPropertyAccessor" />
    <bean type="ognl.PropertyAccessor" name="java.util.HashMap" class="com.opensymphony.xwork2.ognl.accessor.XWorkMapPropertyAccessor" />

    <package name="struts-default" abstract="true">
        <result-types>
		<!-- action链式处理的结果类型->  
            <result-type name="chain" class="com.opensymphony.xwork2.ActionChainResult"/>
            <!---用于转发url的结果类型，一般转发的是jsp页面->
	    <result-type name="dispatcher" class="org.apache.struts2.dispatcher.ServletDispatcherResult" default="true"/>
           <!-- 用于与freeMarker整个的结果类型-->
	    <result-type name="freemarker" class="org.apache.struts2.views.freemarker.FreemarkerResult"/>
            <!--用于控制http头的结果类型-->
	    <result-type name="httpheader" class="org.apache.struts2.dispatcher.HttpHeaderResult"/>
            <!--用于重定向结果类型 -->
	    <result-type name="redirect" class="org.apache.struts2.dispatcher.ServletRedirectResult"/>
	     <!--用于重定向的其他action 的结果类型 -->
            <result-type name="redirectAction" class="org.apache.struts2.dispatcher.ServletActionRedirectResult"/>
		<!-- 用于向客户端输出字节流的结果类型-->
            <result-type name="stream" class="org.apache.struts2.dispatcher.StreamResult"/>
		<!-- 用于整合velocity的结果类型-->
            <result-type name="velocity" class="org.apache.struts2.dispatcher.VelocityResult"/>
		<!-- 用于整合xml/xslt的结果类型-->
            <result-type name="xslt" class="org.apache.struts2.views.xslt.XSLTResult"/>
		<!-- 用于显示页面原始代码的结果类型-->
            <result-type name="plainText" class="org.apache.struts2.dispatcher.PlainTextResult" />
        </result-types>
  
        <interceptors>
            <interceptor name="alias" class="com.opensymphony.xwork2.interceptor.AliasInterceptor"/>
            <interceptor name="autowiring" class="com.opensymphony.xwork2.spring.interceptor.ActionAutowiringInterceptor"/>
            <interceptor name="chain" class="com.opensymphony.xwork2.interceptor.ChainingInterceptor"/>
            <interceptor name="conversionError" class="org.apache.struts2.interceptor.StrutsConversionErrorInterceptor"/>
            <interceptor name="cookie" class="org.apache.struts2.interceptor.CookieInterceptor"/>
            <interceptor name="clearSession" class="org.apache.struts2.interceptor.ClearSessionInterceptor" />
            <interceptor name="createSession" class="org.apache.struts2.interceptor.CreateSessionInterceptor" />
            <interceptor name="debugging" class="org.apache.struts2.interceptor.debugging.DebuggingInterceptor" />
            <interceptor name="externalRef" class="com.opensymphony.xwork2.interceptor.ExternalReferencesInterceptor"/>
            <interceptor name="execAndWait" class="org.apache.struts2.interceptor.ExecuteAndWaitInterceptor"/>
            <interceptor name="exception" class="com.opensymphony.xwork2.interceptor.ExceptionMappingInterceptor"/>
            <interceptor name="fileUpload" class="org.apache.struts2.interceptor.FileUploadInterceptor"/>
            <interceptor name="i18n" class="com.opensymphony.xwork2.interceptor.I18nInterceptor"/>
            <interceptor name="logger" class="com.opensymphony.xwork2.interceptor.LoggingInterceptor"/>
            <interceptor name="modelDriven" class="com.opensymphony.xwork2.interceptor.ModelDrivenInterceptor"/>
            <interceptor name="scopedModelDriven" class="com.opensymphony.xwork2.interceptor.ScopedModelDrivenInterceptor"/>
            <interceptor name="params" class="com.opensymphony.xwork2.interceptor.ParametersInterceptor"/>
            <interceptor name="actionMappingParams" class="org.apache.struts2.interceptor.ActionMappingParametersInteceptor"/>
            <interceptor name="prepare" class="com.opensymphony.xwork2.interceptor.PrepareInterceptor"/>
            <interceptor name="staticParams" class="com.opensymphony.xwork2.interceptor.StaticParametersInterceptor"/>
            <interceptor name="scope" class="org.apache.struts2.interceptor.ScopeInterceptor"/>
            <interceptor name="servletConfig" class="org.apache.struts2.interceptor.ServletConfigInterceptor"/>
            <interceptor name="sessionAutowiring" class="org.apache.struts2.spring.interceptor.SessionContextAutowiringInterceptor"/>
            <interceptor name="timer" class="com.opensymphony.xwork2.interceptor.TimerInterceptor"/>
            <interceptor name="token" class="org.apache.struts2.interceptor.TokenInterceptor"/>
            <interceptor name="tokenSession" class="org.apache.struts2.interceptor.TokenSessionStoreInterceptor"/>
            <interceptor name="validation" class="org.apache.struts2.interceptor.validation.AnnotationValidationInterceptor"/>
            <interceptor name="workflow" class="com.opensymphony.xwork2.interceptor.DefaultWorkflowInterceptor"/>
            <interceptor name="store" class="org.apache.struts2.interceptor.MessageStoreInterceptor" />
            <interceptor name="checkbox" class="org.apache.struts2.interceptor.CheckboxInterceptor" />
            <interceptor name="profiling" class="org.apache.struts2.interceptor.ProfilingActivationInterceptor" />
            <interceptor name="roles" class="org.apache.struts2.interceptor.RolesInterceptor" />
            <interceptor name="jsonValidation" class="org.apache.struts2.interceptor.validation.JSONValidationInterceptor" />
            <interceptor name="annotationWorkflow" class="com.opensymphony.xwork2.interceptor.annotations.AnnotationWorkflowInterceptor" />
            <interceptor name="multiselect" class="org.apache.struts2.interceptor.MultiselectInterceptor" />

            <!-- Basic stack -->
            <interceptor-stack name="basicStack">
                <interceptor-ref name="exception"/>
                <interceptor-ref name="servletConfig"/>
                <interceptor-ref name="prepare"/>
                <interceptor-ref name="checkbox"/>
                <interceptor-ref name="multiselect"/>
                <interceptor-ref name="actionMappingParams"/>
                <interceptor-ref name="params">
                    <param name="excludeParams">dojo\..*,^struts\..*</param>
                </interceptor-ref>
                <interceptor-ref name="conversionError"/>
            </interceptor-stack>

            <!-- Sample validation and workflow stack -->
            <interceptor-stack name="validationWorkflowStack">
                <interceptor-ref name="basicStack"/>
                <interceptor-ref name="validation"/>
                <interceptor-ref name="workflow"/>
            </interceptor-stack>

            <!-- Sample JSON validation stack -->
            <interceptor-stack name="jsonValidationWorkflowStack">
                <interceptor-ref name="basicStack"/>
                <interceptor-ref name="validation">
                    <param name="excludeMethods">input,back,cancel</param>
                </interceptor-ref>
                <interceptor-ref name="jsonValidation"/>
                <interceptor-ref name="workflow"/>
            </interceptor-stack>

            <!-- Sample file upload stack -->
            <interceptor-stack name="fileUploadStack">
                <interceptor-ref name="fileUpload"/>
                <interceptor-ref name="basicStack"/>
            </interceptor-stack>

            <!-- Sample model-driven stack  -->
            <interceptor-stack name="modelDrivenStack">
                <interceptor-ref name="modelDriven"/>
                <interceptor-ref name="basicStack"/>
            </interceptor-stack>

            <!-- Sample action chaining stack -->
            <interceptor-stack name="chainStack">
                <interceptor-ref name="chain"/>
                <interceptor-ref name="basicStack"/>
            </interceptor-stack>

            <!-- Sample i18n stack -->
            <interceptor-stack name="i18nStack">
                <interceptor-ref name="i18n"/>
                <interceptor-ref name="basicStack"/>
            </interceptor-stack>

            <!-- An example of the paramsPrepareParams trick. This stack
                 is exactly the same as the defaultStack, except that it
                 includes one extra interceptor before the prepare interceptor:
                 the params interceptor.

                 This is useful for when you wish to apply parameters directly
                 to an object that you wish to load externally (such as a DAO
                 or database or service layer), but can't load that object
                 until at least the ID parameter has been loaded. By loading
                 the parameters twice, you can retrieve the object in the
                 prepare() method, allowing the second params interceptor to
                 apply the values on the object. -->
            <interceptor-stack name="paramsPrepareParamsStack">
                <interceptor-ref name="exception"/>
                <interceptor-ref name="alias"/>
                <interceptor-ref name="i18n"/>
                <interceptor-ref name="checkbox"/>
                <interceptor-ref name="multiselect"/>
                <interceptor-ref name="params">
                    <param name="excludeParams">dojo\..*,^struts\..*</param>
                </interceptor-ref>
                <interceptor-ref name="servletConfig"/>
                <interceptor-ref name="prepare"/>
                <interceptor-ref name="chain"/>
                <interceptor-ref name="modelDriven"/>
                <interceptor-ref name="fileUpload"/>
                <interceptor-ref name="staticParams"/>
                <interceptor-ref name="actionMappingParams"/>
                <interceptor-ref name="params">
                    <param name="excludeParams">dojo\..*,^struts\..*</param>
                </interceptor-ref>
                <interceptor-ref name="conversionError"/>
                <interceptor-ref name="validation">
                    <param name="excludeMethods">input,back,cancel,browse</param>
                </interceptor-ref>
                <interceptor-ref name="workflow">
                    <param name="excludeMethods">input,back,cancel,browse</param>
                </interceptor-ref>
            </interceptor-stack>

            <!-- A complete stack with all the common interceptors in place.
                 Generally, this stack should be the one you use, though it
                 may do more than you need. Also, the ordering can be
                 switched around (ex: if you wish to have your servlet-related
                 objects applied before prepare() is called, you'd need to move
                 servletConfig interceptor up.

                 This stack also excludes from the normal validation and workflow
                 the method names input, back, and cancel. These typically are
                 associated with requests that should not be validated.
                 -->
            <interceptor-stack name="defaultStack">
                <interceptor-ref name="exception"/>
                <interceptor-ref name="alias"/>
                <interceptor-ref name="servletConfig"/>
                <interceptor-ref name="i18n"/>
                <interceptor-ref name="prepare"/>
                <interceptor-ref name="chain"/>
                <interceptor-ref name="debugging"/>
                <interceptor-ref name="scopedModelDriven"/>
                <interceptor-ref name="modelDriven"/>
                <interceptor-ref name="fileUpload"/>
                <interceptor-ref name="checkbox"/>
                <interceptor-ref name="multiselect"/>
                <interceptor-ref name="staticParams"/>
                <interceptor-ref name="actionMappingParams"/>
                <interceptor-ref name="params">
                  <param name="excludeParams">dojo\..*,^struts\..*</param>
                </interceptor-ref>
                <interceptor-ref name="conversionError"/>
                <interceptor-ref name="validation">
                    <param name="excludeMethods">input,back,cancel,browse</param>
                </interceptor-ref>
                <interceptor-ref name="workflow">
                    <param name="excludeMethods">input,back,cancel,browse</param>
                </interceptor-ref>
            </interceptor-stack>

            <!-- The completeStack is here for backwards compatibility for
                 applications that still refer to the defaultStack by the
                 old name -->
            <interceptor-stack name="completeStack">
                <interceptor-ref name="defaultStack"/>
            </interceptor-stack>

            <!-- Sample execute and wait stack.
                 Note: execAndWait should always be the *last* interceptor. -->
            <interceptor-stack name="executeAndWaitStack">
                <interceptor-ref name="execAndWait">
                    <param name="excludeMethods">input,back,cancel</param>
                </interceptor-ref>
                <interceptor-ref name="defaultStack"/>
                <interceptor-ref name="execAndWait">
                    <param name="excludeMethods">input,back,cancel</param>
                </interceptor-ref>
            </interceptor-stack>

       </interceptors>
        <default-interceptor-ref name="defaultStack"/>
        <default-class-ref class="com.opensymphony.xwork2.ActionSupport" />
    </package>

</struts>
