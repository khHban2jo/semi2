package com.coo.notice.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.coo.notice.model.vo.Notice;
import com.coo.notice.service.NoticeService;
import com.google.gson.Gson;

@WebServlet("/noticeAjax.no")
public class noticeAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public noticeAjax() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=UTF-8");

		ArrayList<Notice> list = new ArrayList<Notice>();

		list = new NoticeService().noticeAjax();

		System.out.println("list 값 확인");
		for (Notice out : list) {
			System.out.println(out.toString());
		}

		// 자바 객체 데이터를 뷰단에서 쓸수 있도록 자바스크립트 형식으로 변환
		JSONObject notice = null; // 자바 객체를 받게 하는 객체
		JSONArray result = new JSONArray(); // 자바 list형태로 데이터를 넘기기 위한 객체

//		PrintWriter pw=response.getWriter();

//		for (Notice out : list) {
//			notice = new JSONObject();
//
//			notice.put("Nno", out.getNno());
//			notice.put("Ntitle", out.getNtitle());
//			notice.put("Nwriter", out.getNwriter());
//			notice.put("Ndate", out.getNdate());
//			notice.put("Ncount", out.getNcount());
//
//			System.out.println("notice : " + notice.toJSONString());
//			result.add(notice);
//		}
//		System.out.println("result : " + result.toJSONString());
//		response.getWriter().print(result.toJSONString());

		new Gson().toJson(list,response.getWriter());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
