package com.coo.ta.model.vo;

import java.util.ArrayList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class HolidayAPI {

	public HolidayAPI() {}
	
	public String getTagValue(String tag, Element eElement) {
	    NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
	    Node nValue = (Node) nlList.item(0);
	    if(nValue == null) 
	        return null;
	    return nValue.getNodeValue();
	}
	
	public ArrayList<String> getHoliday(int solYear, String solMonth) {
		ArrayList<String> hList = new ArrayList<>();
		
		try {
	    	String url = "http://apis.data.go.kr/B090041/openapi/service/"
	    			+ "SpcdeInfoService/getRestDeInfo?solYear=" + solYear + "&solMonth=" + solMonth + "&"
	    			+ "ServiceKey=wTUbZ%2Bll40LQa2JNU1Uz5d8JqVglBgTlAYb%2B%2F%2Fy3Wrpijvix7xMX2wQ0WdSpFi%2FSRo%2FOVJKlUFW5IOvShUNIcg%3D%3D";
	    	DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
	    	DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
	    	Document doc = dBuilder.parse(url);
	    	
	    	doc.getDocumentElement().normalize();
	    	
	    	NodeList nList = doc.getElementsByTagName("item");
	    	
	    	HolidayAPI ha = new HolidayAPI();
	    	
	    	for(int temp=0; temp<nList.getLength(); temp++) {
	    		Node nNode = nList.item(temp);
	    		
	    		if(nNode.getNodeType() == Node.ELEMENT_NODE ) {
	    			
	    			Element eElement = (Element) nNode;
	    			hList.add(ha.getTagValue("locdate",eElement));
	    		}
	    	}
    	}catch(Exception e) {
    		e.printStackTrace();
    	}
		
		return hList;
	}
	
}
