package com.coo.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.coo.exception.CooException;
import com.coo.member.model.service.MemberService;
import com.coo.member.model.vo.Member;
import com.coo.ta.model.service.MemberTAService;

/**
 * Servlet implementation class MemberInsertServlet
 */
@WebServlet("/mInsert.me")
public class MemberInsertServlet extends HttpServlet { 
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberInsertServlet() {
        super();
        
        
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	 
	    String userId = request.getParameter("userId");	
	    String personalId = request.getParameter("personalId");
		String userPwd = request.getParameter("userPwd");
		String empName = request.getParameter("empName");
		String eName = request.getParameter("eName");
		String email = request.getParameter("email");
		String gender = request.getParameter("gender");
		int age = Integer.parseInt(request.getParameter("age"));
		String contact =  request.getParameter("tel1") + "-"
		                + request.getParameter("tel2")+"-"
		                + request.getParameter("tel3");
		String phone  =  request.getParameter("phone1") + "-"
                        + request.getParameter("phone2") + "-"
                        + request.getParameter("phone3");
		
		String address = request.getParameter("address");  
		String deptCode = request.getParameter("deptCode"); 
		String jobCode = request.getParameter("jobCode");
		String etc = request.getParameter("etc");
		String subDept = request.getParameter("subDept");
        
	     Member m = new Member();
	     m.setEmpId(userId);
	     m.setEmpPwd(userPwd);
	     m.seteName(eName);
	     m.setEmpName(empName);
	     m.setEmail(email);
	     m.setGender(gender);
	     m.setAge(age);
	     m.setContact(contact);
	     m.setPhone(phone);
	     m.setAddress(address);
	     m.setDeptCode(deptCode);
	     m.setJobCode(jobCode);
	     m.setEtc(etc);
	     m.setPersonalId(personalId);
	     m.setSubDept(subDept);
	     
	     System.out.println("변경한 회원 정보 확인: "+ m);
	     
	     MemberService ms = new MemberService();
	     
		try {
			System.out.println("회원정보가입완료!");
			ms.insertMember(m);
		} catch (CooException e) {
			e.printStackTrace();
		}

		
		//	근태관련 코드 추가
		int l1Value = Integer.parseInt(request.getParameter("l1Value"));
		new MemberTAService().memberTaDataInsert(userId, l1Value);
		
		
		response.sendRedirect("views/home.jsp");
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
