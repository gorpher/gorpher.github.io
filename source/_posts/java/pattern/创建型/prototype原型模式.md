# 栗子
GraphicTool.java
```java
/*
 *  As  a Test Client to test our pattern  
 */
import java.util.*;
import java.lang.*;

public class GraphicTool  {
    public GraphicTool() {
    }

    public static void main(String[] args) {
        //-----  Initial our prototype instance  ---------- 
        SymbolLoader myLoader = new SymbolLoader();
        Hashtable mySymbols = myLoader.getSymbols();

        //-----  Draw a Line  -------------------------------
        Graphic myLine = (Graphic)((Graphic)mySymbols.get("Line")).clone();
        myLine.DoSomething();
    }
```
```java
/*
 * A Graphic Interface ( A prototype interface )
 */
import java.io.*;

public interface IGraphic extends Cloneable, Serializable {
    public String getName() ;
    public void setName(String gName);
}
```
```java
/*
 * An Abstract Graphic Class ( Prototype )
 */
import java.lang.*;
import java.io.*;

public abstract class Graphic implements IGraphic {
    private String name;
    
    public Object clone() {
        try {
            return super.clone();
        } catch (CloneNotSupportedException e){
            System.out.println("Do not support clone !!!");
            throw new InternalError();
        }
    }
   
    public String getName() {
        return name;
    }
    
    public void setName(String gName) {
        name = gName;
    }

    public abstract void DoSomething();
}
```
```java
/*
 *  A Symbol Loader to register all prototype instance
 */
import java.util.*;

public class SymbolLoader  {
    private Hashtable symbols = new Hashtable();
    public SymbolLoader() {
           symbols.put("Line", new LineSymbol());
           symbols.put("Note", new NoteSymbol());
    }
    public Hashtable getSymbols() {
        return symbols;
    }
}
```

```java
/*
 *  A concrete prototype to draw a note
 */
public class NoteSymbol extends Graphic {
    public NoteSymbol() {
    }

    public void DoSomething() {
        System.out.println("I am used to draw a note !");
    }
}
```

```java
/*
 *  A concrete prototype to draw a line
 */
public class LineSymbol extends Graphic {
    public LineSymbol() {
    }

    public void DoSomething() {
        System.out.println("I am used to draw a line !");
    }
}
```