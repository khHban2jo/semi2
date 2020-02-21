package com.coo.check.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.coo.check.model.service.CheckService;
import com.coo.check.model.vo.CheckDoc;
import com.coo.check.model.vo.PageInfo;
import com.coo.member.model.vo.Member;
import com.google.gson.Gson;

/**
 * Servlet implementation class CheckHomeInServlet
 */
@WebServlet("/cHIn.ch")
public class CheckHomeInServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckHomeInServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=UTF-8");
		
		HttpSession session = request.getSession(false);
		if(session == null) {
		 request.setAttribute("msg", "로그인인 해주세요");
		 request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
	
		Member m = (Member) session.getAttribute("member");
		int id = m.getEmpCode();

		//int status = Integer.valueOf(request.getParameter("ASTAT"));
		int statusWait = 4; //결재대기
		int statusWrite = 5; //기안
		
		ArrayList<CheckDoc> waitlist = null;
		ArrayList<CheckDoc> writelist = null;
		//페이징 처리
		
		//1.  총 게시글수
		int checkListCount;
		
		//5. 한줄에 들어갈 페이징수
		int limitPaging;
		
		//6. 한번에 보일 페이지
		int limitPage;
		
		//7. 현재  있는 페이징
		int currentPage;

		limitPage = 5;
		
		currentPage = 1;
		
		//페이징 시작
		CheckService cs = new CheckService();
		
	
		
		
		int checkwaitListCount = cs.getListCount(id,statusWait);
		
		
		waitlist = cs.getList(currentPage,limitPage, id, statusWait);
		writelist = cs.getList(currentPage,limitPage, id, statusWrite);
		
		
		if(waitlist != null && writelist!= null) {	
		

		Map pafull = new HashMap();
		pafull.put("wc", checkwaitListCount);
		pafull.put("wl", waitlist);
		pafull.put("wrl", writelist);


   
				
				new Gson().toJson(pafull,response.getWriter());
		}else {
			System.out.println("error");
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
