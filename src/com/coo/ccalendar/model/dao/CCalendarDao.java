package com.coo.ccalendar.model.dao;

import static com.coo.common.JDBCTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.coo.ccalendar.model.vo.CCalendar;
import com.coo.exception.CooException;

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
	
	
	
	/**
	 * 일정 등록용 메소드
	 * @param c
	 * @param con
	 * @return
	 */
	public int insertCalendar(CCalendar c, Connection con) {

		int result = 0;
		PreparedStatement pstmt = null;

		
		String sql = prop.getProperty("insertCalendar");
		System.out.println("CCalendar"+c.toString());
		try {
			
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, c.getEmpCode());
			pstmt.setDate(2, c.getStartDate()); 
			pstmt.setString(3, c.getToDo());
			pstmt.setDate(4, c.getEndDate());
			pstmt.setString(5, c.getTitle());
			
			result=pstmt.executeUpdate();
			System.out.println(result);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		
		return result;
	}


	/**
	 * 일정 목록 불러오기
	 * @param con
	 * @param sqlDate
	 * @return
	 */
	/*public ArrayList<CCalendar> selectToday(Connection con, Date sqlDate) {*/
	public ArrayList<CCalendar> selectToday(Connection con, int empCode, Date sqlDate) throws CooException {	
		
		ArrayList<CCalendar> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectCalendar"); //쿼리이름
		
		try {
			list = new ArrayList<CCalendar>();
			/*System.out.println(sqlDate);*/			
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, empCode);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				
				CCalendar c = new CCalendar();
				c.setEmpCode(rset.getInt("EMP_CODE"));
				c.setStartDate(rset.getDate("CDATE"));
				c.setToDo(rset.getString("TO_DO"));
				c.setEndDate(rset.getDate("DDATE"));
				c.setTitle(rset.getString("CTITLE"));
				c.setCno(rset.getString("CNO"));
				list.add(c);
			}
			System.out.println(list);
		} catch (SQLException e) {
			throw new CooException(e.getMessage());
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}



	/** 일정 수정용 메소드
	 * @param con
	 * @param c
	 * @return
	 */
	public int updateCalendar(Connection con, CCalendar c) {

		int result = 0;
		PreparedStatement pstmt = null;
		//너의 이름은?
		String sql = prop.getProperty("updateCalendar");
		
		try {
			
			pstmt=con.prepareStatement(sql);
			
			pstmt.setString(1, c.getTitle());
			pstmt.setString(2, c.getToDo());
			pstmt.setDate(3, c.getEndDate());
			pstmt.setDate(4, c.getStartDate());
			pstmt.setString(5, c.getCno());
			
			result=pstmt.executeUpdate();
			
			
		} catch(SQLException e){
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		
		return result;
	}



	/** 일정 삭제용 메소드
	 * @param con
	 * @param title
	 * @return
	 */
	public int deleteCalendar(Connection con, String cno) {

		int result= 0;
		PreparedStatement pstmt = null;
		
		//너의 이름은!
		String sql = prop.getProperty("deleteCalendar");
		
		try {
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, cno);
			
			result=pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		
		
		return result;
	}



	/**
	 * 일정 상세보기 메소드
	 * @param con
	 * @param cno
	 * @return
	 */
	public CCalendar selectOne(Connection con, String cno) {

		CCalendar c =null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		//쿼리이름
		String sql = prop.getProperty("selectOne");
		
		try {
		
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, cno);
			rset=pstmt.executeQuery();
			
			if(rset.next()) {
			
			
			c= new CCalendar();
			
			c.setCno(rset.getString("CNO"));
			c.setEmpCode(rset.getInt("EMP_CODE"));
			c.setStartDate(rset.getDate("CDATE"));
			c.setToDo(rset.getString("TO_DO"));
			c.setEndDate(rset.getDate("DDATE"));
			c.setTitle(rset.getString("CTITLE"));
			
			}
		
			System.out.println("CCalendar확인 "+ c);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return c;
	}




}
