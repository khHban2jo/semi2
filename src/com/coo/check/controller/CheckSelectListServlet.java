package com.coo.check.controller;
//package com.coo.check.controller;
//
//import java.io.IOException;
//import java.util.ArrayList;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import com.coo.check.model.service.CheckService;
//import com.coo.check.model.vo.CheckDoc;
//import com.coo.check.model.vo.PageInfo;
//
///**
// * Servlet implementation class CheckSelectListServlet
// */
//@WebServlet("/CheckSelectListServlet")
//public class CheckSelectListServlet extends HttpServlet {
//	private static final long serialVersionUID = 1L;
//       
//    /**
//     * @see HttpServlet#HttpServlet()
//     */
//    public CheckSelectListServlet() {
//        super();
//        // TODO Auto-generated constructor stub
//    }
//
//	/**
//	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
//	 */
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		request.setCharacterEncoding("UTF-8");
//		 //세션에서 empno , 파라미터로 문서 종류 가져오기
//		String id = request.getParameter("id");
//		int status = Integer.valueOf(request.getParameter("ASTAT"));
//		ArrayList<CheckDoc> list = null;
//		//페이징 처리
//		
//		//1.  총 게시글수
//		int checkListCount;
//		
//		//2. 페이징시 시작 
//		int startPaging;
//		
//		//3. 페이징 끝
//		
//		int endPaging;
//		
//		//4. 마지막 페이징
//		int maxPaging;
//		
//		//5. 한줄에 들어갈 페이징수
//		int limitPaging;
//		
//		//6. 한번에 보일 페이지
//		int limitPage;
//		
//		//7. 현재  있는 페이징
//		int currentPage;
//		
//		limitPaging = 5;
//		limitPage = 10;
//		
//		currentPage = 1;
//		
//		
//		if(request.getParameter("currentPage")!=null) {
//			currentPage = Integer.valueOf(request.getParameter("currentPage"));
//		}
//		
//		//페이징 시작
//		CheckService cs = new CheckService();
//		
//		//게시글 총갯수
//		checkListCount = cs.getSelectListCount(id,status);
//		System.out.println(checkListCount +"서블릿 카운트");
//		
//		startPaging = ((int)((double)currentPage/limitPaging +0.9)-1)*limitPaging+1;
//		
//		endPaging = startPaging +limitPaging -1;
//		
//		maxPaging = (int)((double)checkListCount/limitPage+0.9);
//		
//		if(maxPaging< endPaging) {
//			endPaging = maxPaging;
//		}
//		System.out.println(currentPage +"  " + limitPage +"  "+   id);
//		
//		list = cs.getList(currentPage,limitPage, id);
//		String page="";
//		
//		if(list!=null) {
//			request.setAttribute("list", list);
//			
//			PageInfo pi = new PageInfo();
//			
//			pi = new PageInfo(checkListCount,startPaging,endPaging,maxPaging,limitPaging,limitPage,currentPage);
//			request.setAttribute("pi", pi);
//			
//			page = "views/EP_list.jsp";
//		
//		}
//		//else {
////			request.setAttribute("msg", "정보를 가져오지 못했습니다.");
////			page ="views/common/errorPage";
////					
////		}
//		
//		request.getRequestDispatcher(page).forward(request, response);
//		
//	}
//
//	/**
//	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
//	 */
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		doGet(request, response);
//	}
//
//}
