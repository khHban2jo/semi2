package com.coo.ta.model.vo;

import java.io.Serializable;

public class WeekOverTime implements Serializable{
	
	/**
	 * 	WEEK_OVERTIME 테이블 객채 (추가 근무 시간 관리 용)
	 */
	private static final long serialVersionUID = -4926295766420234239L;
	
	private int empCode;		//	사번	O
	private String todayDate;	//	근무 날짜	X
	private int todayOverTime;		//	추가 근무 시간	O
	private int weekOfYear;	//	xx주 차	O
	private int theWeek;		//	x주 차 야근 시간 합	O
	
	public WeekOverTime() {}
	
	public WeekOverTime(int empCode, String todayDate, int todayOverTime, int weekOfYear, int theWeek) {
		super();
		this.empCode = empCode;
		this.todayDate = todayDate;
		this.todayOverTime = todayOverTime;
		this.weekOfYear = weekOfYear;
		this.theWeek = theWeek;
	}



	/**
	 * 입력 용
	 * @param empCode
	 * @param time
	 * @param weekOfYear
	 * @param theWeek
	 */
	public WeekOverTime(int empCode, int todayOverTime, int weekOfYear, int theWeek) {
		super();
		this.empCode = empCode;
		this.todayOverTime = todayOverTime;
		this.weekOfYear = weekOfYear;
		this.theWeek = theWeek;
	}

	public int getEmpCode() {
		return empCode;
	}

	public void setEmpCode(int empCode) {
		this.empCode = empCode;
	}

	public String getTodayDate() {
		return todayDate;
	}

	public void setTodayDate(String todayDate) {
		this.todayDate = todayDate;
	}

	public int getTodayOverTime() {
		return todayOverTime;
	}

	public void setTodayOverTime(int todayOverTime) {
		this.todayOverTime = todayOverTime;
	}

	public int getWeekOfYear() {
		return weekOfYear;
	}

	public void setWeekOfYear(int weekOfYear) {
		this.weekOfYear = weekOfYear;
	}

	public int getTheWeek() {
		return theWeek;
	}

	public void setTheWeek(int theWeek) {
		this.theWeek = theWeek;
	}

	@Override
	public String toString() {
		return "WeekT3 [empCode=" + empCode + ", todayDate=" + todayDate + ", todayOverTime=" + todayOverTime + ", weekOfYear="
				+ weekOfYear + ", theWeek=" + theWeek + "]";
	}
	
	

	
	
	
}
