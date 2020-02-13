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
 * Servlet implementation class SaveStockLineServlet
 */
@WebServlet("/sStline.ch")
public class SaveStockLineServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SaveStockLineServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	
		response.setContentType("application/json; charset=UTF-8");
		int empcode= Integer.valueOf(request.getParameter("empcode"));
		String deptcode = request.getParameter("dept");
		int number = Integer.valueOf(request.getParameter("number"));
		String table = request.getParameter("table");
		
		table = table.substring(18);
		
		System.out.print(empcode +" " + deptcode + " " +number + table);
		CheckService cs = new CheckService();
		
		int result = cs.saveStockline(empcode, deptcode, number, table);
	
		new Gson().toJson((result>0)?"완료":"실패",response.getWriter());
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
