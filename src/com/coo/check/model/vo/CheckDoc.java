package com.coo.check.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class CheckDoc implements Serializable{
	private int docNumber; 	//문서번호
	private String aTitle;	//제목
	private int aWriter;	//작성자 no
	private String awriterName; //작성자 이름
	private String docType; //문서 종류
	private int aStatus;	//진행상황  0: 진행중, 1:내부완료 2:합의완료 3:결재완료 4:반려  -> 누군가 4를 누르면 결재진행 종료및 코멘트 넣기
	private String approver; //현재 결재 진행자(반려시 작성자)
	private	String deptCode; //결재 부서
	private String inPeople; //내부 결재 인원 (?,?,?,?) empno로 정과 부 들어와서  split 할것
	private String inStatus; //내부결재 상황 (위의 길이의 /2 만큼)'0' 들여놓을 것 -> join(', ')
	private String colDept; //똑같이 하는데 null가능
	private String colPeople;
	private String colStatus;
	private String endPerson; //최종결재자가 존재할시 결재후 3 or 4
	private String viewPeople; //참조자
	private Date docDate; //문서 작성 날짜
	private String returnComment; //반려시 코멘트
	private String deleteyn; //문서 삭제시 y  기본값 n


	public CheckDoc() {
		
	}

	public CheckDoc( String aTitle, int aWriter, String docType, String approver,
			String deptCode, String inPeople, String inStatus, String colDept, String colPeople, String colStatus,
			String endPerson, String viewPeople) {
		
		this.aTitle = aTitle;
		this.aWriter = aWriter;
		this.docType = docType;
		this.approver = approver;
		this.deptCode = deptCode;
		this.inPeople = inPeople;
		this.inStatus = inStatus;
		this.colDept = colDept;
		this.colPeople = colPeople;
		this.colStatus = colStatus;
		this.endPerson = endPerson;
		this.viewPeople = viewPeople;
	}

	public CheckDoc(int docNumber, String aTitle, int aWriter, String awriterName, String docType, int aStatus,
			String approver, String deptCode, String inPeople, String inStatus, String colDept, String colPeople,
			String colStatus, String endPerson, String viewPeople, Date docDate, String returnComment, String deleteyn
) {
		super();
		this.docNumber = docNumber;
		this.aTitle = aTitle;
		this.aWriter = aWriter;
		this.awriterName = awriterName;
		this.docType = docType;
		this.aStatus = aStatus;
		this.approver = approver;
		this.deptCode = deptCode;
		this.inPeople = inPeople;
		this.inStatus = inStatus;
		this.colDept = colDept;
		this.colPeople = colPeople;
		this.colStatus = colStatus;
		this.endPerson = endPerson;
		this.viewPeople = viewPeople;
		this.docDate = docDate;
		this.returnComment = returnComment;
		this.deleteyn = deleteyn;
	}

	public int getDocNumber() {
		return docNumber;
	}

	public void setDocNumber(int docNumber) {
		this.docNumber = docNumber;
	}

	public String getaTitle() {
		return aTitle;
	}

	public void setaTitle(String aTitle) {
		this.aTitle = aTitle;
	}

	public int getaWriter() {
		return aWriter;
	}

	public void setaWriter(int aWriter) {
		this.aWriter = aWriter;
	}

	public String getAwriterName() {
		return awriterName;
	}

	public void setAwriterName(String awriterName) {
		this.awriterName = awriterName;
	}

	public String getDocType() {
		return docType;
	}

	public void setDocType(String docType) {
		this.docType = docType;
	}

	public int getaStatus() {
		return aStatus;
	}

	public void setaStatus(int aStatus) {
		this.aStatus = aStatus;
	}

	public String getApprover() {
		return approver;
	}

	public void setApprover(String approver) {
		this.approver = approver;
	}

	public String getDeptCode() {
		return deptCode;
	}

	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}

	public String getInPeople() {
		return inPeople;
	}

	public void setInPeople(String inPeople) {
		this.inPeople = inPeople;
	}

	public String getInStatus() {
		return inStatus;
	}

	public void setInStatus(String inStatus) {
		this.inStatus = inStatus;
	}

	public String getColDept() {
		return colDept;
	}

	public void setColDept(String colDept) {
		this.colDept = colDept;
	}

	public String getColPeople() {
		return colPeople;
	}

	public void setColPeople(String colPeople) {
		this.colPeople = colPeople;
	}

	public String getColStatus() {
		return colStatus;
	}

	public void setColStatus(String colStatus) {
		this.colStatus = colStatus;
	}

	public String getEndPerson() {
		return endPerson;
	}

	public void setEndPerson(String endPerson) {
		this.endPerson = endPerson;
	}

	public String getViewPeople() {
		return viewPeople;
	}

	public void setViewPeople(String viewPeople) {
		this.viewPeople = viewPeople;
	}

	public Date getDocDate() {
		return docDate;
	}

	public void setDocDate(Date docDate) {
		this.docDate = docDate;
	}

	public String getReturnComment() {
		return returnComment;
	}

	public void setReturnComment(String returnComment) {
		this.returnComment = returnComment;
	}

	public String getDeleteyn() {
		return deleteyn;
	}

	public void setDeleteyn(String deleteyn) {
		this.deleteyn = deleteyn;
	}



	@Override
	public String toString() {
		return "CheckDoc [docNumber=" + docNumber + ", aTitle=" + aTitle + ", aWriter=" + aWriter + ", awriterName="
				+ awriterName + ", docType=" + docType + ", aStatus=" + aStatus + ", approver=" + approver
				+ ", deptCode=" + deptCode + ", inPeople=" + inPeople + ", inStatus=" + inStatus + ", colDept="
				+ colDept + ", colPeople=" + colPeople + ", colStatus=" + colStatus + ", endPerson=" + endPerson
				+ ", viewPeople=" + viewPeople + ", docDate=" + docDate + ", returnComment=" + returnComment
				+ ", deleteyn=" + deleteyn ;
	}



	
	
	
	

}