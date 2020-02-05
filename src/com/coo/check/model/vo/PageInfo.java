package com.coo.check.model.vo;

import java.io.Serializable;

public class PageInfo implements Serializable {
	
	

	private int checkListCount;
	
	//2. 페이징시 시작 
	private int startPaging;
	
	//3. 페이징 끝
	private int endPaging;
	
	//4. 마지막 페이징
	private int maxPaging;
	
	//5. 한줄에 들어갈 페이징수
	private int limitPaging;
	
	//6. 한번에 보일 페이지
	private int limitPage;
	
	//7. 현재  있는 페이징
	private int currentPage;

	public PageInfo() {
		
	}

	public PageInfo(int checkListCount, int startPaging, int endPaging, int maxPaging, int limitPaging, int limitPage,
			int currentPage) {
		this.checkListCount = checkListCount;
		this.startPaging = startPaging;
		this.endPaging = endPaging;
		this.maxPaging = maxPaging;
		this.limitPaging = limitPaging;
		this.limitPage = limitPage;
		this.currentPage = currentPage;
	}

	public int getCheckListCount() {
		return checkListCount;
	}

	public void setCheckListCount(int checkListCount) {
		this.checkListCount = checkListCount;
	}

	public int getStartPaging() {
		return startPaging;
	}

	public void setStartPaging(int startPaging) {
		this.startPaging = startPaging;
	}

	public int getEndPaging() {
		return endPaging;
	}

	public void setEndPaging(int endPaging) {
		this.endPaging = endPaging;
	}

	public int getMaxPaging() {
		return maxPaging;
	}

	public void setMaxPaging(int maxPaging) {
		this.maxPaging = maxPaging;
	}

	public int getLimitPaging() {
		return limitPaging;
	}

	public void setLimitPaging(int limitPaging) {
		this.limitPaging = limitPaging;
	}

	public int getLimitPage() {
		return limitPage;
	}

	public void setLimitPage(int limitPage) {
		this.limitPage = limitPage;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	
	
	
}
