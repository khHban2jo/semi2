package com.coo.check.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.coo.check.model.service.CheckService;
import com.google.gson.Gson;

/**
 * Servlet implementation class CheckMasterStatusServlet
 */
@WebServlet("/cMStatus.ch")
public class CheckMasterStatusServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckMasterStatusServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json charset=UTF-8");
		int mascode = Integer.valueOf(request.getParameter("masCode"));
		
		boolean status = new CheckService().getMasStauts(mascode);
		String st1;
				
		//System.out.println(status);
		 if(status) {
			 st1 = "Y";
		 }else {
			 st1 = "N";
		 }
		new Gson().toJson(st1, response.getWriter());
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
