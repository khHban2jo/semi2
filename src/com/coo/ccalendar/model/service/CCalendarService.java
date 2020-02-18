package com.coo.ccalendar.model.service;

import com.coo.ccalendar.model.vo.CCalendar;
import com.coo.ccalendar.model.dao.CCalendarDao;

import static com.coo.common.JDBCTemplate.*;

import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;

public class CCalendarService {
	
	private CCalendarDao cDao = new CCalendarDao();//

	public int insertCalendar(CCalendar c) {

		//오라클과 연결
		Connection con = getConnection();
		
		int result = cDao.insertCalendar(c,con);
		
		//commit ,rollback :행의 갯수가 입력되면 (1이상이면) 커밋, 그렇지 않으면 롤백
		if(result > 0 ) commit(con);
		else rollback(con);
		
		close(con);
		
		return result;
	}
/*
	*//** 등록된 일정 조회용
	 * @return
	 *//*
	public ArrayList<Calendar> selectList() {
		Connection con = getConnection();
		
		ArrayList<Calendar> list = cDao.selectList(con);
		
		close(con);
		
		return list;
	}
*/
	
	
	/**
	 * 
	 * @param sqlDate
	 * @return
	 */
	public ArrayList<CCalendar> selectToday(Date sqlDate) {
		
		Connection con = getConnection();
		
		ArrayList<CCalendar> list =cDao.selectToday(con, sqlDate);
		
		close(con);
		
		return list;
		
		
		
	}

}
