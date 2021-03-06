package com.coo.ta.model.dao;

import static com.coo.common.JDBCTemplate.*;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import com.coo.exception.CooException;
import com.coo.member.model.dao.MemberDao;
import com.coo.ta.model.vo.WeekOverTime;

public class WeekOverTimeDao {
	
	private Properties prop;
	
	/**
	 * Properties 생성
	 */
	public WeekOverTimeDao() {
		prop = new Properties();
		String filePath = WeekOverTimeDao.class.getResource("/config/weekOverTime-query.properties").getPath();
		
		try {
			prop.load(new FileReader(filePath));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 오늘 날짜로 등록된 wot가 있는지 select
	 * @param con
	 * @param wot
	 * @return
	 * @throws CooException
	 */
	public WeekOverTime selectWot(Connection con, WeekOverTime wot) throws CooException {

		WeekOverTime wotCheck = null;
		
		PreparedStatement pstmt = null;
		
		ResultSet rset = null;

		String sql = prop.getProperty("selectWotCheck");
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, wot.getEmpCode());
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				wotCheck = new WeekOverTime();
				
				wotCheck.setEmpCode(rset.getInt("EMP_CODE"));
				wotCheck.setTodayDate(rset.getString("TODAY_DATE"));
				wotCheck.setTodayOverTime(rset.getInt("TODAY_OVERTIME"));
				wotCheck.setWeekOfYear(rset.getInt("WEEK_OF_YEAR"));
				wotCheck.setTheWeek(rset.getInt("THE_WEEK"));
			}
			
		}catch(SQLException e) {
			throw new CooException(e.getMessage());
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return wotCheck;
	}

	/**
	 * WeekOverTime INSERT
	 * @param con
	 * @param wot
	 * @return
	 * @throws CooException
	 */
	public int insertWot(Connection con, WeekOverTime wot) throws CooException {

		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("insertWotOne");
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, wot.getEmpCode());
			pstmt.setInt(2, wot.getTodayOverTime());
			pstmt.setInt(3, wot.getWeekOfYear());
			pstmt.setInt(4, wot.getTodayOverTime());
			pstmt.setInt(5, wot.getEmpCode());
			pstmt.setInt(6, wot.getWeekOfYear());
			
			result = pstmt.executeUpdate();
		}catch(SQLException e) {
			throw new CooException(e.getMessage());
		}finally {
			close(pstmt);
		}
		
		return result;
	}

	/**
	 * WeekOverTime UPDATE
	 * @param con
	 * @param wot
	 * @return
	 * @throws CooException
	 */
	public int updateWot(Connection con, WeekOverTime wot) throws CooException {

		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("updateWotOne");
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, wot.getTodayOverTime());
			pstmt.setInt(2, wot.getTodayOverTime());
			pstmt.setInt(3, wot.getEmpCode());
			pstmt.setInt(4, wot.getWeekOfYear());
			pstmt.setInt(5, wot.getEmpCode());
			
			result = pstmt.executeUpdate();
			
		}catch(SQLException e) {
			e.printStackTrace();
			throw new CooException(e.getMessage());
		}finally {
			close(pstmt);
		}
		
		return result;
	
	}

	public int selectOverTime(Connection con, int empCode, int week) throws CooException {

		int allOverTime = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectOne");
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, empCode);
			pstmt.setInt(2, week);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				allOverTime = rset.getInt(1);
			}
			
		}catch(SQLException e) {
			throw new CooException(e.getMessage());
		}finally {
			close(rset);
			close(pstmt);
		}
		return allOverTime;
	}

	
	

}


















