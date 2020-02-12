package com.coo.check.model.vo;

import java.io.Serializable;

public class PmapMember implements Serializable {
	
	private int empCode;
	private String empName;
	private String deptCode;
	private String deptName;
	private String job;
	public PmapMember() {
		super();
		// TODO Auto-generated constructor stub
	}
	public PmapMember(int empCode, String empName, String deptCode, String deptName, String job) {
		super();
		this.empCode = empCode;
		this.empName = empName;
		this.deptCode = deptCode;
		this.deptName = deptName;
		this.job = job;
	}
	public int getEmpCode() {
		return empCode;
	}
	public void setEmpCode(int empCode) {
		this.empCode = empCode;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
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
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	@Override
	public String toString() {
		return "PmapMember [empCode=" + empCode + ", empName=" + empName + ", deptCode=" + deptCode + ", deptName="
				+ deptName + ", job=" + job + "]";
	}
	
	

	
	
	

	

}
