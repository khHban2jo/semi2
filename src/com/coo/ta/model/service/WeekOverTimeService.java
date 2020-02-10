package com.coo.ta.model.service;

import com.coo.exception.CooException;
import com.coo.ta.model.dao.WeekOverTimeDao;
import com.coo.ta.model.vo.WeekOverTime;

import static com.coo.common.JDBCTemplate.*;

import java.sql.Connection;

public class WeekOverTimeService {

	private WeekOverTimeDao wotDao = new WeekOverTimeDao();

	public int overTime(WeekOverTime wot) throws CooException {

		Connection con = getConnection();
		int result = 0;
		
		//	오늘 날짜로 입력된 값이 있는지 확인 (select)
		WeekOverTime wotCheck = wotDao.selectWot(con, wot);
		
		if( wotCheck != null ) {
			//	있다면 update
			result = wotDao.updateWot(con, wot);
			System.out.println("추가근무시간 UPDATE");
		}else {
			//	없다면 insert
			result = wotDao.insertWot(con, wot);
			System.out.println("추가근무시간 INSERT");
		}
		
		if(result>0) commit(con);
		else rollback(con);
		
		
		close(con);
		
		return result;
	}
	
	
}
