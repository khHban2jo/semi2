package com.coo.board.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Enumeration;
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
import com.coo.member.model.vo.Member;

/**
 * Servlet implementation class BoardSearchServlet
 */
@WebServlet("/searchBoard.bo")
public class BoardSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public BoardSearchServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
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
		Member m = (Member) session.getAttribute("member");

		// search은 검색을 눌렀을시에 자동으로 'true'값을 전해 준다. 즉 검색을 누르지 않으면 null 값이 된다.
//		String check = request.getParameter("search");
		String title = request.getParameter("title");
		String keyword = request.getParameter("keyword");
		String date1 = request.getParameter("date1");
		String date2 = request.getParameter("date2");
		String searchType = request.getParameter("searchType");

		// 검색을 위한 여러 조건의 값을 넘겨 주기 위해 생성
		Hashtable<String, String> parameters = new Hashtable<String, String>();

		// Hashtable parameters 에 값을 넣준다.
		parameters.put("title", title);
		
		if(keyword != null) {
			parameters.put("keyword", keyword);			
		}else {
			keyword = "";
			parameters.put("keyword", keyword);	
		}
		
		if(date1 != null) {
			parameters.put("date1", date1);		
		}else {
			date1 = "";
			parameters.put("date1", date1);
		}
		
		if(date2 != null) {
			parameters.put("date2", date2);		
		}else {
			date2 = "";
			parameters.put("date2", date2);	
		}
		
		if(searchType != null) {
			parameters.put("searchType", searchType);		
		}else {
			parameters.put("searchType", "1");
		}
		parameters.put("deptView", m.getDeptCode());
		// 페이징 처리를 위해 필요
		parameters.put("limit", String.valueOf(limit));
		

//		if(m.getEtc() == null) {
//			m.setEtc("");
//		}
//		parameters.put("Id", m.getEmpId()); // dao에서 etc로 관리자 와 유저 구분
//		
//		System.out.println("==파라미터 값 확인==");
//		Enumeration<String> out = parameters.keys();
//		while (out.hasMoreElements()) {
//			String keys = out.nextElement();
//			System.out.println(keys + " : " + parameters.get(keys));
//		}
//		System.out.println("==============================");
//
//		System.out.println("로그인 한 상대 확인 : " + m.getEmpId());

		String deptView = m.getDeptCode();

		// 사용자의 부서 코드
		parameters.put("deptView", deptView);

		if (request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		// currentPage 값을 계산
		parameters.put("currentPage", String.valueOf(currentPage));

		int listCount = 0;
		list = bs.getListCount(parameters, list);
		
		maxPage = Integer.parseInt(parameters.get("maxPage"));
		startPage = Integer.parseInt(parameters.get("startPage"));
		endPage = Integer.parseInt(parameters.get("endPage"));
		
//		if(title.equals("")) {
//			listCount = bs.getListCount();
//			
//			maxPage = (int) ((double) listCount / limit + 0.9);
//			startPage = ((int) ((double) currentPage / limit + 0.9) - 1) * limit + 1;
//			endPage = startPage + limit - 1;
//		}else {
//			
//			list = bs.getListCount(parameters, list);
//			
//			maxPage = Integer.parseInt(parameters.get("maxPage"));
//			startPage = Integer.parseInt(parameters.get("startPage"));
//			endPage = Integer.parseInt(parameters.get("endPage"));
//			
//		}
		//System.out.println("listCount(행의 갯수) : " + listCount);
//		maxPage = (int) ((double) listCount / limit + 0.9);
//		startPage = ((int) ((double) currentPage / limit + 0.9) - 1) * limit + 1;
//		endPage = startPage + limit - 1;

//		System.out.println("maxPage : " + maxPage);
//		System.out.println("startPage : " + startPage);
//		System.out.println("endPage : " + endPage);

		if (endPage > maxPage) {
			endPage = maxPage;
		}
		
//		System.out.println("======================================================================");
		if (list != null) {
			PageInfo pi = new PageInfo(currentPage, startPage, endPage, listCount, limit, maxPage);
			request.setAttribute("list", list);
			request.setAttribute("pi", pi);
			request.setAttribute("parameters", parameters);
			request.getRequestDispatcher("views/dept_board/dept_board.jsp").forward(request, response);
		} else {
			request.setAttribute("msg", "게시판 조회 실패");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
