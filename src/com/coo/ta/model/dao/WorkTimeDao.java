package com.coo.ta.model.dao;

import static com.coo.common.JDBCTemplate.close;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Properties;

import com.coo.exception.CooException;
import com.coo.member.model.dao.MemberDao;
import com.coo.ta.model.vo.WorkTime;

public class WorkTimeDao {
	
	private Properties prop;
	
	/**
	 * Properties 생성
	 */
	public WorkTimeDao() {
		prop = new Properties();
		String filePath = MemberDao.class.getResource("/config/workTime-query.properties").getPath();
		
		try {
			prop.load(new FileReader(filePath));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	/**
	 * T1(출근) T2(퇴근) 시간 SELECT
	 * @param con
	 * @param empCode
	 * @return
	 * @throws CooException
	 */
	public HashMap selectWorkTime(Connection con, int empCode) throws CooException {

		HashMap wtMap = new HashMap<>();
		
		PreparedStatement pstmt = null;
		
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectWt");
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, empCode);
			pstmt.setString(2, "T1");
			pstmt.setString(3, "T2");
			
			rset = pstmt.executeQuery();
			
			int count = 0;
			while( rset.next() ) {
				
				String time = "";
				
				if(rset.getString(1).length() == 3) {
					time = rset.getString(1);
					String[] timeStr = time.split("");
					time = "0" + timeStr[0] + ":" + timeStr[1] + timeStr[2];
				}else {
					time = rset.getString(1);
					String[] timeStr = time.split("");
					time = timeStr[0]+timeStr[1]+":"+timeStr[2]+timeStr[3];
				}
				
				wtMap.put(count, time);
				count++;
			}
			
		}catch(SQLException e) {
			throw new CooException(e.getMessage());
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return wtMap;
	}

	/**
	 * 출근 등록
	 * @param con
	 * @param wt
	 * @return
	 * @throws CooException
	 */
	public int wtT1Insert(Connection con, WorkTime wt) throws CooException {

		int result = 0;
		
		PreparedStatement pstmt = null;

		String sql = prop.getProperty("insertT1");
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, wt.getEmpCode());
			pstmt.setString(2, wt.getType());
			pstmt.setInt(3, wt.getWtTime());
			
			result = pstmt.executeUpdate();
			
		}catch(SQLException e) {
			throw new CooException(e.getMessage());
		}finally {
			close(pstmt);
		}
		
		return result;
	}

	/**
	 * 퇴근 등록 ISNERT
	 * @param con
	 * @param wt
	 * @return
	 * @throws CooException
	 */
	public int wtT2Insert(Connection con, WorkTime wt) throws CooException {

		int result = 0;
		
		PreparedStatement pstmt = null;

		String sql = prop.getProperty("insertT2");
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, wt.getEmpCode());
			pstmt.setString(2, wt.getType());
			pstmt.setInt(3, wt.getWtTime());
			
			result = pstmt.executeUpdate();
			
		}catch(SQLException e) {
			throw new CooException(e.getMessage());
		}finally {
			close(pstmt);
		}
		
		return result;
	}

	/**
	 * 퇴근 등록 여부 확인 SELECT
	 * @param con
	 * @param wt
	 * @return
	 * @throws CooException
	 */
	public WorkTime selectT2(Connection con, WorkTime wt) throws CooException {

		WorkTime wtCheck = null;
		
		PreparedStatement pstmt = null;
		
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectT2");
		
		try {
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, wt.getEmpCode());
			pstmt.setString(2, wt.getType());
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				wtCheck = new WorkTime();
				
				wtCheck.setEmpCode(rset.getInt("EMP_CODE"));
				wtCheck.setWtDate(rset.getDate("WT_DATE"));
				wtCheck.setType(rset.getString("TA_TYPE_CODE"));
				wtCheck.setWtTime(rset.getInt("WT_TIME"));
			}
			
		}catch(SQLException e) {
			throw new CooException(e.getMessage());
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return wtCheck;
	}

	/**
	 * 퇴근 재등록 UPDATE
	 * @param con
	 * @param wt
	 * @return
	 * @throws CooException
	 */
	public int wtT2Update(Connection con, WorkTime wt) throws CooException {

		int result = 0;
		
		PreparedStatement pstmt = null;

		String sql = prop.getProperty("updateT2");
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, wt.getWtTime());
			pstmt.setInt(2, wt.getEmpCode());
			pstmt.setString(3, wt.getType());
			
			result = pstmt.executeUpdate();
			
		}catch(SQLException e) {
			throw new CooException(e.getMessage());
		}finally {
			close(pstmt);
		}
		
		return result;
	
	}

}
























