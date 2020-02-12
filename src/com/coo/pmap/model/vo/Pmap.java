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
	private String job_name;
	private String dept_title;
	
	public Pmap() {}
	
	public Pmap(String emp_code, String emp_name, String email, String job_name, String dept_title) {
		super();
		this.emp_code = emp_code;
		this.emp_name = emp_name;
		this.email = email;
		this.job_name = job_name;
		this.dept_title = dept_title;
	}

	@Override
	public String toString() {
		return "Pmap [emp_code=" + emp_code + ", emp_name=" + emp_name + ", email=" + email + ", job_name=" + job_name
				+ ", dept_title=" + dept_title + "]";
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
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}
	public String getDept_title() {
		return dept_title;
	}
	public void setDept_title(String dept_title) {
		this.dept_title = dept_title;
	}
	

	
}
