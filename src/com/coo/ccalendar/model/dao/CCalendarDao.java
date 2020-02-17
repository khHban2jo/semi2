package com.coo.ccalendar.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

import com.coo.ccalendar.model.vo.CCalendar;

import static com.coo.common.JDBCTemplate.*;

public class CCalendarDao {
	
	private Properties prop;//

	// Properites 연결 CalendarDao() 기본생성자에 넣기
	
	public CCalendarDao() {
		
		prop = new Properties();
		
		String filePath = CCalendar.class.getResource("/config/ccalendar-query.properties").getPath();
		
		try {
			
			prop.load(new FileReader(filePath));
		} catch (IOException e) {
			e.printStackTrace();
		} 
	}
	
	
	
	public int insertCalendar(CCalendar c, Connection con) {

		int result = 0;
		PreparedStatement pstmt = null;

		
		String sql = prop.getProperty("insertCalendar");
		System.out.println(c.toString());
		try {
			
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, c.getEmpCode());
			pstmt.setDate(2, c.getStartDate()); 
			pstmt.setString(3, c.getToDo());
			pstmt.setDate(4, c.getEndDate());
			pstmt.setString(5, c.getTitle());
			
			result=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		
		return result;
	}



/*	*//**
	 * @param con
	 * @return
	 *//*
	public ArrayList<Calendar> selectList(Connection con) {
		ArrayList<Calendar> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectList");
		
		try {
			
			pstmt = con.prepareStatement(sql);
			rset = pstmt.executeQuery(sql);
			list = new ArrayList<Calendar>();
			
			
		} catch (Exception e) {

		} finally {
			
		}
		
		
		
		return null;
	}
*/


	/**
	 * 현재 날짜 선택 
	 * @param con
	 * @param sqlDate
	 * @return
	 */
	public ArrayList<CCalendar> selectToday(Connection con, Date sqlDate) {
		ArrayList<CCalendar> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectCalendar"); //쿼리이름
		
		try {
			list = new ArrayList<CCalendar>();
						
			
			pstmt = con.prepareStatement(sql);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				
				CCalendar c = new CCalendar();
				c.setEmpCode(rset.getInt("EMP_CODE"));
				c.setStartDate(rset.getDate("CDATE"));
				c.setToDo(rset.getString("TO_DO"));
				c.setEndDate(rset.getDate("DDATE"));
				c.setTitle(rset.getString("CTITLE"));
				list.add(c);
			}
			System.out.println(list);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

}
