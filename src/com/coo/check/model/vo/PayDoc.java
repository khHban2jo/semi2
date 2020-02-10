package com.coo.check.model.vo;

import java.io.Serializable;

public class PayDoc extends RoundDoc implements Serializable{
	
	private int endPay;
	public PayDoc() {
		super();
	}

	public PayDoc(int docNumber, String text, int endPay) {
		super(docNumber, text);
		this.endPay = endPay;
		
	}

	public int getEndPay() {
		return endPay;
	}
	public void setEndPay(int endPay) {
		this.endPay = endPay;
	}

	@Override
	public String toString() {
		return super.toString()+ endPay;
	}
	
	
}
