package com.coo.ccalendar.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class CCalendar implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8134623689288434190L;
	private int empCode;
	private String title;
	private String toDo;
	private Date startDate;
	private Date endDate;
	private String cno;
	
	
	public CCalendar() {

	}


	/** 근무 일정 등록용
	 * @param empCode
	 * @param title
	 * @param toDo
	 * @param startDate
	 * @param endDate
	 */
	public CCalendar(int empCode, String title, String toDo, Date startDate, Date endDate) {
		super();
		this.title = title;
		this.empCode = empCode;
		this.toDo = toDo;
		this.startDate = startDate;
		this.endDate = endDate;
		
	}
	
	

	
	
	public CCalendar(int empCode, String title, String toDo, Date startDate, Date endDate, String cno) {
		super();
		this.empCode = empCode;
		this.title = title;
		this.toDo = toDo;
		this.startDate = startDate;
		this.endDate = endDate;
		this.cno = cno;
	}

	// Getter & Setter
	public int getEmpCode() {
		return empCode;
	}


	public void setEmpCode(int empCode) {
		this.empCode = empCode;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getToDo() {
		return toDo;
	}


	public void setToDo(String toDo) {
		this.toDo = toDo;
	}


	public Date getStartDate() {
		return startDate;
	}


	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}


	public Date getEndDate() {
		return endDate;
	}


	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}


	public String getCno() {
		return cno;
	}


	public void setCno(String cno) {
		this.cno = cno;
	}


	@Override
	public String toString() {
		return "CCalendar [empCode=" + empCode + ", title=" + title + ", toDo=" + toDo + ", startDate=" + startDate
				+ ", endDate=" + endDate + ", cno=" + cno + "]";
	}


	
	

	
	
	
	
}
