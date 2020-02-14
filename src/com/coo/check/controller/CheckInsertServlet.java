package com.coo.check.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.coo.check.model.service.CheckService;
import com.coo.check.model.vo.*;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.sun.xml.internal.bind.v2.model.util.ArrayInfoUtil;


/**
 * Servlet implementation class CheckInsertServlet
 */
@WebServlet("/cInsert.ch")
public class CheckInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unused")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	//1. 제목 작성자no 문서서종류   현재결재진행자(내부결재 인원 잘라서 1번,2번 인덱스) 결재부서  내부 결재인원 내부결재상황(렝스/2 의 0,0,0) 합의부서 합의인원 합의결재상황 , 최종결재자, 참조자 , 파일
	//2. 내용 문서에 따른 컬럼값 가져오기
	//서비스에 객체 두개 넘기기.
		
//		if(!ServletFileUpload.isMultipartContent(request)) {
//			//에러 페이지 메세지와 리퀘스트
//			
//		}
//		
		int maxSize = 1024*1024*50;
		
		String root = request.getServletContext().getRealPath("/");
		String savePath = root+"resources/approvalFiles";
		
		MultipartRequest mrequest = new MultipartRequest(
				request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy()
				);
		
		
		
		String doctitle = mrequest.getParameter("doctitle");   
		int docwriter = Integer.valueOf(mrequest.getParameter("empcode")); //int로 바꿀것
		String doctype =mrequest.getParameter("doctype");
		String deptCode = mrequest.getParameter("checkdeptC");
		String deptName = mrequest.getParameter("checkdeptN");
		String checkper = mrequest.getParameter("checkper");
		String coldeptCode= mrequest.getParameter("coldeptC");
		String coldeptName = mrequest.getParameter("coldeptN");
		String colper = mrequest.getParameter("colper");
		String enddeptC = mrequest.getParameter("enddeptC");
		String enddeptN = mrequest.getParameter("enddeptN");
		String endper = mrequest.getParameter("endper");
		String viewper = mrequest.getParameter("viewper");
		
//		System.out.println("doctitle" + doctitle);
//		System.out.println("docwriter" + docwriter);
//		System.out.println("deptCode" + deptCode);
//		System.out.println("deptName" + deptName);
//		System.out.println("checkper" + checkper);
//		System.out.println("coldeptCode" + coldeptCode);
//		System.out.println("coldeptName" + coldeptName);
//		System.out.println("colper" + colper);
//		System.out.println("enddeptC" + enddeptC);
//		System.out.println("enddeptN" + enddeptN);
//		System.out.println("endper" + endper);
//		System.out.println("viewper" + viewper);
		
		
		
		
		
		
		String[] arr= checkper.split(",");
		StringBuffer a = new StringBuffer();
		String approval = arr[0]+","+ arr[1];
		for(int i = 0; i<arr.length/2; i++) {
			if(i== 0) {
				a.append("5,");
			}else if(i<arr.length/2-1) {
				a.append("0,");
			}else {
				a.append("0");
			}
		}
		
		String inStatus = a.toString() ;
		//System.out.println(inStatus);
		a.delete(0, maxSize);
		
		String colStatus ="";
		if(coldeptCode!=null) {
			arr= colper.split(", ");
			for(int i = 0; i<arr.length/2; i++) {
				if(i== 0) {
					a.append("5,");
				}else if(i<arr.length/2-1) {
					
					a.append("0,");
					
				}else {
					a.append("0");
				}
			}
			colStatus =a.toString();
		}
		
		System.out.println(colStatus);
		
		ArrayList<String> files = new ArrayList<String>();
		
		//String fileName = mrequest.getParameter("fileup");
		
//		for(int i = 0; i <5; i++) {
//			String str = "file"+i;
//			String filechan = mrequest.getFilesystemName(str);
//			System.out.println(filechan);
//			if(!filechan.equals(null)) {
//				files.add(filechan);
//			}
//		}
		
		

	
		CheckDoc info= new CheckDoc(doctitle,docwriter,doctype, approval,deptCode,deptName , checkper, inStatus,coldeptCode,coldeptName
					, colper,colStatus,enddeptC,enddeptN, endper,viewper
									);
		System.out.println(info);
		

		RoundDoc doc = null;
		if(info.getDocType() == "휴가신청서") {
			doc = new Vacation();
			//((Vacation)doc).setStart();
			//((Vacation)doc).setEnd();
			//((Vacation)doc).setType();
		}else if(info.getDocType()=="지출결의서") {
			doc = new PayDoc();
			((PayDoc)doc).setEndPay(200241);
		}else {
			doc = new RoundDoc();
		}
		doc.setText(mrequest.getParameter("text"));
		
		
		
		int result = new CheckService().insertDoc(info, doc, files);
		
		if(result>0) {
			response.sendRedirect("clist.ch");
		}else {
			System.out.println("오류");
			//오류페이지
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
