

一个包含模板方法的比较器栗子
```java

public  class TemplateMethod {
	void noName(){
		UserModel um1 = new UserModel("张飞",28);
		UserModel um2 = new UserModel("关羽",30);
		UserModel um3 = new UserModel("刘备",32);
		UserModel um4 = new UserModel("庞统",29);
		UserModel um5 = new UserModel("曹操",34);
		ArrayList<UserModel> list = new ArrayList<UserModel>();
		list.add(um1);
		list.add(um2);
		list.add(um3);
		list.add(um4);
		list.add(um5);
		
		System.out.println("排序前:------------");
		
		printList(list);
		
		Comparator<UserModel> c = new Comparator<UserModel>() {
			public int compare(UserModel o1, UserModel o2) {
				return o1.getuAge()-o2.getuAge();
			};
		};
		Collections.sort(list,c);
		System.out.println("排序后:----------------");
		printList(list);
	}
	private void printList(ArrayList<UserModel> list) {
		for (UserModel um : list) {
			System.out.println(um);
		}
		
	}
	public static void main(String[] args) {
			TemplateMethod st = new TemplateMethod();
			st.noName();
	}

}
class UserModel{
	String uName;
	int uAge;
	public UserModel() {}
	
	@Override
	public String toString() {
		return "UserModel [uName=" + uName + ", uAge=" + uAge + "]";
	}
	public UserModel(String uName, int uAge) {
		super();
		this.uName = uName;
		this.uAge = uAge;
	}
	public String getuName() {
		return uName;
	}
	public void setuName(String uName) {
		this.uName = uName;
	}
	public int getuAge() {
		return uAge;
	}
	public void setuAge(int uAge) {
		this.uAge = uAge;
	}
}
```