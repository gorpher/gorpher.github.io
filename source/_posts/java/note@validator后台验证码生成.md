## servlet 方式
```java

import java.io.IOException;
import java.io.PrintWriter;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.util.Random;
import javax.imageio.ImageIO;


import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.*;
import javax.servlet.*;
import javax.servlet.jsp.*;

public class CheckCode extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public CheckCode() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session=request.getSession();
		int width = 62, height = 22;
		String[] ops={"+","-","*","/","="};
		BufferedImage buffImg = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		Graphics2D g = buffImg.createGraphics();

		g.setColor(Color.WHITE);
		g.fillRect(0, 0, width, height);

		g.setColor(Color.BLACK);
		g.drawRect(0, 0, width - 1, height - 1);

		g.setColor(Color.GRAY);
		Random random = new Random();			
		for (int i = 0; i < 40; i++) {		
		    int x1 = random.nextInt(width);
		    int y1 = random.nextInt(height);
		    int x2 = random.nextInt(10);
		    int y2 = random.nextInt(10);			
		    g.drawLine(x1, y1, x1 + x2, y1 + y2);
		}

		Font font = new Font("Times New Roman", Font.PLAIN, 18);
		g.setFont(font);

		    int num1=random.nextInt(10);
		    String strRand1 = String.valueOf(num1);
			int red1 = random.nextInt(255);
			int green1 = random.nextInt(255);
			int blue1 = random.nextInt(255);
			g.setColor(new Color(red1, green1, blue1));            
			g.drawString(strRand1, 13 *0 + 6, 16);
		   
		    int op_num=random.nextInt(4);
			String strRand2 =(String)ops[op_num];
			int red2 = random.nextInt(255);
			int green2 = random.nextInt(255);
			int blue2 = random.nextInt(255);
			g.setColor(new Color(red2, green2, blue2));            
			g.drawString(strRand2, 13 *1 + 6, 16);
		   
		    int num2=(random.nextInt(9)+1);	
			String strRand3 = String.valueOf(num2);
			int red3 = random.nextInt(255);
			int green3 = random.nextInt(255);
			int blue3 = random.nextInt(255);
			g.setColor(new Color(red3, green3, blue3));            
			g.drawString(strRand3, 13 *2 + 6, 16);
		   
			String strRand4 =(String)ops[4] ;
			int red4 = random.nextInt(255);
			int green4 = random.nextInt(255);
			int blue4 = random.nextInt(255);
			g.setColor(new Color(red4, green4, blue4));            
			g.drawString(strRand4, 13 *3 + 6, 16);
			
			Integer randomCode=0;
		    switch(op_num){
			case 0:
			        randomCode = num1+num2;
					break;
			case 1:
					randomCode = num1-num2;
					break;
			case 2:
				    randomCode = num1*num2;
					break;  
			case 3:
					randomCode = num1/num2;
					break;	
			}
		    session.setAttribute("randomCode", randomCode.toString());
			
		    buffImg.flush();
		    g.dispose();
		    response.setContentType("image/jpeg");
		    response.setHeader("Pragma", "no-cache");
		    response.setHeader("Cache-Control", "no-cache");
		    response.setDateHeader("Expires", 0);
		    ServletOutputStream outputStream = response.getOutputStream();
		    ImageIO.write(buffImg, "jpeg", outputStream);
		    outputStream.close();
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	public void init() throws ServletException {
		
	}

}

```

## springMVC 生成
```java

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.hibernate.mapping.Array;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @Author: wuxia
 * @date:2017年6月28日
 * @E-Mail:xia_wu@cxsoft.com.cn
 * @Package:com.cxsoft.web.validator
 * @DateTime: 下午2:56:53
 * @Description:验证码生成控制
 */
@Controller
public class CodeValidator {
	
	private static Logger logger = Logger.getLogger(CodeValidator.class);
	private int width = 70;//验证码宽度
    private int height = 30;//验证码高度
    private int codeCount = 4;//验证码个数
    private int lineCount = 10;//混淆线个数

    char[] codeSequence = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
            'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',
            'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };

    /**
     * 具体获取验证码的方法
     * @param time  time为时戳,这样的话可以避免浏览器缓存验证码
     * @throws IOException
     */
    @RequestMapping(value = "code.do",method = RequestMethod.GET)
    public void getCode( HttpServletRequest request,
                        HttpServletResponse response) throws IOException{
        //定义随机数类
        Random r = new Random();
        //定义存储验证码的类
        StringBuilder builderCode = new StringBuilder();
        //定义画布
        BufferedImage buffImg = new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);
        //得到画笔
        Graphics g = buffImg.getGraphics();
     
        //1.设置颜色,画边框
        g.setColor(Color.white);
        g.drawRect(0,0,width,height);
        //2.设置颜色,填充内部
        g.setColor(Color.white);
        g.fillRect(1,1,width,height);
        //3.设置干扰线
        g.setColor(Color.gray);
        for (int i = 0; i < lineCount; i++) {
            g.drawLine(r.nextInt(width),r.nextInt(width),r.nextInt(width),r.nextInt(width));
        }
        //4.设置验证码
        g.setColor(Color.blue);
        //4.1设置验证码字体
        g.setFont(new Font("宋体",Font.BOLD|Font.ITALIC,20));
        for (int i = 0; i < codeCount; i++) {
        	char c = codeSequence[r.nextInt(codeSequence.length)];
        	builderCode.append(c);
            g.drawString(c+"",15*i+5,20);
        }
        //5.输出到屏幕
        ServletOutputStream sos = response.getOutputStream();
        ImageIO.write(buffImg,"png",sos);
        //6.保存到session中
        HttpSession session = request.getSession();
        session.setAttribute("codeValidate",builderCode.toString());
        //7.禁止图像缓存。
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        response.setContentType("image/png");
        //8.关闭sos
        sos.close();
    }
}
```