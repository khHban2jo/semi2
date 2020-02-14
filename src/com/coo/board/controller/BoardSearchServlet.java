package com.coo.board.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
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
		String check = request.getParameter("search");
		String title = "";
		String keyword = "";
		String date1 = "";
		String date2 = "";
		String searchType = "";

		// 검색을 위한 여러 조건의 값을 넘겨 주기 위해 생성
		Hashtable<String, String> parameters = new Hashtable<String, String>();

		// 검색 버튼을 눌렀는지 아닌지 확인
		System.out.println("====================== BoardListServlet 테스트 ================================");
		System.out.println("검색버튼을 눌렀는지 확인 : " + check);

		// 페이징 처리를 위한 check 값 처리

		// Hashtable parameters 에 값을 넣준다.
		title = request.getParameter("title");
		keyword = request.getParameter("keyword");
		date1 = request.getParameter("date1");
		date2 = request.getParameter("date2");
		searchType = request.getParameter("searchType");

		System.out.println("title : " + title);
		System.out.println("keyword : " + keyword);
		System.out.println("date1 : " + date1);
		System.out.println("date2 : " + date2);
		System.out.println("searchType : " + searchType);

		parameters.put("title", title);
		parameters.put("keyword", keyword);
		parameters.put("date1", date1);
		parameters.put("date2", date2);
		parameters.put("searchType", searchType);
		parameters.put("deptView", m.getDeptCode());

		// 값이 들어 갔는지 확인용
		System.out.println("==해쉬테이블에 값이 들어 갔는지 확인==");
		Collection<String> show = parameters.values();
		for (String out : show) {
			System.out.println(out);
		}
		System.out.println("==============================");

		System.out.println("로그인 한 상대 확인 : " + m.getEmpId());

		String deptView = m.getDeptCode();

		// 사용자의 부서 코드
		parameters.put("deptView", deptView);

		System.out.println("부서 코드 확인 확인 : " + deptView);

		if (request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}

		// 검색 조건들로 값 가져오기
		int listCount = (title.equals("")) ? bs.getListCount() : bs.getListCount(parameters);

		System.out.println("listCount(행의 갯수) : " + listCount);

		maxPage = (int) ((double) listCount / limit + 0.9);
		startPage = ((int) ((double) currentPage / limit + 0.9) - 1) * limit + 1;
		endPage = startPage + limit - 1;

		System.out.println("maxPage : " + maxPage);
		System.out.println("startPage : " + startPage);
		System.out.println("endPage : " + endPage);

		if (endPage > maxPage) {
			endPage = maxPage;
		}

		list = bs.selectList(currentPage, limit, deptView);
		System.out.println("list(뷰 단에서 출력 할 부서의 행의 갯수) : " + list);

		System.out.println("======================================================================");
		if (list != null) {
			PageInfo pi = new PageInfo(currentPage, startPage, endPage, listCount, limit, maxPage);
			request.setAttribute("list", list);
			request.setAttribute("pi", pi);
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
