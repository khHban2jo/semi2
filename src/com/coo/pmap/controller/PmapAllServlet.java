package com.coo.pmap.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.coo.member.model.vo.Member;
import com.coo.pmap.model.service.PmapService;
import com.coo.pmap.model.vo.Pmap;
import com.sun.org.apache.xerces.internal.util.SynchronizedSymbolTable;
import com.coo.pmap.model.vo.*;

/**
 * Servlet implementation class PmapAllServlet
 */
@WebServlet("/pAll.do")
public class PmapAllServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PmapAllServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * 전체 조직도 
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ArrayList<Member> list = new ArrayList<Member>();
		
		PmapService ps = new PmapService();
		//------페이지 표시 -------------------------------------------------------------
		
		int startPage; //가장 앞 페이지 
		
		int endPage; //표시할 마지막 페이지
		
		int maxPage; // 전체 마지막 페이지
		
		int currentPage;  // 현재 위치한 페이지 
		
		int limit; // 총 페이지수
		
		currentPage = 1; // 처음 시작 페이지를 1로 시작
		
		limit = 10; // 글 갯수와 페이지 갯수를 10으로 제한하자
		
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		int listCount = ps.getListCount();
		
		maxPage = (int)((double)listCount/limit + 0.9);
		
		startPage = ((int)((double)currentPage / limit +0.9)-1) * limit +1;
		
		endPage = startPage + limit-1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		//--------------------------------------------------------------------
		
		list = ps.selectList(currentPage,limit);
		
		String page = "";
		
		
		if(list != null) {
			page = "views/popup/Peoplemap.jsp";
			request.setAttribute("list",list);
			PmapInfo pa = new PmapInfo(currentPage,listCount,limit,maxPage,startPage,endPage);
			request.setAttribute("pa", pa);
			
		}else {
			page = "views/common/errorPage.jsp";
			request.setAttribute("msg", "전체 조직도 오류");
		}
		request.getRequestDispatcher(page).forward(request,response);
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
