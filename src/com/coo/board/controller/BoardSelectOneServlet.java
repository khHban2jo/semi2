package com.coo.board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.coo.board.model.service.BoardService;
import com.coo.board.model.vo.Board;
import com.coo.exception.CooException;

/**
 * Servlet implementation class BoardSelectOneServlet
 */
@WebServlet("/selectOne.bo")
public class BoardSelectOneServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardSelectOneServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int bno = Integer.parseInt(request.getParameter("bno"));
		Board b = null;
		String page = "views/common/errorPage.jsp";
		BoardService bs = new BoardService();
		try {
			b = bs.selectOne(bno);
			System.out.println(b.toString());
		} catch (CooException e) {
		   request.setAttribute("msg","게시판 글 조회 실패");
		   request.getRequestDispatcher(page).forward(request, response);
		}
		
		if(b != null) {
			request.setAttribute("board", b);
			page = "views/dept_board/board_detail.jsp";
			try {
				int result = bs.updateReadCount(bno);
			} catch (CooException e) {
				request.setAttribute("msg","게시판 글 count 증가 실패");
			}
			
		}else {
			request.setAttribute("msg","게시판 글 조회 실패");
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
