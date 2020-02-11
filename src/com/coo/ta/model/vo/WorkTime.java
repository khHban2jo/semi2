package com.coo.ta.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class WorkTime implements Serializable{
	
	/*
	 * WORKTIME 테이블 객체
	 */
	private static final long serialVersionUID = 7256602985369005173L;
	
	private int empCode;		//	사번
	private Date wtDate;		//	날짜
	private String type;		//	WT_TYPE ( 근무 종류 )
	private int wtTime;			//	시간
	
	public WorkTime() {}

	//	출력용
	public WorkTime(int empCode, Date wtDate, String type, int wtTime) {
		super();
		this.empCode = empCode;
		this.wtDate = wtDate;
		this.type = type;
		this.wtTime = wtTime;
	}

	//	등록용
	public WorkTime(int empCode, String type, int wtTime) {
		super();
		this.empCode = empCode;
		this.type = type;
		this.wtTime = wtTime;
	}

	public int getEmpCode() {
		return empCode;
	}



	public void setEmpCode(int empCode) {
		this.empCode = empCode;
	}

	public Date getWtDate() {
		return wtDate;
	}

	public void setWtDate(Date wtDate) {
		this.wtDate = wtDate;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getWtTime() {
		return wtTime;
	}

	public void setWtTime(int wtTime) {
		this.wtTime = wtTime;
	}

	@Override
	public String toString() {
		return "WorkTime [empCode=" + empCode + ", wtDate=" + wtDate + ", type=" + type + ", wtTime=" + wtTime + "]";
	}
	
	

}
