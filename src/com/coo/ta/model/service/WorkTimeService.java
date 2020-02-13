package com.coo.ta.model.service;

import static com.coo.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import com.coo.exception.CooException;
import com.coo.ta.model.dao.TaDataDao;
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
	public HashMap<Integer, String> selectWorkTime(int empCode) throws CooException {
		
		Connection con = getConnection();
		
		HashMap<Integer, String> wtMap = wtDao.selectWorkTime(con, empCode);
		
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
		
		TaDataDao tdDao = new TaDataDao();
		
		//	INSERT 완료 후, 지각이 아니면 TA_DATA테이블의 WORKDAY_COUNT +1 (UPDATE)
		if(result > 0 && 900>wt.getWtTime()) {
			//	WORKDAY_COUNT UPDATE
			result = tdDao.workDayCountUpdate(con, wt.getEmpCode());
		}
		//	INSERT 완료 후, 지각이면 WORKDAY_COUNT / LATE_COUNT 각각 +1 (UPDATE)
		else if (result>0 && 900<wt.getWtTime()) {
			//	WORKDAY_COUNT UPDATE
			result = tdDao.workDayCountUpdate(con, wt.getEmpCode());
			
			//	LATE_COUNT UPDATE
			if(result > 0) {
				result = tdDao.lateCountUpdate(con, wt.getEmpCode());
			}
		}
		
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
