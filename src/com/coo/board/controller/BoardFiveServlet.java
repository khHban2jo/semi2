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
import com.google.gson.Gson;

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
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=UTF-8");
		ArrayList<Board> listf = new ArrayList<Board>();
		
		HttpSession session = request.getSession(); 
		
		String deptCode = (((Member)session.getAttribute("member")).getDeptCode());
		
		listf = new BoardService().selectListFive(deptCode);
		
		new Gson().toJson(listf,response.getWriter());
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
