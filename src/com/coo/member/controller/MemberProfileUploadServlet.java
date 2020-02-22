package com.coo.member.controller;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.coo.member.model.service.MemberService;
import com.coo.member.model.vo.Member;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class MemberProfileUploadServlet
 */
@WebServlet("/mUploadPic.me")
public class MemberProfileUploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberProfileUploadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int maxSize = 1024 * 1024 * 10;
		
		if(!ServletFileUpload.isMultipartContent(request)) {
			request.setAttribute("msg","multipart를 통한 전송이 아닙니다.");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
		
		String root = request.getServletContext().getRealPath("/");
		String savePath = root + "resources/empProfiles";
		
		MultipartRequest mrequest = new MultipartRequest(request,savePath,maxSize, "UTF-8",new DefaultFileRenamePolicy());
		
		String fileName = mrequest.getFilesystemName("file");
		String empId = mrequest.getParameter("userId");
		int empCode = Integer.parseInt(mrequest.getParameter("empCode"));
		
		Member m = new Member();
		m.setEmpCode(empCode);
		m.setEmpId(empId);
		m = new MemberService().checkPicFiles(m);
		if(m !=null) {
			File file = new File(savePath +"/" + m.getProfileA());
			file.delete(); 
			m.setProfileA(fileName);
			m.setEmpCode(empCode);
			new MemberService().updatePic(m);
		}else {
			m = new Member();
			m.setProfileA(fileName);
			m.setEmpCode(empCode);
			new MemberService().uploadPic(m);
		}
		response.sendRedirect("close.do");
	}
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
