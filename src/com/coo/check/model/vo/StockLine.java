package com.coo.check.model.vo;

import java.io.Serializable;

public class StockLine implements Serializable{
	private int empcode; //정
	private String empName;
	private String deptCode; //해당부서코드
	private String deptName;
	private int subcode; //부
	private String list1;
	private String list2;
	private String list3;
	public StockLine() {
		super();
		// TODO Auto-generated constructor stub
	}
	public StockLine(int empcode, String deptCode, String deptName, int subcode, String list1, String list2,
			String list3) {
		super();
		this.empcode = empcode;
		this.deptCode = deptCode;
		this.deptName = deptName;
		this.subcode = subcode;
		this.list1 = list1;
		this.list2 = list2;
		this.list3 = list3;
	}
	public int getEmpcode() {
		return empcode;
	}
	public void setEmpcode(int empcode) {
		this.empcode = empcode;
	}
	public String getDeptCode() {
		return deptCode;
	}
	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public int getSubcode() {
		return subcode;
	}
	public void setSubcode(int subcode) {
		this.subcode = subcode;
	}
	public String getList1() {
		return list1;
	}
	public void setList1(String list1) {
		this.list1 = list1;
	}
	public String getList2() {
		return list2;
	}
	public void setList2(String list2) {
		this.list2 = list2;
	}
	public String getList3() {
		return list3;
	}
	public void setList3(String list3) {
		this.list3 = list3;
	}
	
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	@Override
	public String toString() {
		return "StockLine [empcode=" + empcode + ", deptCode=" + deptCode + ", deptName=" + deptName + ", subcode="
				+ subcode + ", list1=" + list1 + ", list2=" + list2 + ", list3=" + list3 + "]";
	}
	
	
}
