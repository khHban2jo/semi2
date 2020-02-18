package com.coo.ta.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.coo.check.model.vo.CheckDoc;
import com.coo.check.model.vo.Vacation;
import com.coo.exception.CooException;
import com.coo.member.model.vo.Member;
import com.coo.ta.model.service.VacDocService;

/**
 * Servlet implementation class VacDocSelect
 */
@WebServlet("/vdSelect.ta")
public class VacDocSelect extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public VacDocSelect() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		Member emp = (Member)session.getAttribute("member");
		int empCode = emp.getEmpCode();
		
		Calendar cal = Calendar.getInstance();
		
		//	empCode, 현재 month로 APPROVAL 테이블 승인된 DOC_NUMBER 받아오기
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH)+1;
		String ym = (year-2000)+"/"+( month/10==0? "0"+""+month : month );
		
		ArrayList<CheckDoc> cdList = null;
		try {
			cdList = new VacDocService().selectApprval(empCode, ym);
			
			System.out.println("근태관리 open [APPROVAL SELECT]");
		} catch (CooException e) {
			//	에러 발생 시
			request.setAttribute("msg", "결재 문서를 불러 오는 중 에러 발생!");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
		
		String DateL1 = "예정일 없음";
		String DateL2 = "예정일 없음";
		String DateL3 = "예정일 없음";
		
		if(cdList.size() != 0) {
			//	cdList 값이 있을 경우
			//	휴가 종류와 날짜를 VACTABLE 테이블에서 받아오기
			try {
				ArrayList<Vacation> vList = new VacDocService().selectVac(cdList);
				for(Vacation v : vList) {
					if(v.getLeave_code().equals("L1")) {
						DateL1 = v.getStart_Date() + "~" + v.getEnd_Date();
					}else if(v.getLeave_code().equals("L2")) {
						DateL2 = "" + v.getStart_Date();
					}else {
						DateL3 = v.getStart_Date() + " " + ((v.getDayOff_MA()=="M")?"오전":"오후");
					}
				}
				System.out.println("[VACTABLE SELECT]");
			} catch (CooException e) {
				//	에러 발생 시
				request.setAttribute("msg", "결재 문서를 불러 오는 중 에러 발생!");
				request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
			}
		}
		
		PrintWriter out = response.getWriter();
		out.write(DateL1);
		out.write("-");
		out.write(DateL2);
		out.write("-");
		out.write(DateL3);
		
		out.flush();
		out.close();
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
