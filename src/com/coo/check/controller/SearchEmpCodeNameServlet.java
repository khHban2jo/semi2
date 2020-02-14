package com.coo.check.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.coo.check.model.service.CheckService;
import com.coo.check.model.vo.StockLine;
import com.google.gson.Gson;

/**
 * Servlet implementation class SearchEmpCodeNameServlet
 */
@WebServlet("/sECName.ch")
public class SearchEmpCodeNameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchEmpCodeNameServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json; charset=UTF-8");
		
		if(!request.getParameter("pcodes").equals("")) {
		String[] data = request.getParameter("pcodes").split(",");
		ArrayList<Integer> savePcodes = new ArrayList<>();
		for(int i = 0; i<data.length; i++) {
			savePcodes.add(Integer.valueOf(data[i]));
		}
		
		ArrayList<StockLine> fulling = new CheckService().getDeptTN(savePcodes);
		
		new Gson().toJson(fulling,response.getWriter());
		
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
