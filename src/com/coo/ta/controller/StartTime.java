package com.coo.ta.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.coo.exception.CooException;
import com.coo.member.model.vo.Member;
import com.coo.ta.model.service.WorkTimeService;
import com.coo.ta.model.vo.WorkTime;

/**
 * Servlet implementation class StartTime
 */
@WebServlet("/sTime.ta")
public class StartTime extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StartTime() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//	session에 저장된 empCode 받기
		HttpSession session = request.getSession(false);
		Member m = (Member) session.getAttribute("member");
		int empCode = m.getEmpCode();

		//	ajax data로 전송된 type 받기
		String taType = request.getParameter("type");
		
		//	현재 시간
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
		String taTime = sdf.format(now);
		
		//	WorkTime 객체 생성
		WorkTime wt = new WorkTime(empCode, taType, taTime);
		
		//	service로 객체 전송
		int result = 0;
		
		try {
			result = new WorkTimeService().wtT1Insert(wt);
		} catch (CooException e) {
			request.setAttribute("msg", "출근 시간 등록 중 오류 발생!");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}

		//	ajax 결과 넘기기
		String msg = null;
		
		if( result > 0 ) {
			if( "09:00".compareTo(taTime) > 0 ) {
				msg = taTime + " 부로 출근 등록 완료!";
			}else {
				msg = taTime + " 부로 출근 등록 완료! \n 지각입니다!!"; 
			}
		}else {
			msg = "출근 시간 등록 실패! 다시 시도하세요";
		}
		
		response.getWriter().print(msg);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
