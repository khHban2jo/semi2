package com.coo.ta.model.dao;

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
import com.coo.ta.model.vo.TaData;

import static com.coo.common.JDBCTemplate.*;

public class TaDataDao {

private Properties prop;
	
	/**
	 * Properties 생성
	 */
	public TaDataDao() {
		prop = new Properties();
		String filePath = TaDataDao.class.getResource("/config/taData-query.properties").getPath();
		
		try {
			prop.load(new FileReader(filePath));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	public TaData selectOne(Connection con, int empCode) throws CooException {

		TaData td = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectOne");
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, empCode);
			
			rset = pstmt.executeQuery();
			if(rset.next()) {
				td = new TaData(rset.getInt("EMP_CODE"), rset.getInt("LATE_COUNT"), rset.getInt("ABSENT_COUNT"), rset.getInt("WORKDAY_COUNT"));
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
			throw new CooException(e.getMessage());
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return td;
	}

	public int workDayCountUpdate(Connection con, int empCode) throws CooException {

		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("workDayCount");
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, empCode);
			
			result = pstmt.executeUpdate();
		}catch(SQLException e) {
			throw new CooException(e.getMessage());
		}finally {
			close(pstmt);
		}
		
		return result;
	}

	public int lateCountUpdate(Connection con, int empCode) throws CooException {

		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("lateCount");
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, empCode);
			
			result = pstmt.executeUpdate();
		}catch(SQLException e) {
			throw new CooException(e.getMessage());
		}finally {
			close(pstmt);
		}
		
		return result;
		
	}

}



















