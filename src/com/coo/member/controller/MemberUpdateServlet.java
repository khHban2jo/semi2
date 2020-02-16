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
       String empPwd = request.getParameter("empPwd");
       String empName = request.getParameter("empName");
       String email = request.getParameter("email");
       String contact = request.getParameter("tel1")+"-" +
    		            request.getParameter("tel2")+"-" +
    		            request.getParameter("tel3");
    		            
       String phone = request.getParameter("phone1")+"-" +
	                  request.getParameter("phone2")+"-" +
	                  request.getParameter("phone3");
       
       String address = request.getParameter("address");
       String etc = request.getParameter("etc");
       
       String subDept = request.getParameter("subDept");
       String deptCode = request.getParameter("deptCode");
       String jobCode = request.getParameter("jobCode");
       
       Member m = new Member();
       
       m.setEmpPwd(empPwd);
       m.setEmpName(empName);
       
       m.setEmail(email);
       m.setDeptCode(deptCode);
       m.setJobCode(jobCode);
       m.setContact(contact);
       
       m.setPhone(phone);
       m.setAddress(address);
       m.setEtc(etc);
       
       m.setSubDept(subDept);
       
       System.out.println("변경한 회원 정보 확인:" + m);
       
       MemberService ms = new MemberService();
       
       ms.updateMember(m);
        System.out.println("회원 정보 수정 완료!");
        try {
        	response.sendRedirect("views/home.jsp");
        }catch(IOException e) {
        	e.printStackTrace();
        }
       
    		   
	
	}
	private void forward(HttpServletRequest request, HttpServletResponse response ) {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}