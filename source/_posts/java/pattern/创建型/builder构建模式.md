# 栗子
```java
/*
 *  An abstract Builder
 */
public abstract class HouseBuilder  {
    public abstract void BuildRoom(int roomNo);
    public abstract void BuildDoor(int room1, int room2);
    public abstract House getHouse();
}
```
```java
public class ConcreteHouseBuilderA  extends HouseBuilder{
    private House house;  
    public ConcreteHouseBuilderA() {
        house = new House();
    }
    public void BuildRoom(int roomNo) {
        //you can create a new Room added to a House
        house.roomNumber++;
    }

    public void BuildDoor(int room1, int room2) {
        // you can create a new door assotiated with 2 room
        // and added this door into a house 
        house.doorNumber++;
    }

    public House getHouse() {
        return house;
    }
}
```
```java
/*
 *  A house as a concrete product we got finally
 */
public class House  {
    int roomNumber;
    int doorNumber;
    public House() {
        roomNumber = 0;
        doorNumber = 0;
    }
    public int getRoomNumber() {
        return roomNumber;
    }
    
    public int getDoorNumber() {
        return doorNumber;
    }
}
```
```java
/*
 *  This class is a Director
 */
public class HouseDirector  {
    public void CreateHouse(HouseBuilder concreteBuilder) {
        concreteBuilder.BuildRoom(1);
        concreteBuilder.BuildRoom(2);
        concreteBuilder.BuildDoor(1, 2);

        //return builder.getHouse();
    }
}
```
```java
/*
 *  A test client to create a house
 *  but we do not know how the room and door be created
 */
public class TestClient  {
    public TestClient() {
    }

    public static void main(String[] args) {
        House myHouse = new House();
        ConcreteHouseBuilderA myHouseBuilder = new ConcreteHouseBuilderA();
        HouseDirector myHouseDirector = new HouseDirector();
        myHouseDirector.CreateHouse(myHouseBuilder);
        myHouse = myHouseBuilder.getHouse();

        System.out.println("My house has room :" + myHouse.getRoomNumber());
        System.out.println("My house has door :" + myHouse.getDoorNumber());
    }
}
```
