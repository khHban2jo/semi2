package com.coo.check.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

import com.coo.check.model.service.CheckService;
import com.coo.check.model.vo.PmapMember;
import com.google.gson.Gson;

/**
 * Servlet implementation class PeopleMapServlet
 */
@WebServlet("/pMap.ch")
public class PeopleMapServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PeopleMapServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=UTF-8");
		
		ArrayList<String> dcnList= null;
		ArrayList<PmapMember> pmapList = null;
		ArrayList<PmapMember> pmapValue= null;
		
		HashMap<String, ArrayList<PmapMember>> maplist 
								= new HashMap<String, ArrayList<PmapMember>>();
		
		//ArrayList<ArrayList<PmapMember>> maplist = new ArrayList<ArrayList<PmapMember>>();
		
		HashMap fullinglist = new HashMap();
		
		
		CheckService cs = new CheckService();
		
		PmapMember pm = null;
		//pmapValue = new ArrayList<PmapMember>();
		dcnList = cs.getDcnList();
		if(dcnList != null) {
			pmapList = cs.getPmapList();
			if(pmapList != null) {
				for(int i = 0; i< dcnList.size(); i++) {
					pmapValue = new ArrayList<PmapMember>();
					for(int j = 0; j<pmapList.size(); j++){
						if(dcnList.get(i).equals(pmapList.get(j).getDeptName())) {
							pm = pmapList.get(j);
							pmapValue.add(pm);
						}
					}
					maplist.put(dcnList.get(i), pmapValue);
					//maplist.add(pmapValue);
				}
				fullinglist.put("list1",dcnList);
				fullinglist.put("list2", maplist);
				//new Gson().toJson(maplist,response.getWriter());
				new Gson().toJson(fullinglist,response.getWriter());
			}else {
				System.out.println("서블릿 pmapnull");
			}
		}else {
			System.out.println("서블릿 dcn못가져옴");
		}
		
//		for(int i = 0; i<dcnList.size(); i++) {
//			for(int j = 0; j<maplist.get(dcnList.get(i)).size(); j++){
//				if(maplist.get(dcnList.get(i)).size()==0) {
//				break;
//				}
//			System.out.println(maplist.get(dcnList.get(i)).get(j));
//			}
//		}
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
