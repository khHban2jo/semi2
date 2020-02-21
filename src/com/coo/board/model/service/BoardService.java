package com.coo.board.model.service;

import static com.coo.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.Hashtable;

import com.coo.board.model.dao.BoardDao;
import com.coo.board.model.vo.Board;
import com.coo.exception.CooException;

public class BoardService {

	private BoardDao bDao = new BoardDao();
	
	public int getListCount(){
		Connection con = getConnection();
		
		int result = 0;
		try {
			result = bDao.getListCount(con);
		} catch (CooException e) {
			e.getMessage();
		}
		
		close(con);
		
		return result;
	}

	public ArrayList<Board> selectList(int currentPage, int limit,String deptView) {
		Connection con = getConnection();
		
		ArrayList<Board> list = null;
		try {
			list = bDao.selectList(con,currentPage,limit,deptView);
		} catch (CooException e) {
			e.getMessage();
		}
		
		close(con);
		
		return list;
	}

	public Board selectOne(int bno) throws CooException {
		Connection con = getConnection();
		
		Board b = bDao.selectOne(con,bno);
		
		close(con);
		
		return b;
	}

	public int updateReadCount(int bno) throws CooException {
		Connection con = getConnection();
		
		int result = bDao.updateReadCount(con,bno);
		
		if(result >0) commit(con); else rollback(con);
		
		close(con);
		
		return result;
	}

	public int insertBoard(Board b){
		Connection con = getConnection();
		
		int result = 0;
		try {
			result = bDao.insertBoard(con,b);
		} catch (CooException e) {
			e.getMessage();
		}
		
		if(result > 0) commit(con); else rollback(con);
		
		close(con);
		
		return result;
	}

	public Board updateView(int bno) {
		Connection con = getConnection();
		
		Board b = null;
		try {
			b = bDao.selectOne(con,bno);
		} catch (CooException e) {
			e.getMessage();
		}
		close(con);
		
		return b;
	}

	public int updateBoard(Board b) {
		Connection con = getConnection();
		
		int result = 0;
		try {

			result = bDao.updateBoard(con,b);
			
			if(result>0) commit(con); else rollback(con);
			
		} catch (CooException e) {
			e.getMessage();
		}
		close(con);
		
		return result;
	}

	public int deleteBoard(int bno) {
		Connection con = getConnection();
		
		int result =0;
		try {
			result = bDao.deleteBoard(con,bno);
			
			if(result>0) commit(con); else rollback(con);
			
		}catch(CooException e) {
			e.getMessage();
		}
		
		close(con);
		
		return result;
	}

// ========================== 검색을 위한 코드 ==================================
	
	public ArrayList<Board> getListCount(Hashtable<String, String> parameters, ArrayList<Board> list) {
		Connection con = getConnection();
		
		ArrayList<Board> result = new ArrayList<Board>();
		try {
			result = bDao.getListCount(con, parameters, list);
		} catch (Exception e) {
			e.getMessage();
		}
		
		close(con);
		
		return result;
	}

	public ArrayList<Board> selectListFive(String deptCode) {
		Connection con = getConnection();
		ArrayList<Board> list = null;
		try {
			
			list = bDao.selectListFive(con,deptCode);
		}catch(CooException e) {
			e.getMessage();
		}
		
		close(con);
		
		return list;
	}
	
}
