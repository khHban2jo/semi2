package com.coo.ccalendar.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.coo.ccalendar.model.service.CCalendarService;
import com.coo.ccalendar.model.vo.CCalendar;
import com.coo.exception.CooException;
import com.coo.member.model.vo.Member;
import com.google.gson.Gson;

/**
 * Servlet implementation class SelectCalendarServlet
 */
@WebServlet("/selectCalendar.do")
public class SelectListCalendarServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelectListCalendarServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		//접속한 유저 EMP_CODE 받기
		HttpSession session = request.getSession();
		Member emp = (Member)session.getAttribute("member");
		int empCode = emp.getEmpCode();
		//System.out.println(empCode);
		
		response.setContentType("application/json; charset=UTF-8");
		
		ArrayList<CCalendar> list = new ArrayList<CCalendar>();
		System.out.println(list);
		
		Date sqlDate = new Date(System.currentTimeMillis());
	
		try {
			list = new CCalendarService().selectToday(empCode);
			new Gson().toJson(list,response.getWriter());
		} catch (CooException e) {
		//에러 발생 시
			request.setAttribute("msg", "일정을 불러오는 중 에러 발생!");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}	
	}
		
		
		//등록된 일정 여러개를 받아 목록 형태로 ArrayList형태로 데이터를 전달하는 서블릿
		
/*		ArrayList<Calendar> list = new ArrayList<Calendar>();
		
		CalendarService cs = new CalendarService();
		list = cs.selectList();
		
		
		if(list != null) {
			System.out.println("");
			request.getRequestDispatcher("/views/Calendar.jsp").forward(request, response);
		
			request.setAttribute("list", list);
	         	 was내에서 forward방식으로 값 넘기기 : 
	             request.getRequestDispatcher(""); 
	             request.getAttribute();
	             request.setAttribute(key, value);
			
		}else {
			request.setAttribute("msg", "등록실패");
			request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
		}
		
*/		
		
		
		
		
/*		
		
		response.setContentType("application/json; charset=UTF-8");
		
		ArrayList<CCalendar> list = new ArrayList<CCalendar>();
		
		Date sqlDate = new Date(System.currentTimeMillis());
	
		list = new CCalendarService().selectToday(sqlDate);	
		System.out.println(list);
		
		
		new Gson().toJson(list,response.getWriter());
	}*/
		


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
