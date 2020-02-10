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
import com.coo.board.model.vo.PageInfo;
import com.coo.exception.CooException;

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
		int listCount = 0;
		BoardService bs = new BoardService();
		currentPage = 1;
		limit = 6;
		String page = "views/common/errorPage.jsp";
		
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		try {
			listCount = bs.getListCount();
		} catch (CooException e) {
			request.setAttribute("msg","게시판 조회실패");
			request.getRequestDispatcher(page).forward(request, response);
		}
		
		maxPage = (int)((double)listCount / limit + 0.9);
		startPage = ((int)((double)currentPage / limit + 0.9) -1)  * limit + 1;
		endPage = startPage + limit - 1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		try {
			list = bs.selectList(currentPage,limit);
		} catch (CooException e) {
			request.setAttribute("msg","게시판 조회 실패");
			request.getRequestDispatcher(page).forward(request, response);
		}
		
		if(list != null) {
			PageInfo pi = new PageInfo(currentPage, startPage, endPage, listCount, limit, maxPage);
			request.setAttribute("list",list);
			request.setAttribute("pi", pi);
			page="views/dept_board/dept_board.jsp";
		}else {
			request.setAttribute("msg","게시판 조회 실패");
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
