package com.coo.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.coo.check.model.vo.StockLine;
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
		String subDept = request.getParameter("cr2");
        
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
		
		// 결제 정 / 부 관련 추가
		int empCode = Integer.parseInt(request.getParameter("empCode"));
		String deptCodeA = request.getParameter("cr2");
		String subcrA = request.getParameter("cr");
		int subDeptCode = Integer.parseInt(request.getParameter("cr3"));
		System.out.println(subcrA);
//		String subDeptA = request.getParameter("subDeptA");
		
		StockLine d = new StockLine();
		int result = 0;
		if(subcrA.equals("1")) {
			d.setEmpcode(empCode);
			d.setDeptCode(deptCodeA);
			d.setSubcode(subDeptCode);
			result = new MemberService().insertStockLine(d);
		}else if(subcrA.equals("2")) {
			d.setSubcode(empCode);
			d.setDeptCode(deptCodeA);
			d.setEmpcode(subDeptCode);
			result = new MemberService().insertStockLine(d);
		}
		
		if(result > 0) {
			System.out.println("성공");
		}
		
		//	근태관련 코드 추가
		new MemberTAService().memberTaDataInsert(userId);
		
		response.getWriter().print("<html>");
		response.getWriter().print("<body>");
		response.getWriter().print("<script>");
		response.getWriter().print("window.setTimeout(function(){"+ 
				             "window.close();"+ 
			                 "},1000);");
		response.getWriter().print("</script>");
		response.getWriter().print("</body>");
		response.getWriter().print("</html>");
		
		response.sendRedirect("views/home.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
