package com.coo.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.coo.member.model.vo.Member;

/**
 * Servlet implementation class MemberChk
 */
@WebServlet("/checkAdmin.me")
public class MemberChk extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberChk() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Member mem = (Member)session.getAttribute("member");
		String btn = request.getParameter("btnDen");
	    session.setAttribute("works",btn);
	    
		switch(btn) {
		case "1":request.getRequestDispatcher("views/manager/join.jsp").forward(request, response); break;
		case "2":request.getRequestDispatcher("pAll.do").forward(request, response); break;
		case "3":request.getRequestDispatcher("pAll.do").forward(request, response); break;
		case "4":request.getRequestDispatcher("pAll.do").forward(request, response); break;
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
