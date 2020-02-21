package com.coo.check.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.coo.check.model.service.CheckService;
import com.coo.check.model.vo.CheckDoc;
import com.coo.check.model.vo.PayDoc;
import com.coo.check.model.vo.RoundDoc;
import com.coo.check.model.vo.Vacation;

/**
 * Servlet implementation class CheckReadServlet
 */
@WebServlet("/cread.ch")
public class CheckReadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckReadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int docnumber =Integer.valueOf(request.getParameter("docNumber"));
		//System.out.println(docnumber);
		
		CheckService cs = new CheckService();
		
		CheckDoc docInfo = cs.getDocInfo(docnumber);
		//System.out.println(docInfo);
		
		String page="";
	
		RoundDoc doc = null;
		if(docInfo != null ) {
			request.setAttribute("info", docInfo);

			int dn = docInfo.getDocNumber();
			
			if(docInfo.getDocType().equals("품의서")) {
				doc = cs.getRoundD(docnumber);
				
			}else if(docInfo.getDocType().equals("지출결의서")) {
				doc = cs.getPayD(dn);
				
				
			}else {
				doc = cs.getVacD(dn);			
			}
			request.setAttribute("doc",doc);
			ArrayList<String> files = new ArrayList<String>();
			
			files = cs.getFiles(docnumber);
			request.setAttribute("files", files);
			
//			System.out.println(docInfo);
//			System.out.println(doc);
//			System.out.println(docInfo.getInPeople());
//			System.out.println(docInfo.getColPeople());
			page="views/checkdoc/read.jsp";
			
		}else {
			//에러
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
