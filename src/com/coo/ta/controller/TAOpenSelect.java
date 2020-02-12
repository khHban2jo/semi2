package com.coo.ta.controller;

import java.io.IOException;
import java.util.Calendar;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.coo.exception.CooException;
import com.coo.member.model.vo.Member;
import com.coo.ta.model.service.TaDataService;
import com.coo.ta.model.service.WeekOverTimeService;
import com.coo.ta.model.service.WorkTimeService;
import com.coo.ta.model.vo.TaData;
import com.coo.ta.model.vo.WeekOverTime;

/**
 * Servlet implementation class TAOpen
 */
@WebServlet("/open.ta")
public class TAOpenSelect extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TAOpenSelect() {
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
			HashMap<Integer, String> wtMap = new WorkTimeService().selectWorkTime(empCode);
			System.out.println("근태관리 open [WORKTIME SELECT]");
			request.setAttribute("wtMap", wtMap);
		} catch (CooException e) {
			//	에러 발생 시
			request.setAttribute("msg", "출근/퇴근 시간을 불러오는 중 에러 발생!");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}

		//	empCode로 TA_DATA 테이블 값 받아오기
		try {
			TaData td = new TaDataService().selectOne(empCode);
			
			System.out.println("근태관리 open [TA_DATA SELECT]");
			request.setAttribute("td", td);
		} catch (CooException e) {
			//	에러 발생 시
			request.setAttribute("msg", "근무 현황을 불러오는 중 에러 발생!");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
		
		//	empCode로 WEEK_OVERTIEM 테이블 값 받아오기
		Calendar cal = Calendar.getInstance();
		int week = cal.get(Calendar.WEEK_OF_YEAR);
		
		try {
			int allOverTime = new WeekOverTimeService().selectOverTime(empCode, week);
			
			System.out.println("근태관리 open [WEEK_OVERTIME SELECT]");
			request.setAttribute("allOT", ""+allOverTime);
		} catch (CooException e) {
			//	에러 발생 시
			request.setAttribute("msg", "추가 근무 시간을 불러오는 중 에러 발생!");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
			
		}
		
		System.out.println("근태관리 open");
		request.getRequestDispatcher("views/popup/TA.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}













