package com.coo.notice.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.GregorianCalendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.coo.notice.model.vo.Notice;
import com.coo.notice.service.NoticeService;

/**
 * Servlet implementation class noticeServletInsert
 */
@WebServlet("/noticeServletInsert")
public class noticeServletInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public noticeServletInsert() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doGet 실행");
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("UTF-8");
		
		String title = request.getParameter("title");
		String nwriter = request.getParameter("nwriter");
		String nowDate = request.getParameter("nowDate");
		String ncontent = request.getParameter("ncontent");
		
		System.out.println("title : "+title +", nwriter : "+nwriter+"");
		System.out.println("nowDate : "+nowDate);
		System.out.println("ncontent : "+ncontent);
		
		// 데이터 처리
		Date registDate = null;
		
		if(nowDate != null && nowDate != "") {
			
			String[] dateArr = nowDate.split("-");
			
			registDate = new Date(new GregorianCalendar(
					Integer.parseInt(dateArr[0]),
					Integer.parseInt(dateArr[1])-1,
					Integer.parseInt(dateArr[2])
				).getTimeInMillis());
		}else {
			registDate = new Date(new GregorianCalendar().getTimeInMillis());
		}
		// 데이터 처리 완료
		boolean check = registDate instanceof Date? true:false;
		
		System.out.println("registDate : "+check);
		
		// nno 으로 인해 생성자로 생성 x
		Notice n = new Notice();
		n.setNtitle(title);
		n.setNwriter(nwriter);
		n.setNcontent(ncontent);
		n.setNdate(registDate);
		
		System.out.println(n.getNdate());
		
		int result = new NoticeService().insertNotice(n);
		
		if(result > 0) { // 추가 성공
			
			response.sendRedirect("/semi/noticeListServlet");
			
		}else { // 공지사항 추가 실패
			
			request.setAttribute("msg", "공지사항 등록 실패");
			// 나중에 에러 페이지 작성
			request.getRequestDispatcher("").forward(request, response);
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
