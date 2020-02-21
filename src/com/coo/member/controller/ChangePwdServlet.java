package com.coo.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.coo.member.model.service.MemberService;
import com.coo.member.model.vo.Member;

/**
 * Servlet implementation class MemberChangePwdServlet
 */
@WebServlet("/changePwd.me")
public class ChangePwdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangePwdServlet() {
        super();
      
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String userId = request.getParameter("userId");	
		String userPwd = request.getParameter("userPwd");
		String changePwd1 = request.getParameter("changePwd1");
		
		int result = 0;
		//Member m = new Member();
				
/*		m.setEmpId("empId"); 
		m.setEmpPwd("empPwd"); 
		m.setChangePwd1("changePwd1");*/
		
//		System.out.println("회원 비밀번호 변경 확인" + m);
		
		result = new MemberService().MemberPwdChange(userId, userPwd, changePwd1);
		if(result == 0) {
			System.out.println("비밀번호 변경완료");								
		}else {
			System.out.println("");	
		}
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		doGet(request, response);
	}
}
