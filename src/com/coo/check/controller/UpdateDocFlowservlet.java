package com.coo.check.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.coo.check.model.service.CheckService;
import com.coo.check.model.vo.CheckDoc;
import com.google.gson.Gson;

/**
 * Servlet implementation class UpdateDocFlowservlet
 */
@WebServlet("/uDFlow.ch")
public class UpdateDocFlowservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateDocFlowservlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json; charset=UTF-8");
		/*dcoNumber: docNo,
		next : approin,
		docSt : docStatus,
		inCode : insertcode,
		colcodes : colcode,
		rcomment : comment
		doctype*/
		int docNo = Integer.valueOf(request.getParameter("docNumber"));
		int docSt = Integer.valueOf(request.getParameter("docSt"));
		String next = request.getParameter("next");
		String inCode = request.getParameter("inCode");
		String colCodes = request.getParameter("colcodes");
		String recomment = request.getParameter("rcomment");
		String doctype = request.getParameter("doctype");
		
		
/*		System.out.println("문서번호 :"+ docNo);
		System.out.println("독스텟 :"+ docSt);
		System.out.println("다음인원 :"+ next);
		System.out.println("inCode :"+ inCode);
		System.out.println("colCodes :"+ colCodes);
		System.out.println("recomment :"+ recomment);
		System.out.println("doctype : "  + doctype);*/
	
		//info만들어서 로직
	
		CheckDoc info = new CheckDoc(docNo,docSt,next,inCode,colCodes,recomment);
		
		CheckService cs = new CheckService();
		String ok = "완료";
		int result =  cs.updateInfo(info);

		if(result >0) {
			if(doctype.equals("휴가신청서")) {
				//업데이트 할예정
				
			}
			
		
			//response.sendRedirect("/cread.ch?docNumber="+docNo);
			new Gson().toJson(ok,response.getWriter());
		
		}else {
			System.out.println("에러");
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
