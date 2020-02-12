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

import com.coo.check.model.service.CheckService;
import com.coo.check.model.vo.StockLine;
import com.google.gson.Gson;

/**
 * Servlet implementation class GetStockLineServlet
 */
@WebServlet("/gStLine.ch")
public class GetStockLineServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetStockLineServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=UTF-8");
		int empcode= Integer.valueOf(request.getParameter("empcode"));
		
		ArrayList<String> dcnlist = null;
		
		ArrayList<StockLine> stocklist = null;
		 int st = 1;
		
		Map<String, StockLine> pushlist = new HashMap<String, StockLine>();
		
		Map fulling = new HashMap();
 		
		CheckService cs = new CheckService();
		
		dcnlist = cs.getDcnList(st);

		stocklist= cs.getStocklist(empcode);
		if(dcnlist != null) {
			for(int i = 0; i<dcnlist.size(); i++) {
				for(int j = 0; j<stocklist.size(); j++) {
					if(stocklist.get(j).getDeptCode().equals(dcnlist.get(i))){
						pushlist.put(dcnlist.get(i),stocklist.get(j));
						//pushlist.put(stocklist.get(j).getDeptCode(),stocklist.get(j));
	
						break;
					}
				}
			}
			fulling.put("list1", dcnlist);
			fulling.put("list2", pushlist);
		
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
