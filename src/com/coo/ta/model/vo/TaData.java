package com.coo.ta.model.vo;

import java.io.Serializable;

public class TaData implements Serializable{

	/**
	 * TA_DATA 테이블 객체
	 */
	private static final long serialVersionUID = 8589054891729859598L;
	
	private int empCode;		//	회원 코드
	private int lateCount;		//	지각 횟수
	private int absentCount;	//	결근 횟수
	private int workdayCount;	//	근무일수
	
	public TaData() {
		
	}
	
	public TaData(int empCode, int lateCount, int absentCount,int workdayCount) {
		super();
		this.empCode = empCode;
		this.lateCount = lateCount;
		this.absentCount = absentCount;
		this.workdayCount = workdayCount;
	}

	public int getEmpCode() {
		return empCode;
	}

	public void setEmpCode(int empCode) {
		this.empCode = empCode;
	}

	public int getLateCount() {
		return lateCount;
	}

	public void setLateCount(int lateCount) {
		this.lateCount = lateCount;
	}
	
	public int getAbsentCount() {
		return absentCount;
	}
	
	public void setAbsentCount(int absentCount) {
		this.absentCount = absentCount;
	}

	public int getWorkdayCount() {
		return workdayCount;
	}

	public void setWorkdayCount(int workdayCount) {
		this.workdayCount = workdayCount;
	}

	@Override
	public String toString() {
		return "TaData [empCode=" + empCode + ", lateCount=" + lateCount + ", absentCount=" + absentCount +", workdayCount=" + workdayCount + "]";
	}
	
	
}
