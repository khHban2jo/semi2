package com.coo.ta.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import com.coo.exception.CooException;
import com.coo.member.model.vo.Member;
import com.coo.ta.model.service.WeekOverTimeService;
import com.coo.ta.model.vo.HolidayAPI;
import com.coo.ta.model.vo.WeekOverTime;
/**
 * Servlet implementation class WeekT3Data
 */
@WebServlet("/overTime.ta")
public class WeekOverData extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public WeekOverData() {

    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//	평일 야근
		//	만약 wt.getWtTime() 이 19:00 보다 크면
		//	WEEK_T3_DATA 테이블에 야근 시간 등록을 하는데,
		//		같은 EMP_CODE, TODAY_DATE의 값이 존재한다면 UPDATE
		//		존재하지 않는 다면 INSERT
		
		//	empCode 받기
		HttpSession session = request.getSession(false);
		Member m = (Member) session.getAttribute("member");
		int empCode = m.getEmpCode();
		
		//	현재시간
//		Date now = new Date();
//		SimpleDateFormat sdf = new SimpleDateFormat("HHmm");
//		int nowTime = Integer.parseInt(sdf.format(now));
		
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("HHmm");
		String n = sdf.format(now);
		
		String time = null;
		int overTime = -1;
		
		Date d1 = new Date();
		Date d2 = new Date();
		
		try {
			d1 = sdf.parse(n);
			d2 = sdf.parse("1900");		//	19시 부터 추가 근무로 인정
		} catch (ParseException e) {}
		
		long diff = d1.getTime() - d2.getTime();
		
		long diff2 = diff / 60000;
		
		long hour = diff2/60;
		long min = diff2%60;
		
		String hh = "";
		String mm = "";
		
		hh = ""+hour;
		if( min < 10 ) {
			mm = "0"+min;
		}else {
			mm = ""+min;
		}
		
		time = hh + mm;
		
		overTime = Integer.parseInt(time);
			
		//	week of year 가져오기
		Calendar cal = Calendar.getInstance();
		int week = cal.get(Calendar.WEEK_OF_YEAR);
		System.out.println(week);
		
		WeekOverTime wot = new WeekOverTime();
		wot.setEmpCode(empCode);
		wot.setTodayOverTime(overTime);
		wot.setWeekOfYear(week);
		
		int result=0;
		try {
			result = new WeekOverTimeService().overTime(wot);
		} catch (CooException e) {

			request.setAttribute("msg", "추가 근무 시간 등록 중 에러 발생!");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
		
		//	ajax 결과 넘기기
		String msg = null;
		
		if( result > 0 ) {
			msg = "추가 근무 시간 등록 완료!";
		}else {
			msg = "추가 근무 시간 등록에 실패하였습니다.\n 퇴근 등록을 다시 해주세요!!";
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
