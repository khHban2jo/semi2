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


	/**
	 * 일정 수정용 메소드
	 * @param c
	 * @return
	 */
	public int updateCalendar(CCalendar c) {
		//DB와 연결합니다
		Connection con = getConnection();
		
		int result = cDao.updateCalendar(con, c);
		//---------------------------------------
		
		//커밋, 롤백
		if(result > 0) commit(con);
		else rollback(con);
		
		
		//닫아주기
		close(con);
		
		
		return result;
	}


	/**
	 * 일정 삭제용 메소드
	 * @param title
	 * @return
	 */
	public int deleteCalendar(String cno) {
		Connection con = getConnection();
		int result = cDao.deleteCalendar(con, cno);
		//---------------------------------------------
		//커밋, 롤백
		if(result > 0) commit(con);
		else rollback(con);
		
		//닫기
		close(con);
		
		return result;
	}


	/**
	 * 상세일정 팝업페이지 보기
	 * @param cno
	 * @return
	 */
	public CCalendar selectOne(String cno) {

		Connection con = getConnection();
		
		CCalendar c = cDao.selectOne(con,cno);
		
		//----------------
		
		close(con);
		return c;
	}

	
	
}
