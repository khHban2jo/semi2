package com.coo.board.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.coo.board.model.service.BoardService;
import com.coo.board.model.vo.Board;
import com.coo.boardComment.model.service.BoardCommentService;
import com.coo.boardComment.model.vo.BoardComment;
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
		
		String page = "views/common/errorPage.jsp";
		BoardService bs = new BoardService();
		
		Board b = bs.selectOne(bno);
		
		ArrayList<BoardComment> clist = new BoardCommentService().selectList(bno);
		
		request.setAttribute("clist",clist);
		if(b != null) {
			request.setAttribute("board", b);
			page = "views/dept_board/board_detail.jsp";
			bs.updateReadCount(bno);
			
		}else {
			request.setAttribute("msg","게시판 글 조회 실패");
		}
		 int result = bs.getListCountComment(bno);
		
		 request.setAttribute("count", result);
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
