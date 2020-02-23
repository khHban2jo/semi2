package com.coo.ccalendar.controller;

import java.io.IOException;
import java.sql.Date;

import java.util.GregorianCalendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.coo.ccalendar.model.vo.CCalendar;
import com.coo.ccalendar.model.service.CCalendarService;
import com.coo.member.model.vo.Member;

/**
 * Servlet implementation class CreateCalendarServlet
 */
@WebServlet("/InsertSchedule.do") //Insert라고 바꿔주기
public class InsertCalendarServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public InsertCalendarServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		Member m = (Member)session.getAttribute("member");
		
		//달력의 제목 내용 시작일 종료일
		int empCode = m.getEmpCode(); //member.medel.vo.Member
		String title = request.getParameter("addtitle");		
		String toDo = request.getParameter("calendarContent");		
		String startDate = request.getParameter("calendarStart");		
		String endDate = request.getParameter("calendarEnd");		
		
		//request.getParameter()는 사용자가 요청, 전달한 값들을 문자열 형태로 받아오는 메소드이다.
		System.out.println("넘어오나요");

		//확인용
		System.out.println(empCode);
		System.out.println(title);
		System.out.println(startDate);
		System.out.println(endDate);
		System.out.println(toDo);

		

		//스트링자료형을 데이트자료형으로 변환작업 split
		Date WriteStartDate = null;

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


		
		
		
		
		//서비스에 전달을 위한 매개변수가 있는 생성자 이용
		CCalendar c = new CCalendar();
		c.setEmpCode(empCode);
		c.setTitle(title);
		c.setToDo(toDo);
		c.setStartDate(WriteStartDate);
		c.setEndDate(WriteEndDate);
		
		System.out.println("empCode : " + empCode);
		System.out.println("title : " + title);
		System.out.println("toDo : " + toDo);
		System.out.println("WriteStartDate : " + WriteStartDate);
		System.out.println("WriteEndDate : " + WriteEndDate);
		
		CCalendarService cs = new CCalendarService();

		
		
		//DB에 입력되는 행이니까
		int result = cs.insertCalendar(c);
	


		//결과에 따른 경로 지정
		if(result > 0){
			System.out.println("근무 일정을 DB에 추가완료 했습니다.");
			response.sendRedirect("close.do");


		}else {
			request.setAttribute("msg", "등록실패");
			request.getRequestDispatcher("/views/common/errorPage.jsp").forward(request, response);
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
