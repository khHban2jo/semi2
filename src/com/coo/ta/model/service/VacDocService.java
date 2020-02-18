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

	/**
	 * 이번 달 결재 문서 가져오기
	 * @param empCode
	 * @param ym
	 * @return
	 * @throws CooException
	 */
	public ArrayList<CheckDoc> selectApprval(int empCode, String ym) throws CooException {

		Connection con = getConnection();
		
		ArrayList<CheckDoc> cdList = vdDao.selectApprval(con, empCode, ym);
		
		close(con);
		
		return cdList;
	}

	/**
	 * 결재 문서 중 Vacation 문서 SELECT
	 * @param cdList
	 * @return
	 * @throws CooException
	 */
	public ArrayList<Vacation> selectVac(ArrayList<CheckDoc> cdList) throws CooException {

		Connection con = getConnection();
		
		ArrayList<Vacation> vList = vdDao.selectVac(con, cdList);
		
		close(con);
		
		return vList;
	}

	public ArrayList<CheckDoc> selectApprovalList(int empCode) throws CooException {

		Connection con = getConnection();
		ArrayList<CheckDoc> cdList = vdDao.selectApprovalList(con, empCode);
		close(con);
		return cdList;
	}
	
	
}
