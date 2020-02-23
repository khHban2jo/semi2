package com.coo.board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.coo.board.model.service.BoardService;
import com.coo.board.model.vo.Board;

/**
 * Servlet implementation class BoardUpdateServlet
 */
@WebServlet("/bUpdate.bo")
public class BoardUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Board b = new Board();
		
		b.setBcontent(request.getParameter("ir1"));
		b.setBno(Integer.parseInt(request.getParameter("bno")));
		b.setBtitle(request.getParameter("title"));
		b.setCategory(request.getParameter("category"));
		b.setBtype(Integer.parseInt(b.getCategory()));
		b.setBwriter(request.getParameter("writer"));
		b.setBdeptCode(request.getParameter("deptview"));
		
		
		int result = new BoardService().updateBoard(b);
		
		// searchBoard.bo?title=all // selectList.bo
		if(result>0) {
			response.sendRedirect("searchBoard.bo?title=all");
		}else {
			request.setAttribute("msg","게시판 수정 실패");
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
