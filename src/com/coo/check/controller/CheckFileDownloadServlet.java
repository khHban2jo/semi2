package com.coo.check.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CheckFileDownloadServlet
 */
@WebServlet("/cfDown.ch")
public class CheckFileDownloadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckFileDownloadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
			//저장하고자 하는 파일 이름 가져오기
			String fileName = request.getParameter("path");
			
			//실제 파일이 저장된 폴더의 경로 가져오기
			String folder = request.getServletContext().getRealPath("resources/approvalFiles");
			
			//파일을 서버에서 사용자에게 전달
			// 다운로드용 객체 생성 ServletOutputStream
			ServletOutputStream downStream = response.getOutputStream();
			//네스워크로 전달할 설정들을 헤더라는 설정 공간에 등록시켜주기 (전채적인 게 정해져있다 -> 따라 쓰자.)
			response.addHeader("Content-Disposition", "attachment; filename=\""
					+new String(fileName.getBytes("UTF-8"),"ISO-8859-1")+"\"");
			
			//다운받을 파일 경로
			File downFile = new File(folder+"/"+fileName);
			
			//상대방의 용량 체크(전송할 크기만큼 사용자 컴퓨터에게 공간 확보 요청하기)
			response.setContentLength((int)downFile.length());
			
			BufferedInputStream bin = new BufferedInputStream(new FileInputStream(downFile));
			
			int readData= 0;
			
			while((readData = bin.read()) !=-1) {
				downStream.write(readData);
			}
			downStream.close();
			bin.close();
			
			
		}
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
