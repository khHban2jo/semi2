package com.coo.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.coo.exception.CooException;
import com.coo.member.model.service.MemberService;
import com.coo.member.model.vo.Member;

/**
 * Servlet implementation class MemberDeleteServlet
 */
@WebServlet("/mDelete.me")
public class MemberDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }  
  
	/**
	 * @param EmpId 
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

		
    	String empId = request.getParameter("userId");
		
	   MemberService ms = new MemberService();
	
	   ms.deleteMember(empId);
	  
	   response.getWriter().print("<html>");
		response.getWriter().print("<body>");
		response.getWriter().print("<script>");
		response.getWriter().print("window.setTimeout(function(){"+ 
				             "window.close();"+ 
			                 "},2000);");
		response.getWriter().print("</script>");
		response.getWriter().print("</body>");
		response.getWriter().print("</html>");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
