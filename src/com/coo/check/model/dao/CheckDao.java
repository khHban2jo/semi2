package com.coo.check.model.dao;

import static com.coo.common.JDBCTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.coo.check.model.vo.CheckDoc;

public class CheckDao {
	
	private Properties prop;
	public CheckDao() {
		prop = new Properties();
		String sqlPath = CheckDao.class.getResource("config/check-query.properties").getPath();
		
		try {
			prop.load(new FileReader(sqlPath));
		}catch(IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 테이블의 삭제되지 않은 것 총 수 가져오기
	 * @param con
	 * @return
	 */
	public int getListCount(Connection con, int id) {
		int result =0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("checkCount");
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			pstmt.setInt(2, id);
			pstmt.setInt(3, id);
			pstmt.setInt(4, id);
			
			
			rset= pstmt.executeQuery();
			
			if(rset.next()) {
				result = rset.getInt(1);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rset);
		}
		
		
		return result;
	}

	/**
	 * 페이징시 가져올 테이블
	 * @param con
	 * @param currentPage
	 * @param limitPage
	 * @param id
	 * @return
	 */
	public ArrayList<CheckDoc> getList(Connection con, int currentPage, int limitPage, int id) {
		ArrayList<CheckDoc> docs= null;

		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectDocList");
		
		try {
			
			//페이징 눌렀을 때 시작 로우넘  계산 
			int startRow = (currentPage -1)*limitPage+1; //1,11,21
			
			//마지막 로우넘 번호 계산
			int endRow = startRow + limitPage -1; //10,20,30
			
			
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			pstmt.setInt(2, id);
			pstmt.setInt(3, id);
			pstmt.setInt(4, id);
			pstmt.setInt(5, endRow);
			pstmt.setInt(6, startRow);
			
			rset=pstmt.executeQuery();
			while(rset.next()) {
				CheckDoc cd = new CheckDoc();
				//가져온 값들 넣고
				
				docs.add(cd);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return docs;
	}

}