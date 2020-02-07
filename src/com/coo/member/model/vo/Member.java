package com.coo.member.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Member implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 9204553733900473355L;
	private String empId;
	private String empCode;
	private String empPwd;
	private String empName;
	private String personalId;
	private String email;
	private String gender;
	private int age;
	private int salary;
	private String phone;
	private String address;
	private String deptCode;
	private String jobCode;
	private String etc;
	private String managerYn;
	private Date hireDate;
	private String subDept;
	
	public Member() {}

	public String getEmpCode() {
		return empCode;
	}

	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getEmpPwd() {
		return empPwd;
	}

	public void setEmpPwd(String empPwd) {
		this.empPwd = empPwd;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getPersonalId() {
		return personalId;
	}

	public void setPersonalId(String personalId) {
		this.personalId = personalId;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public int getSalary() {
		return salary;
	}

	public void setSalary(int salary) {
		this.salary = salary;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDeptCode() {
		return deptCode;
	}

	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}

	public String getJobCode() {
		return jobCode;
	}

	public void setJobCode(String jobCode) {
		this.jobCode = jobCode;
	}

	public String getEtc() {
		return etc;
	}

	public void setEtc(String etc) {
		this.etc = etc;
	}

	public String getManagerYn() {
		return managerYn;
	}

	public void setManagerYn(String managerYn) {
		this.managerYn = managerYn;
	}

	public Date getHireDate() {
		return hireDate;
	}

	public void setHireDate(Date hireDate) {
		this.hireDate = hireDate;
	}

	public String getSubDept() {
		return subDept;
	}

	public void setSubDept(String subDept) {
		this.subDept = subDept;
	}

	public Member(String empId, String empCode, String empPwd, String empName, String personalId, String email,
			String gender, int age, int salary, String phone, String address, String deptCode, String jobCode,
			String etc, String managerYn, String subDept) {
		super();
		this.empId = empId;
		this.empCode = empCode;
		this.empPwd = empPwd;
		this.empName = empName;
		this.personalId = personalId;
		this.email = email;
		this.gender = gender;
		this.age = age;
		this.salary = salary;
		this.phone = phone;
		this.address = address;
		this.deptCode = deptCode;
		this.jobCode = jobCode;
		this.etc = etc;
		this.managerYn = managerYn;
		this.subDept = subDept;
	}

	public Member(String empId, String empCode, String empPwd, String empName, String personalId, String email,
			String gender, int age, int salary, String phone, String address, String deptCode, String jobCode,
			String etc, String managerYn, Date hireDate, String subDept) {
		super();
		this.empId = empId;
		this.empCode = empCode;
		this.empPwd = empPwd;
		this.empName = empName;
		this.personalId = personalId;
		this.email = email;
		this.gender = gender;
		this.age = age;
		this.salary = salary;
		this.phone = phone;
		this.address = address;
		this.deptCode = deptCode;
		this.jobCode = jobCode;
		this.etc = etc;
		this.managerYn = managerYn;
		this.hireDate = hireDate;
		this.subDept = subDept;
	}

	public Member(String empId, String empPwd) {
		super();
		this.empId = empId;
		this.empPwd = empPwd;
	}

	@Override
	public String toString() {
		return "Member [empCode=" + empCode + ", empId=" + empId + ", empPwd=" + empPwd + ", empName=" + empName
				+ ", personalId=" + personalId + ", email=" + email + ", gender=" + gender + ", age=" + age
				+ ", salary=" + salary + ", phone=" + phone + ", address=" + address + ", deptCode=" + deptCode
				+ ", jobCode=" + jobCode + ", etc=" + etc + ", managerYn=" + managerYn + ", hireDate=" + hireDate
				+ ", subDept=" + subDept + "]";
	}
}
