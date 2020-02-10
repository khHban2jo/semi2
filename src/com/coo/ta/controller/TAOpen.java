package com.coo.ta.controller;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.coo.exception.CooException;
import com.coo.member.model.vo.Member;
import com.coo.ta.model.service.WorkTimeService;

/**
 * Servlet implementation class TAOpen
 */
@WebServlet("/open.ta")
public class TAOpen extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TAOpen() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//	접속한 유저 EMP_CODE 받기
		HttpSession session = request.getSession();
		Member emp = (Member)session.getAttribute("member");
		int empCode = emp.getEmpCode();
		
		try {
			//	empCode로 출,퇴근 시간 받아오기
			HashMap wtMap = new WorkTimeService().selectWorkTime(empCode);
			
			//	T1 또는 T2의 값을 못 찾았다면 String 값 넣어주기
			if(wtMap.get(0) == null) {
				wtMap.put(0, "출근전");
			}
			if(wtMap.get(1) == null) {
				wtMap.put(1, "퇴근전");
			}
			
			request.setAttribute("wtMap", wtMap);
			request.getRequestDispatcher("views/popup/TA.jsp").forward(request, response);
			
		} catch (CooException e) {

			//	에러 발생 시
			request.setAttribute("msg", "출근 시간을 찾아오는 중 에러 발생!");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
			
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}













