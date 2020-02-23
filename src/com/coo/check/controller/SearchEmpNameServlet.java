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
 * Servlet implementation class SearchEmpNameServlet
 */
@WebServlet("/sEName.ch")
public class SearchEmpNameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchEmpNameServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("application/json; charset=UTF-8");
		
		
		// 받는 값 스트링 ", " 형태의 값 , 부서명
		
		//스플릿후 조인된 테이블에서  정 부 아이디  부서 코드 검색 후 반환
		
		// 반환된 정보를 가지고 객체에 넣고, 정 부 이름을  가져온다.
		
		// 반환 객체 : 부서코드 , 정부 코드, 정부 이름
		Map fulling = new HashMap();
		
		
		
		if(!request.getParameter("pcodes").equals("")) {
			String deptcode ="";
			String[] arr = request.getParameter("pcodes").split(",");

			ArrayList<String> dename = new ArrayList<>();
			ArrayList<Integer> pcode = new ArrayList<>();
			for(int i = 0; i<arr.length; i++) {
				String[] ar2 = arr[i].split(" ");
				 pcode.add(Integer.valueOf(ar2[0]));
				dename.add(ar2[1]);
			}
			
			
			
			CheckService cs = new CheckService();
			ArrayList<StockLine> getMassub = cs.getMassub(pcode, dename);// 정부부서코드 가져오기
			
			
			
			ArrayList<Integer> savePcodes = new ArrayList<>();
			for(int i = 0; i<getMassub.size();i++) {
			
				savePcodes.add(getMassub.get(i).getEmpcode());
				savePcodes.add(getMassub.get(i).getSubcode());	
				
				
			}
		
		
			ArrayList<String> getMSName = cs.getMSName(savePcodes);		
			//정부 정부 정부 정부
			for(int i = 0; i<getMSName.size();i++) {
				//System.out.println(getMSName.get(i));
			}
			fulling.put("list1",dename);
			fulling.put("list2",savePcodes);
			fulling.put("list3", getMSName);
			
			new Gson().toJson(fulling, response.getWriter());

			
		 }else {
			 new Gson().toJson("정보를 가져오지 못했습니다.", response.getWriter());
		}
		
		

		
		
//		
//		String[] arr = {"100", "204"};
//		String dename = "임원";
//		CheckService cs = new CheckService();
//		ArrayList<StockLine> getMassub = cs.getMassub(arr, dename);
//		
//		for(int i = 0; i<getMassub.size(); i++) {
//			System.out.println(getMassub.get(i));
//		}

//			for(int i = 0; i<getMassub.size(); i++) {
//			System.out.println(getMSName.get(i));
//			}
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
