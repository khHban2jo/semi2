package com.coo.board.model.service;

import static com.coo.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

import com.coo.board.model.dao.BoardDao;
import com.coo.board.model.vo.Board;
import com.coo.exception.CooException;

public class BoardService {

	private BoardDao bDao = new BoardDao();
	
	public int getListCount() throws CooException{
		Connection con = getConnection();
		
		int result = bDao.getListCount(con);
		
		close(con);
		
		return result;
	}

	public ArrayList<Board> selectList(int currentPage, int limit) throws CooException {
		Connection con = getConnection();
		
		ArrayList<Board> list = bDao.selectList(con,currentPage,limit);

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

	public int insertBoard(Board b) throws CooException {
		Connection con = getConnection();
		
		int result = bDao.insertBoard(con,b);
		
		if(result > 0) commit(con); else rollback(con);
		
		close(con);
		
		return result;
	}

}
