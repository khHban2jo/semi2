package com.coo.check.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.coo.check.model.service.CheckService;
import com.google.gson.Gson;

/**
 * Servlet implementation class SearchReadEmpName
 */
@WebServlet("/sREName.ch")
public class SearchReadEmpName extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchReadEmpName() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	   response.setContentType("applicatrion/json; charset=UTF-8");
	   
	   
	   String[] peArr = request.getParameter("peArr").split(",");
	   
	   ArrayList<Integer> codes= new ArrayList<>();
	   
	   for(String code : peArr) {
		   codes.add(Integer.valueOf(code));
	   }
	   //System.out.println(codes.toString());
	   ArrayList<String> names = new CheckService().getMSName(codes);
	  // System.out.println(names);
	   
	   new Gson().toJson(names, response.getWriter());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
