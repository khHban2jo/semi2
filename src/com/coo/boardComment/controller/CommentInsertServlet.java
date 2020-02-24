package com.coo.boardComment.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.coo.boardComment.model.service.BoardCommentService;
import com.coo.boardComment.model.vo.BoardComment;

/**
 * Servlet implementation class CommentInsertServlet
 */
@WebServlet("/insertComment.bo")
public class CommentInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CommentInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String writer = request.getParameter("writer");
		int bno = Integer.parseInt(request.getParameter("bno"));
		String content = request.getParameter("replyContent");
		int refcno = Integer.parseInt(request.getParameter("refcno"));
		int clevel = Integer.parseInt(request.getParameter("clevel"));
		
		BoardComment bco = new BoardComment(bno,content,writer,refcno,clevel);
		
		int result = new BoardCommentService().insertComment(bco);
		
		if(result>0) {
			response.sendRedirect("views/dept_board/boardComment.jsp");
		}else {
			request.setAttribute("msg","에러발생");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
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
