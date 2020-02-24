package com.coo.boardComment.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.coo.board.model.vo.Board;
import com.coo.boardComment.model.service.BoardCommentService;
import com.coo.boardComment.model.vo.BoardComment;

/**
 * Servlet implementation class CommentSelectListServlet
 */
@WebServlet("/bcoSelectList.bo")
public class CommentSelectListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CommentSelectListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int bno = Integer.parseInt(request.getParameter("bno"));
		
		ArrayList<BoardComment> clist = new BoardCommentService().selectList(bno);
		Board b = new Board();
		b.setBno(bno);
		request.setAttribute("board", b);
		request.setAttribute("clist",clist);
		request.getRequestDispatcher("views/dept_board/boardComment.jsp").forward(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
