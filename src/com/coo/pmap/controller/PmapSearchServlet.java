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
import com.coo.pmap.model.vo.PmapInfo;

/**
 * Servlet implementation class PmapSearchServlet
 */
@WebServlet("/PSearch.ps")
public class PmapSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PmapSearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 *  검색 카테고리
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String category = request.getParameter("con");
		String keyword = request.getParameter("keyword");
		
		System.out.println("카테고리 : "+category);
		System.out.println("키워드 : "+ keyword);
		
		ArrayList<Member> list = new ArrayList<>();
		
		PmapService ps = new PmapService();
		
		list = ps.searchPmap(category,keyword);
		
		String page = "";
		
		PmapInfo pa = new PmapInfo();
		
		
		if(list != null) {
			page="views/popup/Peoplemap.jsp";
			request.setAttribute("list", list);
			System.out.println("들어왔어요 : " + list);
			
			request.setAttribute("pa", pa);
		}else {
			page="views/common/errorPage.jsp";
			request.setAttribute("msg", "조직도 검색 실패!");
			
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
