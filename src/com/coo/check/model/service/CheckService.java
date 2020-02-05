package com.coo.check.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.coo.check.model.dao.CheckDao;
import com.coo.check.model.vo.CheckDoc;

import static com.coo.common.JDBCTemplate.*;

public class CheckService {
	private CheckDao cDao = new CheckDao();

	public int getListCount(int id) {
		Connection con = getConnection();
		
		int listCount = cDao.getListCount(con, id);
		
		close(con);
		return listCount;
	}

	public ArrayList<CheckDoc> getList(int currentPage, int limitPage,int id) {
		Connection con = getConnection();
		
		ArrayList<CheckDoc> docs= cDao.getList(con, currentPage, limitPage, id);
		
		close(con);
		
		return docs;
	}

}