package com.coo.pmap.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.coo.pmap.model.service.PmapService;
import com.coo.pmap.model.vo.Pmap;

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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ArrayList<Pmap> list = new ArrayList<Pmap>();
		
		PmapService ps = new PmapService();
		
		String page = "";
		
		list = ps.selectList();
		
		if(list != null) {
			page = "views/popup/Peoplemap.jsp";
			request.setAttribute("list",list);
		}else {
			page = "views/common/errorPage.jsp";
			request.setAttribute("msg", "전체 조직도 오류");
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
