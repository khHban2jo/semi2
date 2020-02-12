package com.coo.ta.model.service;

import com.coo.exception.CooException;
import com.coo.ta.model.dao.WeekOverTimeDao;
import com.coo.ta.model.dao.WorkTimeDao;
import com.coo.ta.model.vo.WeekOverTime;

import static com.coo.common.JDBCTemplate.*;

import java.sql.Connection;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class WeekOverTimeService {

	private WeekOverTimeDao wotDao = new WeekOverTimeDao();

	/**
	 * 추가 근무 시간 등록 UPDATE 또는 INSERT
	 * @param wot
	 * @return
	 * @throws CooException
	 */
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

	/**
	 * 특근 추가 근무 시간 등록 UPDATE / INSERT
	 * @param wot
	 * @param now
	 * @return
	 * @throws CooException
	 */
	public int holiOverTime(WeekOverTime wot, String now) throws CooException {

		Connection con = getConnection();
		int result = 0;
		
		//	DB에 등록된 출근 시간 SELECT
		String stime = new WorkTimeDao().selectT1Time(con, wot.getEmpCode());
		
		//	now - stime 값 구하기 : overTime
		Date nowT = new Date();
		Date stimeT = new Date();
		
		SimpleDateFormat sdf = new SimpleDateFormat("HHmm");
		
		if(now.length() == 3) {
			now = "0"+now;
		}
		if(stime.length() == 3) {
			stime = "0"+stime;
		}
		
		//	테이블 insert T4로 하기
		try {
			nowT = sdf.parse(now);
			stimeT = sdf.parse(stime);
		} catch (ParseException e) {}
		
		long diff = nowT.getTime() - stimeT.getTime();
		
		diff = diff / 60000;
		
		long hour = diff/60;
		long min = diff%60;
		
		String hh = "";
		String mm = "";
		
		hh = ""+hour;
		if( min < 10 ) {
			mm = "0"+min;
		}else {
			mm = ""+min;
		}
		
		int overTime = Integer.parseInt(hh+mm);
		
		wot.setTodayOverTime(overTime);
		
		//	EMP_CODE와 TODAY_DATE 로 오늘 이미 등록된 overTime 이 있는지 확인
		WeekOverTime wotCheck = wotDao.selectWot(con, wot);
		
		if( wotCheck != null ) {
			//	있다면 update
			result = wotDao.updateWot(con, wot);
			System.out.println("추가(특근)근무시간 UPDATE");
		}else {
			//	없다면 insert
			result = wotDao.insertWot(con, wot);
			System.out.println("추가(특근)근무시간 INSERT");
		}
		
		if(result>0) commit(con);
		else rollback(con);
		
		close(con);
		
		return result;
		
	}

	public int selectOverTime(int empCode, int week) throws CooException {

		Connection con = getConnection();
		
		int allOverTime = wotDao.selectOverTime(con, empCode, week);
		
		close(con);
		
		return allOverTime;
	}
	
	
	
}















