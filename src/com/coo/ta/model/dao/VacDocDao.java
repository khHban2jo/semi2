package com.coo.ta.model.dao;

import static com.coo.common.JDBCTemplate.*;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.coo.check.model.vo.CheckDoc;
import com.coo.check.model.vo.Vacation;
import com.coo.exception.CooException;

public class VacDocDao {

private Properties prop;
	
	/**
	 * Properties 생성
	 */
	public VacDocDao() {
		prop = new Properties();
		String filePath = VacDocDao.class.getResource("/config/taDoc-query.properties").getPath();
		
		try {
			prop.load(new FileReader(filePath));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public ArrayList<CheckDoc> selectApprval(Connection con, int empCode, String ym) throws CooException {

		ArrayList<CheckDoc> cdList = new ArrayList<CheckDoc>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectAppr");
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, empCode);
			pstmt.setString(2, ym);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				CheckDoc cd = new CheckDoc();
				cd.setDocNumber(rset.getInt("DOC_NUMBER"));
				
				cdList.add(cd);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
			throw new CooException(e.getMessage());
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return cdList;
	}

	public ArrayList<Vacation> selectVac(Connection con, ArrayList<CheckDoc> cdList) throws CooException {

		ArrayList<Vacation> vList = new ArrayList<Vacation>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectVacMy");
		
		try {
			pstmt = con.prepareStatement(sql);
			for(CheckDoc cd : cdList) {
				pstmt.setInt(1, cd.getDocNumber());
				rset = pstmt.executeQuery();
				
				if(rset.next()) {
					Vacation v = new Vacation();
					v.setDocNumber(rset.getInt("DOC_NUMBER"));
					v.setLeave_code(rset.getString("LEAVE_CODE"));
					v.setStart_Date(rset.getDate("START_DATE"));
					v.setEnd_Date(rset.getDate("END_DATE"));
					v.setDayOff_MA(rset.getString("DAYOFF_MA"));
					
					vList.add(v);
				}
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
			throw new CooException(e.getMessage());
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return vList;
	}

	public ArrayList<CheckDoc> selectApprovalList(Connection con, int empCode) throws CooException {

		ArrayList<CheckDoc> cdList = new ArrayList<CheckDoc>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectApprList");
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, empCode);
			
			rset = pstmt.executeQuery();
			while(rset.next()) {
				CheckDoc cd = new CheckDoc();
				cd.setaTitle(rset.getString("ATITLE"));
				cd.setDocNumber(rset.getInt("DOC_NUMBER"));
				cd.setaStatus(rset.getInt("ASTATUS"));
				
				cdList.add(cd);
			}
			
		}catch(SQLException e) {
			throw new CooException(e.getMessage());
		}finally {
			close(rset);
			close(pstmt);
		}
		return cdList;
	}
	
}


















