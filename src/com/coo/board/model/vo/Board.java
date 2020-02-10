package com.coo.board.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Board implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -4278401241120816458L;
	public Board() {}
	
	private int bno;
	private int btype;
	private String btitle;
	private String bcontent;
	private String bwriter;
	private String bwriterId;
	private int bcount;
	private String boardfile;
	private Date bdate;
	private String status;
	private String category;
	
	
	public Board(int btype, String btitle, String bcontent, String bwriter, String boardfile,String category) {
		super();
		this.btype = btype;
		this.btitle = btitle;
		this.bcontent = bcontent;
		this.bwriter = bwriter;
		this.boardfile = boardfile;
		this.category = category;
	}
	
	public Board(int bno, int btype, String btitle, String bcontent, String bwriter, String bwriterId, int bcount,
			String boardfile, Date bdate, String status, String category) {
		super();
		this.bno = bno;
		this.btype = btype;
		this.btitle = btitle;
		this.bcontent = bcontent;
		this.bwriter = bwriter;
		this.bwriterId = bwriterId;
		this.bcount = bcount;
		this.boardfile = boardfile;
		this.bdate = bdate;
		this.status = status;
		this.category = category;
	}



	@Override
	public String toString() {
		return "Board [bno=" + bno + ", btype=" + btype + ", btitle=" + btitle + ", bcontent=" + bcontent + ", bwriter="
				+ bwriter + ", bwriterId=" + bwriterId + ", bcount=" + bcount + ", boardfile=" + boardfile + ", bdate="
				+ bdate + ", status=" + status + ", category=" + category + "]";
	}



	public String getCategory() {
		return category;
	}
	public void setCategory(String string) {
		this.category = string;
	}
	
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public int getBtype() {
		return btype;
	}
	public void setBtype(int btype) {
		this.btype = btype;
	}
	public String getBtitle() {
		return btitle;
	}
	public void setBtitle(String btitle) {
		this.btitle = btitle;
	}
	public String getBcontent() {
		return bcontent;
	}
	public void setBcontent(String bcontent) {
		this.bcontent = bcontent;
	}
	public String getBwriter() {
		return bwriter;
	}
	public void setBwriter(String bwriter) {
		this.bwriter = bwriter;
	}
	public String getBwriterId() {
		return bwriterId;
	}
	public void setBwriterId(String bwriterId) {
		this.bwriterId = bwriterId;
	}
	public int getBcount() {
		return bcount;
	}
	public void setBcount(int bcount) {
		this.bcount = bcount;
	}
	public String getBoardfile() {
		return boardfile;
	}
	public void setBoardfile(String boardfile) {
		this.boardfile = boardfile;
	}
	public Date getBdate() {
		return bdate;
	}
	public void setBdate(Date bdate) {
		this.bdate = bdate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
}
