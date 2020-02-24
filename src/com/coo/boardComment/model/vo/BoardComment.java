package com.coo.boardComment.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class BoardComment implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4685307463082793298L;

	public BoardComment() {}
	
	private int cno;
	private int bno;
	private String ccontent;
	private String cwriter;
	private String cwriterId;
	private Date cdate;
	private int refcno;
	private int clevel;
	
	
	
	public BoardComment(int bno, String ccontent, String cwriter, int refcno, int clevel) {
		super();
		this.bno = bno;
		this.ccontent = ccontent;
		this.cwriter = cwriter;
		this.refcno = refcno;
		this.clevel = clevel;
	}

	public BoardComment(int cno, int bno, String ccontent, String cwriter, String cwriterId, Date cdate, int refcno,
			int clevel) {
		super();
		this.cno = cno;
		this.bno = bno;
		this.ccontent = ccontent;
		this.cwriter = cwriter;
		this.cwriterId = cwriterId;
		this.cdate = cdate;
		this.refcno = refcno;
		this.clevel = clevel;
	}



	public int getCno() {
		return cno;
	}



	public void setCno(int cno) {
		this.cno = cno;
	}



	public int getBno() {
		return bno;
	}



	public void setBno(int bno) {
		this.bno = bno;
	}



	public String getCcontent() {
		return ccontent;
	}



	public void setCcontent(String ccontent) {
		this.ccontent = ccontent;
	}



	public String getCwriter() {
		return cwriter;
	}



	public void setCwriter(String cwriter) {
		this.cwriter = cwriter;
	}



	public String getCwriterId() {
		return cwriterId;
	}



	public void setCwriterId(String cwriterId) {
		this.cwriterId = cwriterId;
	}



	public Date getCdate() {
		return cdate;
	}



	public void setCdate(Date cdate) {
		this.cdate = cdate;
	}



	public int getRefcno() {
		return refcno;
	}



	public void setRefcno(int refcno) {
		this.refcno = refcno;
	}



	public int getClevel() {
		return clevel;
	}



	public void setClevel(int clevel) {
		this.clevel = clevel;
	}



	@Override
	public String toString() {
		return "BoardComment [cno=" + cno + ", bno=" + bno + ", ccontent=" + ccontent + ", cwriter=" + cwriter
				+ ", cwriterId=" + cwriterId + ", cdate=" + cdate + ", refcno=" + refcno + ", clevel=" + clevel + "]";
	}
	
	
}
