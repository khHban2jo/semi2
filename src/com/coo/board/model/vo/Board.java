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
	public Board(int bno, int btype, String btitle, String bcontent, String bwriter, String bwriterId, int bcount,
			String boardfile, Date bdate, String status) {
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
	}
	@Override
	public String toString() {
		return "Board [bno=" + bno + ", btype=" + btype + ", btitle=" + btitle + ", bcontent=" + bcontent + ", bwriter="
				+ bwriter + ", bwriterId=" + bwriterId + ", bcount=" + bcount + ", boardfile=" + boardfile + ", bdate="
				+ bdate + ", status=" + status + "]";
	}
	public Board(int btype, String btitle, String bcontent, String bwriter, String boardfile) {
		super();
		this.btype = btype;
		this.btitle = btitle;
		this.bcontent = bcontent;
		this.bwriter = bwriter;
		this.boardfile = boardfile;
	}
	
	
}
