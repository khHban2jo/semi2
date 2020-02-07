package com.coo.board.model.vo;

import java.io.Serializable;

public class PageInfo implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 8843085771354713376L;
	private int currentPage;
	private int startPage;
	private int endPage;
	private int listCount;
	private int limit;
	private int maxPage;
	

	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getListCount() {
		return listCount;
	}
	public void setListCount(int listCount) {
		this.listCount = listCount;
	}
	public int getLimit() {
		return limit;
	}
	public void setLimit(int limit) {
		this.limit = limit;
	}
	public int getMaxPage() {
		return maxPage;
	}
	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}
	public PageInfo(int currentPage, int startPage, int endPage, int listCount, int limit, int maxPage) {
		super();
		this.currentPage = currentPage;
		this.startPage = startPage;
		this.endPage = endPage;
		this.listCount = listCount;
		this.limit = limit;
		this.maxPage = maxPage;
	}
	@Override
	public String toString() {
		return "PageInfo [currentPage=" + currentPage + ", startPage=" + startPage + ", endPage=" + endPage
				+ ", listCount=" + listCount + ", limit=" + limit + ", maxPage=" + maxPage + "]";
	}
	
	
}
