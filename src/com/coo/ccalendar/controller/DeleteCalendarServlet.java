package com.coo.ccalendar.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.coo.ccalendar.model.service.CCalendarService;

/**
 * Servlet implementation class DeleteCalendarServlet
 */
@WebServlet("/deleteCalendar.do")
public class DeleteCalendarServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteCalendarServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
		String cno = request.getParameter("cno"); 
		
		System.out.println(cno);
		
		//Cannot instantiate the type Calendar
		//Calendar c = new Calendar(); 
		CCalendarService cs = new CCalendarService();
		//행의 갯수니까 int
		int result = cs.deleteCalendar(cno);
		//------------------------------------------
		
		//int 결과에 따른 경로 설정
		if(result > 0) {
		/*	System.out.println(cno+"번째 DB 삭제를 완료했습니다.");
			response.sendRedirect("selectCalOne");*/
			System.out.println(cno+"번째 DB 삭제를 완료했습니다.");
			response.getWriter().print("삭제 완료!");
		}else {
			request.setAttribute("msg", "일정 삭제 실패!!");
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
