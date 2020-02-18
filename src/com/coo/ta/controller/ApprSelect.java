package com.coo.ta.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.coo.check.model.vo.CheckDoc;
import com.coo.exception.CooException;
import com.coo.member.model.vo.Member;
import com.coo.ta.model.service.VacDocService;

/**
 * Servlet implementation class ApprSelect
 */
@WebServlet("/apSelect.ta")
public class ApprSelect extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ApprSelect() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		Member emp = (Member)session.getAttribute("member");
		int empCode = emp.getEmpCode();
		
		//	ATITLE , DOC_NUMBER, ASTATUS 필요
		ArrayList<CheckDoc> cdList = new ArrayList<CheckDoc>();
		try {
			cdList = new VacDocService().selectApprovalList(empCode);
		} catch (CooException e) {
			//	에러 발생 시
			request.setAttribute("msg", "결재 목록를 불러 오는 중 에러 발생!");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
		
//		PrintWriter out = response.getWriter();
//		out.print(cdList);
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}





