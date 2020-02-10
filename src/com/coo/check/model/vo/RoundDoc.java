package com.coo.check.model.vo;

import java.io.Serializable;

public class RoundDoc implements Serializable{
	
	private int docNumber;
	private String text;
	
	public RoundDoc() {
		super();
		// TODO Auto-generated constructor stub
	}
	public RoundDoc(int docNumber, String text) {
		super();
		this.docNumber = docNumber;
		this.text = text;
	}
	
	public int getDocNumber() {
		return docNumber;
	}
	public void setDocNumber(int docNumber) {
		this.docNumber = docNumber;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	@Override
	public String toString() {
		return "RoundDoc [docNumber=" + docNumber + ", text=" + text + "]";
	}
	
	
}
