package com.coo.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.coo.member.model.service.MemberService;
import com.coo.member.model.vo.Member;

/**
 * Servlet implementation class MemberUpdateServlet
 */
@WebServlet("/mUpdate.me")
public class MemberUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       String empPwd = request.getParameter("userPwd");
       String empName = request.getParameter("empName");
       String email = request.getParameter("email");
       String eName = request.getParameter("eName");
       String contact = request.getParameter("tel1")+"-" +
    		            request.getParameter("tel2")+"-" +
    		            request.getParameter("tel3");
       String personalId = request.getParameter("personalId");
       int empCode =Integer.parseInt(request.getParameter("empCode"));
       String phone = request.getParameter("phone1")+"-" +
	                  request.getParameter("phone2")+"-" +
	                  request.getParameter("phone3");
       
       String address = request.getParameter("zipCode") + ", " + 
    		   			request.getParameter("address1") + ", " +
    		   			request.getParameter("address2");
       String etc = request.getParameter("etc");
       
       String subDept = request.getParameter("cr2");
       String deptCode = request.getParameter("deptCode");
       String jobCode = request.getParameter("jobCode");
       
       Member m = new Member();
       
       m.setEmpPwd(empPwd);
       m.setEmpName(empName);
       m.setPersonalId(personalId);
       m.setEmail(email);
       m.setDeptCode(deptCode);
       m.setJobCode(jobCode);
       m.setContact(contact);
       m.seteName(eName);
       m.setPhone(phone);
       m.setAddress(address);
       m.setEtc(etc);
       m.setEmpCode(empCode); 
       m.setSubDept(subDept);
       
       System.out.println(m);
       MemberService ms = new MemberService();       
  	
       ms.updateMember(m);
     
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
