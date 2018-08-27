package com.lxf.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GetDetailInfo extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public GetDetailInfo() {
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
		String name = request.getParameter("name");
		if("张三".equals(name)){
			request.setAttribute("company", "山东浪潮股份有限公司");
			request.setAttribute("home", "济南很大名都");
		}else if("李四".equals(name)){
			request.setAttribute("company", "山东地纬股份邮箱公司");
			request.setAttribute("home", "山东凤凰城 ");
		}else{
			request.setAttribute("company", "请输入正确人员例如'张三''李四'");
			request.setAttribute("home", "请输入正确人员");
		}
		//------下面方式是直接使用客户端发送来的request，然后更新直接返回给客户端，是同一个request。 
		//路径是相对于应用的相对路径 最后是  http://localhost:8081/lxf/lxfjsp/ajax/detailInfo.jsp
		request.getRequestDispatcher("/lxfjsp/ajax/detailInfo.jsp").forward(request,response);
		//------下面方式是重定向，发送到客户端，客户端重新发送新的request，不是之前的request，如果传递参数需要在后缀添加。
		//路径是相对于服务器路径，需要加上应用根路径‘/lxf' ,这样才能得到：http://localhost:8081/lxf/lxfjsp/ajax/detailInfo.jsp
		//这种后缀参数，相当于parameter，通过request.getParameter获取，或者 ${param.company}
		/*String company="没有人员信息";
		String info = java.net.URLEncoder.encode(company,"UTF-8");
		response.sendRedirect("/lxf/lxfjsp/ajax/detailInfo.jsp?company="+info+"&home="+333333);*/
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doGet(request, response);
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
