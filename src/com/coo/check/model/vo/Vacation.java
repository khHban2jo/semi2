package com.coo.check.model.vo;

import java.io.Serializable;
import java.sql.Date;



public class Vacation extends RoundDoc implements Serializable{
	private String leave_code;
	private Date start_Date;
	private Date end_Date;
	private String dayOff_MA;
	
	public Vacation() {
		super();
		
	}

	public Vacation(String leave_code, Date start_Date, Date end_Date, String dayOff_MA) {
		super();
		this.leave_code = leave_code;
		this.start_Date = start_Date;
		this.end_Date = end_Date;
		this.dayOff_MA = dayOff_MA;
	}

	 
	public String getLeave_code() {
		return leave_code;
	}

	public void setLeave_code(String leave_code) {
		this.leave_code = leave_code;
	}

	public Date getStart_Date() {
		return start_Date;
	}

	public void setStart_Date(Date start_Date) {
		this.start_Date = start_Date;
	}

	public Date getEnd_Date() {
		return end_Date;
	}

	public void setEnd_Date(Date end_Date) {
		this.end_Date = end_Date;
	}

	public String getDayOff_MA() {
		return dayOff_MA;
	}

	public void setDayOff_MA(String dayOff_MA) {
		this.dayOff_MA = dayOff_MA;
	}

	@Override
	public String toString() {
		return super.toString() +"leave_code=" + leave_code + ", start_Date=" + start_Date + ", end_Date=" + end_Date
				
				+ ", dayOff_MA=" + dayOff_MA + "]";
	}
	
	
	/* DOC_NUMBER NUMBER NOT NULL UNIQUE,
	  TCONTENT VARCHAR2(2000),
	  LEAVE_CODE CHAR(2) NOT NULL, -- L1 : 연차 / L2 : 월차 / L3 : 반차
	  START_DATE DATE NOT NULL,
	  END_DATE DATE NOT NULL,
	  DAYOFF_MA CHAR(1) DEFAULT 'N' CHECK(DAYOFF_MA IN ('A','P','N')),  --  N : NULL / A : 오전 / P : 오후*/
	

	
}
