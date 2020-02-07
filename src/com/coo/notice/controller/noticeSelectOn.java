package com.coo.notice.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.coo.notice.model.vo.Notice;
import com.coo.notice.service.NoticeService;

/**
 * Servlet implementation class noticeSelectOn
 */
@WebServlet("/noticeSelectOn")
public class noticeSelectOn extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public noticeSelectOn() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("UTF-8");
		
		int nno = Integer.parseInt(request.getParameter("nno"));
		System.out.println("nno : "+nno);
		
		Notice n = new NoticeService().selectOne(nno);
		
		String page = "";
		if(n != null) {
			page = "views/notice/noticeShow.jsp";
			request.setAttribute("notice", n);
		}else {
			page = "";
			request.setAttribute("msg", "공지사항 상세 보기 실패");
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
