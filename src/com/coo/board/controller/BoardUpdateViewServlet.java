package com.coo.board.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.coo.board.model.service.BoardService;
import com.coo.board.model.vo.Board;

/**
 * Servlet implementation class BoardUpdateViewServlet
 */
@WebServlet("/bUpView.bo")
public class BoardUpdateViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardUpdateViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int bno = Integer.parseInt(request.getParameter("bno"));
		
		Board b = new BoardService().updateView(bno);
		
		if(b != null) {
			request.setAttribute("board", b);
//			PrintWriter out = response.getWriter();
//			 out.println("<script>");
//			 out.println("var url = '/semi/views/se2/modify.jsp';");
//		  	 out.println("var name= '수정'");	 
//		  	 out.println("var option='top=200px,left=500px,width=850px,height=550px,location=no,resizable=no,toolbars=no';");
//		  	 out.println("window.open(url,name,option)");
//		  	 out.println("</script>");
//		  	 out.flush();
//		  	 out.close();
		  	 request.getRequestDispatcher("views/se2/modify.jsp").forward(request, response);
		}else {
			request.setAttribute("msg","에러발생");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);;
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
