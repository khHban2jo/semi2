package com.coo.check.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.coo.check.model.service.CheckService;
import com.coo.member.model.vo.Member;

/**
 * Servlet implementation class MycheckCount
 */
@WebServlet("/cmycount.ch")
public class MycheckCountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MycheckCountServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//ajax용
		response.setContentType("application/json; charset=UTF-8");
		HttpSession session = request.getSession();
		
		Member m = (Member)session.getAttribute("member");
		
		int id = m.getEmpCode();
		
		
		
		int result = new CheckService().getMyCount(id);
		String page="";
		
		
		if(result >=0) {
			response.getWriter().print(result);
			
		}else {
			//오류 페이지
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
