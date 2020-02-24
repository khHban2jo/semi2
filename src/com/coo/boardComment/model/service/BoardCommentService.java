package com.coo.boardComment.model.service;

import com.coo.boardComment.model.dao.BoardCommentDao;
import com.coo.boardComment.model.vo.BoardComment;
import com.coo.exception.CooException;

import static com.coo.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;
public class BoardCommentService {

	private BoardCommentDao bcDao = new BoardCommentDao();
	
	public ArrayList<BoardComment> selectList(int bno){
		Connection con = getConnection();
		
		ArrayList<BoardComment> clist = null;
		try {
			clist = bcDao.selectList(con,bno);
			
		} catch (CooException e) {
			e.getMessage();
		}
		
		close(con);
		
		return clist;
	}
	
	
	public int insertComment(BoardComment bco) {
		Connection con = getConnection();
		
		int result = 0;
		
		try {
			result = bcDao.insertComment(con,bco);
		} catch (CooException e) {
			e.getMessage();
		}
		
		if(result>0) commit(con); else rollback(con);
		
		close(con);
		
		return result;
	}

}
