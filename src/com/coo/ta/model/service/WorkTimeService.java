package com.coo.ta.model.service;

import static com.coo.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import com.coo.exception.CooException;
import com.coo.ta.model.dao.WorkTimeDao;
import com.coo.ta.model.vo.WeekOverTime;
import com.coo.ta.model.vo.WorkTime;

public class WorkTimeService {

	private WorkTimeDao wtDao = new WorkTimeDao();
	
	/**
	 * T1(출근) T2(퇴근) 시간 SELECT
	 * @param empCode
	 * @return
	 * @throws CooException
	 */
	public HashMap selectWorkTime(int empCode) throws CooException {
		
		Connection con = getConnection();
		
		HashMap wtMap = wtDao.selectWorkTime(con, empCode);

		close(con);
		
		return wtMap;
	}
	
	/**
	 * 출근 등록
	 * @param wt
	 * @return
	 * @throws CooException
	 */
	public int wtT1Insert(WorkTime wt) throws CooException {
		
		Connection con = getConnection();
		
		int result = wtDao.wtT1Insert(con, wt);
		
		if(result > 0 ) commit(con);
		else rollback(con);
		
		close(con);
		
		return result;
	}

	/**
	 * 퇴근 등록
	 * @param wt
	 * @return
	 * @throws CooException
	 */
	public int wtT2Insert(WorkTime wt) throws CooException {
		
		Connection con = getConnection();
		int result = 0;
		
		//	이미 입력된 T2값이 있는지 확인
		WorkTime wtCheck = wtDao.selectT2(con, wt);
		
		if(wtCheck != null) {
			//	있으면 UPDATE
			result = wtDao.wtT2Update(con, wt);
			System.out.println("퇴근 시간 UPDATE");
		}else {
			//	없으면 INSERT
			result = wtDao.wtT2Insert(con, wt);
			System.out.println("퇴근 시간 INSERT");
		}
		
		if(result > 0 ) commit(con);
		else rollback(con);
		
		close(con);
		
		return result;
	}
	
}
