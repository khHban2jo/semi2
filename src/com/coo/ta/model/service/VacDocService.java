package com.coo.ta.model.service;

import static com.coo.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

import com.coo.check.model.vo.CheckDoc;
import com.coo.check.model.vo.Vacation;
import com.coo.exception.CooException;
import com.coo.ta.model.dao.VacDocDao;

public class VacDocService {

	private VacDocDao vdDao = new VacDocDao();

	public ArrayList<CheckDoc> selectApprval(int empCode, String ym) throws CooException {

		Connection con = getConnection();
		
		ArrayList<CheckDoc> cdList = vdDao.selectApprval(con, empCode, ym);
		
		close(con);
		
		return cdList;
	}

	public ArrayList<Vacation> selectVac(ArrayList<CheckDoc> cdList) throws CooException {

		Connection con = getConnection();
		
		ArrayList<Vacation> vList = vdDao.selectVac(con, cdList);
		
		close(con);
		
		return vList;
	}
	
	
}
