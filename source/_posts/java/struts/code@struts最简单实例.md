import java.util.Date;

import com.opensymphony.xwork2.ActionSupport;

public class UserAction extends ActionSupport {//定义一个UserAction类并使之继承ActionSupport
	private String name;
	private String password;
	private String date = new Date().toLocaleString();
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String addName() {
		System.out.println(this.getName() + "   " + this.getPassword()
				+ " hjhjhj");
		if (!this.getPassword().equals("") && !this.getName().equals("")) {
			return "success";
		} else {
			return "fail";
		}
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
}
