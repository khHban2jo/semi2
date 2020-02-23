package com.coo.ccalendar.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.GregorianCalendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.coo.ccalendar.model.service.CCalendarService;
import com.coo.ccalendar.model.vo.CCalendar;

/**
 * Servlet implementation class updateCalendarServlet
 */
@WebServlet("/updateCalendar.do")
public class UpdateCalendarServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateCalendarServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		System.out.println("넘어왔나요");
		//수정할 때 필요한 거 일정 제목, 시작일, 종료일, 일정 내용
		String title = request.getParameter("addtitle");
		String toDo = request.getParameter("calendarContent");
		String startDate = request.getParameter("calendarStart");		
		String endDate = request.getParameter("calendarEnd");
		String cno = request.getParameter("cno");
		
		//변환? =>//Cannot instantiate the type Calendar
		//스트링자료형을 데이트자료형으로 변환작업 split
		Date WriteStartDate = null;
		System.out.println(title);
		
		if(startDate != "" && startDate != null) {
			String[] dateArr = startDate.split("-"); //잘라주기
			int[] intArr = new int[dateArr.length];	//스트링형을 배열의 길이만큼 인트형으로 생성

			for(int i = 0; dateArr.length > i; i++) {
				intArr[i] = Integer.parseInt(dateArr[i]); //인트형 배열 = 정수형으로 바꾼 데이트에알알의 배열 = 정수형

			}


			WriteStartDate = new Date(new GregorianCalendar(
					intArr[0], intArr[1]-1, intArr[2] //-1은 인덱스가 0,1,2, 순으로 가기 대문에 -1로 월을 맙춰준다.
					).getTimeInMillis());
		}else {

			WriteStartDate = new Date(new GregorianCalendar().getTimeInMillis());
		}

		//------
		Date WriteEndDate = null;

		if(endDate != "" && endDate != null) {
			String[] dateArr = endDate.split("-");
			int[] intArr = new int[dateArr.length];

			for(int i = 0; dateArr.length > i; i++) {
				intArr[i] = Integer.parseInt(dateArr[i]);

			}


			WriteEndDate = new Date(new GregorianCalendar(
					intArr[0], intArr[1]-1, intArr[2]
					).getTimeInMillis());
		}else {

			WriteEndDate = new Date(new GregorianCalendar().getTimeInMillis());
		}
		//여기까지가 변환작업
		System.out.println(WriteStartDate);
		System.out.println(WriteEndDate);


		CCalendar c = new CCalendar();
		//Cannot instantiate the type Calendar

		c.setTitle(title);
		c.setToDo(toDo);
		c.setStartDate(WriteStartDate);
		c.setEndDate(WriteEndDate);
		c.setCno(cno);
		//행의 갯수의 변화니까 int
		
		int result = new CCalendarService().updateCalendar(c);
		
		System.out.println(result);
//-----------------------------------------
		
		//1 : 수정완료
		//-1,0 :오류
		//경로설정
		if(result >0) {
			System.out.println(cno+"번째 DB 수정을 완료했습니다.");
			response.getWriter().print("수정 완료!");
			/*System.out.println("DB 수정 완료되었습니다.");
			response.sendRedirect("/semi/selectOne.do?cno="+cno); //TODO
*/		}else {
			request.setAttribute("msg","일정 수정 실패!!");
			request.getRequestDispatcher("views/common/errorPage.jsp");
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
