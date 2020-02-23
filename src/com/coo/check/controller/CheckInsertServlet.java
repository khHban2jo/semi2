package com.coo.check.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.GregorianCalendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.coo.check.model.service.CheckService;
import com.coo.check.model.vo.CheckDoc;
import com.coo.check.model.vo.PayDoc;
import com.coo.check.model.vo.RoundDoc;
import com.coo.check.model.vo.Vacation;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


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
		
		if(!ServletFileUpload.isMultipartContent(request)) {
			//에러 페이지 메세지와 리퀘스트
			System.out.println("타입 오류");
		}
		
		int maxSize = 1024*1024*10;
		String root = request.getServletContext().getRealPath("/");
		String savePath = root+"resources/approvalFiles";
		
		MultipartRequest mrequest = new MultipartRequest(
				request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy()
				);
		
		
		
		String doctitle = mrequest.getParameter("doctitle");   
		int docwriter = Integer.valueOf(mrequest.getParameter("empcode")); //int로 바꿀것
		String docwirteName = mrequest.getParameter("docwriterName");
		String doctype =mrequest.getParameter("doctype");
		String deptName = mrequest.getParameter("deptcode");
		String indept = mrequest.getParameter("chdept");
		String checkper = mrequest.getParameter("checkper");
		String coldeptCode= mrequest.getParameter("codept"); 
		String colper = mrequest.getParameter("colper");
		String viewper = mrequest.getParameter("viewper");
		
		//System.out.println("넘어가냐");
		//System.out.println(doctype);
		
	
		
		if(mrequest.getParameter("checkper")==null) {
			request.setAttribute("msg", "결재자가 없습니다.");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
		String[] arr= checkper.split(",");
		StringBuffer a = new StringBuffer();
		String approval = arr[0]+","+ arr[1];
		for(int i = 0; i<arr.length/2; i++) {
			if(i== 0) {
				a.append("5");
				if(arr.length/2-1 >0) {
					a.append(",");
				}
			}else if(i<arr.length/2-1) {
				a.append("0,");
			}else {
				a.append("0");
			}
		}
		
		String inStatus = a.toString() ;
		//System.out.println(inStatus);

		a = new StringBuffer();
		String colStatus ="";
		if(!mrequest.getParameter("colper").equals("")) {     
			
			arr= colper.split(",");
			for(int i = 0; i<arr.length/2; i++) {
				if(i== 0) {
					a.append("0");
					if(arr.length/2-1 >0) {
						a.append(",");
					}
				}else if(i<arr.length/2-1) {
					a.append("0,");
					
				}else {
					a.append("0");
				}
			}
			colStatus =a.toString();
		}
		
		//System.out.println(colStatus);
		String file ;
	
		//
		ArrayList<String> files = new ArrayList<String>();
		for(int i = 0; i<5; i++) {
			 if(mrequest.getFilesystemName("file"+i) != null &&!mrequest.getFilesystemName("file"+i).equals("")) {
					file = mrequest.getFilesystemName("file"+i);
					files.add(file);
					//System.out.println(file);
				 }
		}
		
		

	
		CheckDoc info= new CheckDoc(doctitle,docwriter,docwirteName,deptName,doctype, approval, indept, checkper, inStatus,coldeptCode
					, colper,colStatus,viewper);
		//System.out.println(info);
		
		String text;
		RoundDoc doc = null;
		if(info.getDocType().equals("휴가신청서")) {
			doc = new Vacation();
			//leave_code,endDate,startDate,dayOffType
			String leaveCode = mrequest.getParameter("leaveCode");
			String startDate = mrequest.getParameter("startDate");
			String endDate = null;
			System.out.println(mrequest.getParameter("endDate"));
			if(mrequest.getParameter("endDate")== null || mrequest.getParameter("endDate").equals("")) {
				endDate = mrequest.getParameter("startDate");
			}else {
				endDate = mrequest.getParameter("endDate");
			}
			String dot= null;
			if(mrequest.getParameter("dayOffType")== null) {
				dot="N";
			}else {
				dot = mrequest.getParameter("dayOffType");//값보고 N으로 넘어가게
			}
			
			Date sd = null;
			Date ed = null;
			
			String[] sdArr = startDate.split("-");
			String[] edArr = endDate.split("-");
			int year = Integer.valueOf(sdArr[0]);
			int month = Integer.valueOf(sdArr[1]);
			int day = Integer.valueOf(sdArr[2]);
			
			sd = new Date(new GregorianCalendar(
					year,month-1,day 
					).getTimeInMillis());
			
			year = Integer.valueOf(edArr[0]);
			month = Integer.valueOf(edArr[1]);
			day =  Integer.valueOf(edArr[2]);
			
			ed = new Date(new GregorianCalendar(
					year,month-1,day 
					).getTimeInMillis());
			 
			((Vacation)doc).setLeave_code(leaveCode);
			((Vacation)doc).setStart_Date(sd);
			((Vacation)doc).setEnd_Date(ed);
			((Vacation)doc).setDayOff_MA(dot);
		}else if(info.getDocType().equals("지출결의서")) {
		
			int paid = Integer.valueOf(mrequest.getParameter("endpay"));
			doc = new PayDoc();
			((PayDoc)doc).setEndPay(paid);
		}else {
			doc = new RoundDoc();
		}
		text = mrequest.getParameter("text");
		///+/
		doc.setText(text);
		//System.out.println(text);
		
	
		int result = new CheckService().insertDoc(info, doc, files);
		//System.out.println(result);
		if(result>0) {
			response.sendRedirect("close.do");
		}else {
			request.setAttribute("msg", "문서작성 오류입니다.");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
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
