package com.coo.board.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.coo.board.model.service.BoardService;
import com.coo.board.model.vo.Board;
import com.coo.member.model.vo.Member;

/**
 * Servlet implementation class BoardFiveServlet
 */
@WebServlet("/bselectFive.bo")
public class BoardFiveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardFiveServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<Board> list = new ArrayList<Board>();
		
		HttpSession session = request.getSession(); 
		
		
		String deptCode = (((Member)session.getAttribute("member")).getDeptCode());
		
		list = new BoardService().selectListFive(deptCode);
		
		request.setAttribute("list",list);
		request.getRequestDispatcher("views/dept_board/board_home.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
