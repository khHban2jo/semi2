package com.coo.ccalendar.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.coo.ccalendar.model.service.CCalendarService;
import com.coo.ccalendar.model.vo.CCalendar;

/**
 * Servlet implementation class SelectOneCCalendarServlet
 */
@WebServlet("/selectOne.do")
public class SelectOneCCalendarServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelectOneCCalendarServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//클릭한 게시물을 호출하기 위해서 필요한 값을 받아서 변수에 답는다.
		String cno= request.getParameter("cno");
		
		//받은 값을 CCalendarService로 보내기 위해서 객체를 새롭게 생성한다.
		//CCalendarService에서 반환받을 변수를 지정해서
		//CCalendarService에 있는 selectOne()메소드 호출 == 상세페이지를 호출하기 위한 메소드
		CCalendarService cs = new CCalendarService();
		CCalendar c = cs.selectOne(cno);
		//--------------------------------
		//DB에서 전달받은 정보를 전달할 코드 생성
		//left.jsp에 결과를 forword방식으로
		String page="";
		
		if(c != null) { // 생성된 일정 상세페이지 데이터 가져오는데 성공
			page = "views/popup/Detail.jsp"; 
			request.setAttribute("selectCalOne", c);
		 // request.setAttribute("내가 전달할 객체(변수)의 명을 기입", "내가 전달할 객체(변수)값을 기입");
			
		}else {
			page = "views/common/errorPage.jsp";
			request.setAttribute("msg", "일정 상세보기 실패!");
		}
		
		request.getRequestDispatcher(page).forward(request, response);
		
		
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
