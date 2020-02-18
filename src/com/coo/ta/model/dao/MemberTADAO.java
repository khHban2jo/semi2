package com.coo.ta.model.dao;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import static com.coo.common.JDBCTemplate.*;

public class MemberTADAO {
	
	private Properties prop;
	/**
	 * Properties 생성
	 */
	public MemberTADAO() {
		prop = new Properties();
		String filePath = TaDataDao.class.getResource("/config/taMember-query.properties").getPath();
		
		try {
			prop.load(new FileReader(filePath));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	public int selectEmpCode(Connection con, String empId) {

		int empCode = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectEmpCode");
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, empId);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				empCode = rset.getInt("EMP_CODE");
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return empCode;
	}

	public int insertMemberTA(Connection con, int empCode) {

		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertTADATA");
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, empCode);
			
			result = pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}

		return result;
	}

	public int insertMemberLeave(Connection con, int empCode, int l1Value) {

		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertLeave");

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, empCode);
			
			for(int i = 1 ; i < 4 ; i++) {
				String lcode = "L" + i;
				pstmt.setString(2, lcode);

				if(lcode.equals("L1")) 
					pstmt.setInt(3, l1Value);
				else
					pstmt.setInt(3, 1);
				
				result = pstmt.executeUpdate();
				if(result<=0) 
					break;
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}


}
