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
import com.coo.ta.model.dao.WeekOverTimeDao;
import com.coo.ta.model.service.WeekOverTimeService;
import com.coo.ta.model.service.WorkTimeService;
import com.coo.ta.model.vo.WeekOverTime;

/**
 * Servlet implementation class EndHoliday
 */
@WebServlet("/endH.ta")
public class EndHoliday extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EndHoliday() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//	주말/공휴일 특근 추가 근무 시간 등록
		//	1.	직원의 출근 시간을 SELECT해서 가져온다.
		//	2.	(현재시간 - 출근시간) 의 값을 계산한다.
		//	3.	만약 이미 입력한 퇴근 값이 있다면 UPDATE
		//	4.		없다면 INSERT 한다

		//	empCode
		HttpSession session = request.getSession(false);
		Member m = (Member)session.getAttribute("member");
		int empCode = m.getEmpCode();
		
		//	ajax로 가져온 현재시간
		String now = request.getParameter("now");

		//	week of year
		Calendar cal = Calendar.getInstance();
		int week = cal.get(Calendar.WEEK_OF_YEAR);
		
		WeekOverTime wot = new WeekOverTime();
		wot.setEmpCode(empCode);
		wot.setWeekOfYear(week);
		
		try {
			int result = new WeekOverTimeService().holiOverTime(wot, now);		//	등록할 wot 객체와 현재시간을 넘김
			
			String msg = null;
			
			if(result>0) {
				msg = "(특근) 추가 근무 시간 등록 완료!";
			}else {
				msg = "(특근) 추가 근무 시간 등록에 실패하였습니다.\n퇴근 등록을 다시 해주세요!!";
			}
			
			response.getWriter().print(msg);
			
		} catch (CooException e) {
			e.printStackTrace();
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
