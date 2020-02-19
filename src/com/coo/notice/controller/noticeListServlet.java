package com.coo.notice.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.coo.notice.model.vo.Notice;
import com.coo.notice.model.vo.PageInfo;
import com.coo.notice.service.NoticeService;

/**
 * Servlet implementation class BoardListServlet
 */
@WebServlet("/noticeListServlet")
public class noticeListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public noticeListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    // 공지사항 게시판 작성
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<Notice> list = null;
		NoticeService bs = new NoticeService();
		
		System.out.println("============== 게시판 실행 ==============");
		  String search = request.getParameter("search"); 
		  
		  String date1 = request.getParameter("date1");
		  String date2 = request.getParameter("date2");
		  
		  String keyword = "";
		  
		  System.out.println("search : "+search);
		  
		  if(search != null && !search.equals("all")) { 
			  keyword = request.getParameter("keyword"); 
		  }
		  
		System.out.println("keyword : "+keyword);
		
		// 처음으로 왼쪽의 공지 사항 클릭시 파라미터 값 초기화
		if(date1.equals("all") && date2.equals("all")){
			date1 = date2 = "";
		}
		
		System.out.println("date1 : "+date1);
		System.out.println("date2 : "+date2);
		
		System.out.println("request-getParameter(currentPage) : "+request.getParameter("currentPage"));
		
		// 페이징 처리에 필요한 변수들 한번에 표시할 페이지들 중 가장 앞의 페이지 : 
		int startPage;
		
		// 한 번에 표시할 페이지들 중 가장 뒤의 페이지
		int endPage;
		
		// 전체 페이지의 가장 마지막 페이지
		int maxPage;
		
		// 사용자가 위치한 현재 페이지
		int currentPage;
		
		//총 페이지 수(한 페이지 당 보여줄 게시글 수)
		int limit;
		
		// 처음에 접속시 페이지는 1페이지 부터 시작한다.
		currentPage = 1;
		
		// 글 개수 및 페이지 수 제한
		limit = 8;
		
		// 특정 페이지호 수정해야 한다.
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
			System.out.println("currentPage : " + currentPage);
		}

		// 페이징 처리를 위해서 전체 페이지 수를 가져온다. 
		
		System.out.println("첫 번째 공지 전체 값을 가져 온것을 실행 1-1");
		
		int listcount = 0;
		
		ArrayList<String> Datelist = new ArrayList<String>();
		
		Datelist.add(date1);
		Datelist.add(date2);
		
		if(search.equals("all") || search.isEmpty()) {	
			System.out.println("all 실행");
			listcount = bs.getListCount(Datelist);
			
		}else {
			
			listcount = bs.getListCount(search, keyword, Datelist);
			
		}
		
		maxPage = (int)((double)listcount/limit+0.9);
		
		startPage = ((int)((double)currentPage / limit + 0.9) -1) * limit + 1;
		
		endPage = startPage + limit -1;
		System.out.println("==============================");
		System.out.println("listcount : " +listcount);
		System.out.println("maxPage : " +maxPage);
		System.out.println("startPage : " +startPage);
		System.out.println("endPage : " +endPage);
		System.out.println("==============================");
		// 만약 마지막 페이지보다 현재 게시글이 끝나는 페이지가 적다면
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		System.out.println("currentPage : " + currentPage);

// 전체 공지 사항 과 검색을 통한 검색을 구분하기 위해 분리
		if(search.equals("all") || search == null) {	
			
			list = bs.selectList(currentPage, limit, Datelist);
			
		}else {
			System.out.println("조건 검색");
			list = bs.selectList(currentPage, limit, search, keyword, Datelist);
			
		}
			
		String page = "";
		
		System.out.println("list : "+ list.size());
		
		if(list != null) {
			page = "views/notice/notice.jsp";
			
			System.out.println("페이지 이동 시 값 : search : "+search+", keyword : "+keyword);
			request.setAttribute("noticeList", list);
			request.setAttribute("search", search);
			request.setAttribute("keyword", keyword);
			request.setAttribute("date1", Datelist.get(0));
			request.setAttribute("date1", Datelist.get(1));
			
			PageInfo pi = new PageInfo(currentPage, listcount, limit, maxPage, startPage, endPage);
			System.out.println(pi.toString());
			request.setAttribute("pi", pi);
		}else {
			// 에러 페이지 작성 필요
			page = "views/common/errorPage.jsp";
			request.setAttribute("msg", "게시글 목록 조회 실패");
		}
		
		System.out.println("request.getRequestDispatcher(page)");
		System.out.println("=======================================");
		request.getRequestDispatcher(page).forward(request, response);
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
