package com.coo.notice.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.coo.notice.service.NoticeService;

/**
 * Servlet implementation class DeleteUpdate
 */
@WebServlet("/deleteNotice")
public class DeleteNotice extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DeleteNotice() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.println("DeleteUpdate");
		
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		int nno = Integer.parseInt(request.getParameter("nno"));
		
		System.out.println("DeleteUpdate => nno : "+nno);
		
		int result = new NoticeService().DeleteUpdate(nno);
		
		if(result >= 1) {
			System.out.println(nno+"번째 게시판 삭제 성공 ");
			response.sendRedirect("/semi/noticeListServlet");
		}else {
			request.setAttribute("msg", "공지사항 삭제 실패");
			// 나중에 에러 페이지 작성
			request.getRequestDispatcher("").forward(request, response);
		}
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
