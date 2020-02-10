package com.coo.check.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Vacation extends RoundDoc implements Serializable{
	private Date start;
	private Date end;
	private String type;
	public Vacation() {
		super();
		
	}
	public Vacation(int docNumber, String text, Date start, Date end, String type) {
		super(docNumber, text);
		this.start = start;
		this.end = end;
		this.type = type;
		
	}
	public Date getStart() {
		return start;
	}
	public void setStart(Date start) {
		this.start = start;
	}
	public Date getEnd() {
		return end;
	}
	public void setEnd(Date end) {
		this.end = end;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	@Override
	public String toString() {
		return super.toString() + start + ", end=" + end + ", type=" + type + "]";
	}
	
	
	

	
}
