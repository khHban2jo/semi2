package com.coo.board.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Hashtable;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.coo.board.model.service.BoardService;
import com.coo.board.model.vo.Board;
import com.coo.board.model.vo.PageInfo;
import com.coo.exception.CooException;
import com.coo.member.model.vo.Member;

/**
 * Servlet implementation class BoardListServlet
 */
@WebServlet("/selectList.bo")
public class BoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<Board> list = new ArrayList<Board>();
		int startPage;
		int endPage;
		int maxPage;
		int limit;
		int currentPage;
		BoardService bs = new BoardService();
		currentPage = 1;
		limit = 8;
		HttpSession session = request.getSession();
		Member m = (Member)session.getAttribute("member");
		
		String deptView = m.getDeptCode();
		
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		int listCount = bs.getListCount();
		
		
		maxPage = (int)((double)listCount / limit + 0.9);
		startPage = ((int)((double)currentPage / limit + 0.9) -1)  * limit + 1;
		endPage = startPage + limit - 1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		list = bs.selectList(currentPage,limit,deptView);
		
		if(list != null) {
			PageInfo pi = new PageInfo(currentPage, startPage, endPage, listCount, limit, maxPage);
			request.setAttribute("list",list);
			request.setAttribute("pi", pi);
			request.getRequestDispatcher("views/dept_board/dept_board.jsp").forward(request, response);
		}else {
			request.setAttribute("msg","게시판 조회 실패");
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
