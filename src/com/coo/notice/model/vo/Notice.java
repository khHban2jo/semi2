package com.coo.notice.model.vo;

import java.sql.Date;

public class Notice {
	private int nno;
	private int ntype;
	private String ntitle;
	private String ncontent;
	private String nwriter;
	private int ncount;
	private Date ndate; 		//게시판 종료 날짜
	private String ncategory;
	
	public Notice() {}

	public Notice(int nno, int ntype, String ntitle, String ncontent, String nwriter, int ncount, Date ndate,
			String ncategory) {
		super();
		this.nno = nno;
		this.ntype = ntype;
		this.ntitle = ntitle;
		this.ncontent = ncontent;
		this.nwriter = nwriter;
		this.ncount = ncount;
		this.ndate = ndate;
		this.ncategory = ncategory;
	}

	// 사용 
	public Notice(int nno, String ntitle, String nwriter, String ncontent, int ncount, Date ndate) {
		super();
		this.nno = nno;
		this.ntitle = ntitle;
		this.nwriter = nwriter;
		this.ncontent = ncontent;
		this.ncount = ncount;
		this.ndate = ndate;
	}
	
	public int getNno() {
		return nno;
	}

	public void setNno(int nno) {
		this.nno = nno;
	}

	public int getNtype() {
		return ntype;
	}

	public void setNtype(int ntype) {
		this.ntype = ntype;
	}

	public String getNtitle() {
		return ntitle;
	}

	public void setNtitle(String ntitle) {
		this.ntitle = ntitle;
	}

	public String getNcontent() {
		return ncontent;
	}

	public void setNcontent(String ncontent) {
		this.ncontent = ncontent;
	}

	public String getNwriter() {
		return nwriter;
	}

	public void setNwriter(String nwriter) {
		this.nwriter = nwriter;
	}

	public int getNcount() {
		return ncount;
	}

	public void setNcount(int ncount) {
		this.ncount = ncount;
	}

	public Date getNdate() {
		return ndate;
	}

	public void setNdate(Date ndate) {
		this.ndate = ndate;
	}

	public String getStatus() {
		return ncategory;
	}

	public void setStatus(String status) {
		this.ncategory = status;
	}

	@Override
	public String toString() {
		return "Notice [nno=" + nno + ", ntype=" + ntype + ", ntitle=" + ntitle + ", ncontent=" + ncontent
				+ ", nwriter=" + nwriter + ", ncount=" + ncount + ", ndate=" + ndate + ", ncategory=" + ncategory + "]";
	}
	
	
	
	
}
