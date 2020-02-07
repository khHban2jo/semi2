package com.coo.notice.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;
import static com.coo.common.JDBCTemplate.*;

import com.coo.notice.model.vo.Notice;

public class noticeDao {
	
	private Properties prop;
	
	public noticeDao() {
		prop = new Properties();
		
		String filePath = noticeDao.class.getResource("/config/notice-query.properties").getPath();
		
		try {
			prop.load(new FileReader(filePath));
		}catch(IOException e) {
			e.printStackTrace();
		}
	}
	
	public int getListCount(Connection con) {
		// 총 게시글 수
		
	
		int listCount = 0;
		Statement stmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("listCount");
		System.out.println("1-3");
		try {
			stmt = con.createStatement();
			System.out.println("1-4");
			rset = stmt.executeQuery(sql);
			System.out.println("1-5");
			
			if(rset.next()) {
				listCount = rset.getInt(1);
			}

			System.out.println("총 db에 있는 행의 수 : "+listCount);
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(stmt);
		}
		
		
		return listCount;
	}

	public ArrayList<Notice> selectList(Connection con, int currentPage, int limit) {
		// 페이징 처리를 위한 곳
		ArrayList<Notice> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String sql = prop.getProperty("selectList");

		try {
			System.out.println("2-3");
			pstmt = con.prepareStatement(sql);
			
			int startRow = (currentPage-1)*limit+1;	// 1 11
			int endRow = startRow + limit - 1; 		// 5
			
			System.out.println("2-4");
			pstmt.setInt(1, endRow);
			pstmt.setInt(2, startRow);

			System.out.println("2-5");
			
			rset = pstmt.executeQuery();
			
			System.out.println("2-6");
			
			list = new ArrayList<Notice>();
			
			while(rset.next()) {
				Notice b = new Notice(
						rset.getInt("NNO"),
						rset.getString("NTITLE"),
						rset.getString("NWRITER"),
						rset.getString("NCONTENT"),
						rset.getInt("NCOUNT"),
						rset.getDate("NDATE")
						);
				list.add(b);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public int insertNotice(Connection con, Notice n) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("insertNotice");
		
		try {
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, n.getNtitle());
			pstmt.setString(2, n.getNcontent());
			pstmt.setString(3, n.getNwriter());
			pstmt.setDate(4, n.getNdate());
			
			result = pstmt.executeUpdate();
			
			System.out.println("pstmt.executeUpdate() : " + result);
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}

	public Notice selectOne(Connection con, int nno) {
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int result=0;
		
		StringBuffer sql = new StringBuffer();
		
		sql.append(prop.getProperty("selectOne"));
		
		Notice n = null;
		try {
			
			System.out.println("StringBuffer : " +sql.toString());
			
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, nno);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				n = new Notice(nno, rset.getString("NTITLE"), rset.getString("NWRITER"), rset.getString("NCONTENT"), rset.getInt("NCOUNT"), rset.getDate("NDATE"));
				System.out.println("Notice : "+n.toString());
				
				// 조회수 1증가
				if(n != null) {
					sql.replace(0, sql.length(), prop.getProperty("updateReadCount"));
					
					// 에러 확인을 위한 출력문
					System.out.println("sql.replace : " + sql.toString());
					System.out.println("sql.length() : "+ sql.length());
					
					pstmt = con.prepareStatement(sql.toString());
					
					pstmt.setInt(1, nno);
					
					if( (result = pstmt.executeUpdate()) >= 1) {
						commit(con);
					}else {
						rollback(con);
					}
				}
				
			}
			
		// selectOne의 db연결 작업 끝
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return n;
	}

	// 정보 변셩 작업
	public int updateNotice(Connection con, Notice n) {
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		Notice m = null;
		int result = 0;
		
		System.out.println(n.getNno());
				
		try {
			pstmt = con.prepareStatement( prop.getProperty("selectOne"));
			pstmt.setInt(1, n.getNno());
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				m = new Notice(
						rset.getInt("NNO"),
						rset.getString("NTITLE"),
						rset.getString("NWRITER"),
						rset.getString("NCONTENT"),
						rset.getInt("NCOUNT"),
						rset.getDate("NDATE")
						);
			}
			
			System.out.println("어떤 값을 수정 하는지 확인 : " +m);
			System.out.println("수정할 값 확인 : " +n);
			
			pstmt = con.prepareStatement( prop.getProperty("updateData"));
			
			pstmt.setString(1, n.getNtitle());
			pstmt.setString(2, n.getNcontent());
			pstmt.setDate(3, n.getNdate());
			pstmt.setInt(4, n.getNno());
			
			result = pstmt.executeUpdate();
			
			System.out.println("result : " +result);
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}

	// 삭제
	public int DeleteUpdate(Connection con, int nno) {
		
		PreparedStatement pstmt = null;
		int result = 0;
		
		String sql = prop.getProperty("delete");
		System.out.println("DeleteUpdate Dao 1-1");
		
		try {
			System.out.println("DeleteUpdate Dao 1-2");
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, nno);
			
			System.out.println("DeleteUpdate Dao 1-3");
			
			
			result = pstmt.executeUpdate();
			
			System.out.println("DeleteUpdate Dao 1-4");
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}

}
