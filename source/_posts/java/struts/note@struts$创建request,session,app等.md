/**
 *date:2016-10-19
 *author:matosiki
 *note:实现request,session,application等作用域或对象
 */
//1.method  解耦(map)的方式创建。
//此方法创建 的request,session,application只有存储键值队和作用域的特性
//不具有httpservlet对应的方法,
//该方法有两种创建 方式
//A、直接获取,通过ActionContext类获取request,session,application
//但是request并不能直接获取可调用get("request");方法实现一个存放 request的map

public class MyActionForScope extends ActionSupport{
	@Override
	public String execute() throws Exception {
		ActionContext ac = ActionContext.getContext();
		Map<String, Object> application = ac.getApplication();
		Map<String, Object> request = (Map<String, Object>)ac.get("request");
		Map<String, Object> session = ac.getSession();
		request.put("requestvalue", "设置request的值");
		session.put("sessionvalue", "设置session的值");
		application.put("aplicationvalue", "设置application的值");
		return "success";
	}
}
//B、实现struts2对应的接口：SessionAware,RequestAware,ApplicationAware，重写setXXX方法
public class MyActionForScope extends ActionSupport implements
	 RequestAware,SessionAware,ApplicationAware{
	private Map<String, Object> request;
	private Map<String, Object> session;
	private Map<String, Object> application;
	public void setApplication(Map<String, Object> application) {
			this.application=application;
	}
	public void setRequest(Map<String, Object> request) {
			this.request=request;
	}
	public void setSession(Map<String, Object> session) {
			this.session=session;
	}
	@Override
	public String execute() throws Exception {
		request.put("requestvalue", "设置request的值");
		session.put("sessionvalue", "设置session的值");
		application.put("aplicationvalue", "设置application的值");
		return "success";
	}
}

//2.method  耦合(servlet)的方式创建。
//此方法创建 的request,session,application 使用httpServletRequest,ServletContext接口设置属性值
//该方法有两种创建 方式

//A、直接利用ServletActionContext获取
public class MyActionForScope extends ActionSupport{
	@Override
	public String execute() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		ServletContext app = ServletActionContext.getServletContext();
		request.setAttribute("requestvalue", "设置request的值");
		HttpSession session = request.getSession();
		session.setAttribute("sessionvalue", "设置session的值");
		app.setAttribute("aplicationvalue", "设置application的值");

		return "success";
	}

}

//B、实现struts2对应的接口：ServletRequestAware,ServletContextAware，重写setXXX方法
public class MyActionForScope extends ActionSupport implements ServletRequestAware,ServletContextAware{
	  private HttpServletRequest request;
	  private ServletContext application;
	  public void setServletRequest(HttpServletRequest request) { 
		  this.request= request;
	  }
	  public void setServletContext(ServletContext application) {
	  this.application = application; 
	  }
	  
	  @Override 
	  public String execute() throws Exception {
	  request.setAttribute("requestvalue", "设置request的值");
	  HttpSession session= request.getSession(); 
	  session.setAttribute("sessionvalue","设置session的值"); 
	  application.setAttribute("aplicationvalue","设置application的值"); 
	  return "success";
	  }
}
总结：通过map的创建直接创建用ActionContext类，接口用RequestAware,SessionAware,ApplicationWare
      通过servlet的创建：直接创建用ServletActionContext类，接口用ServletrequestAware,ServletContextAware
