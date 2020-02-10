package com.coo.pmap.model.vo;

import java.io.Serializable;

public class Pmap implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String emp_code;
	private String emp_name;
	private String email;
	private String job_code;
	private String dept_code;
	
	public Pmap() {
	
	}

	public Pmap(String emp_code, String emp_name, String email, String job_code, String dept_code) {
		super();
		this.emp_code = emp_code;
		this.emp_name = emp_name;
		this.email = email;
		this.job_code = job_code;
		this.dept_code = dept_code;
	}

	public String getEmp_code() {
		return emp_code;
	}

	public void setEmp_code(String emp_code) {
		this.emp_code = emp_code;
	}

	public String getEmp_name() {
		return emp_name;
	}

	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getJob_code() {
		return job_code;
	}

	public void setJob_code(String job_code) {
		this.job_code = job_code;
	}

	public String getDept_code() {
		return dept_code;
	}

	public void setDept_code(String dept_code) {
		this.dept_code = dept_code;
	}

	@Override
	public String toString() {
		return "Pmap [emp_code=" + emp_code + ", emp_name=" + emp_name + ", email=" + email + ", job_code=" + job_code
				+ ", dept_code=" + dept_code + "]";
	}
	
	
	/*private String emp_code;
	private String emp_name;
	private String email;
	private String job;
	private String dept;
	
	public Pmap() {
		
	}
	
	public Pmap(String emp_code, String emp_name, String email, String job, String dept) {
		super();
		this.emp_code = emp_code;
		this.emp_name = emp_name;
		this.email = email;
		this.job = job;
		this.dept = dept;
	}
	
	public String getEmp_code() {
		return emp_code;
	}
	public void setEmp_code(String emp_code) {
		this.emp_code = emp_code;
	}
	public String getEmp_name() {
		return emp_name;
	}
	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	
	@Override
	public String toString() {
		return "Pmap [emp_code=" + emp_code + ", emp_name=" + emp_name + ", email=" + email + ", job=" + job + ", dept="
				+ dept + "]";
	}*/
	
	
}
