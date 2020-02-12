package com.coo.board.model.dao;

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

import com.coo.board.model.vo.Board;
import com.coo.exception.CooException;


public class BoardDao {

	private Properties prop;
	
	public BoardDao() {
		prop = new Properties();
		String filePath = BoardDao.class.getResource("/config/board-query.properties").getPath();
		try {
			prop.load(new FileReader(filePath));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	public int getListCount(Connection con) throws CooException {
		int result = 0;
		Statement stmt = null;
		String sql = prop.getProperty("listCount");
		ResultSet rset = null;
		
		try {
			stmt = con.createStatement();
			
			rset = stmt.executeQuery(sql);
			if(rset.next()) {
				result = rset.getInt(1);
			}
			
		}catch(SQLException e) {
			throw new CooException(e.getMessage());
		}finally{
			close(rset);
			close(stmt);
		}
		return result;
	}

	public ArrayList<Board> selectList(Connection con, int currentPage, int limit) throws CooException {
		ArrayList<Board> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectList");
		
		try {
			list = new ArrayList<Board>();
			
			int startRow = (currentPage - 1)*limit + 1;
			int endRow = startRow + limit - 1;
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, endRow);
			pstmt.setInt(2, startRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Board b = new Board();
				b.setBno(rset.getInt("bno"));
				b.setBtype(rset.getInt("btype"));
				b.setBtitle(rset.getString("btitle"));
				b.setBcontent(rset.getString("bcontent"));
				b.setBwriter(rset.getString("bwriter"));
				b.setBcount(rset.getInt("bcount"));
				b.setBdate(rset.getDate("bdate"));
				b.setStatus(rset.getString("status"));
				b.setCategory(rset.getString("CNAME"));
				
				list.add(b);
			}
		}catch(SQLException e) {
			throw new CooException(e.getMessage());
		}finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public Board selectOne(Connection con, int bno) throws CooException {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		Board b = null;
		String sql = prop.getProperty("selectOne");
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bno);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				b = new Board();
				b.setBno(bno);
				b.setBtype(rset.getInt("btype"));
				b.setBtitle(rset.getString("btitle"));
				b.setBcontent(rset.getString("bcontent"));
				b.setBwriter(rset.getString("bwriter"));
				b.setBcount(rset.getInt("bcount"));
				b.setBdate(rset.getDate("bdate"));
				b.setStatus(rset.getString("status"));
				b.setCategory(rset.getString("CNAME"));
			}
			
		}catch(SQLException e) {
			throw new CooException("게시판 글 조회 실패");
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return b;
	}

	public int updateReadCount(Connection con, int bno) throws CooException {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateReadCount");
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bno);
			
			result = pstmt.executeUpdate();
			
		}catch(SQLException e) {
			throw new CooException("조회수 증가 실패");
		}finally {
			close(pstmt);
		}
		return result;
	}

	public int insertBoard(Connection con, Board b) throws CooException {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertBoard");
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,b.getBtype());
			pstmt.setString(2,b.getBtitle());
			pstmt.setString(3,b.getBcontent());
			pstmt.setString(4,b.getBwriter());
			pstmt.setString(5,b.getCategory());
			pstmt.setString(6,b.getBdeptCode());
			
			result = pstmt.executeUpdate();
			
		}catch(SQLException e) {
			throw new CooException("게시글 작성 실패");
		}finally {
			close(pstmt);
		}
		return result;
	}

	public int updateBoard(Connection con, Board b) throws CooException {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateBoard");
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, b.getBtype());
			pstmt.setString(2, b.getBtitle());
			pstmt.setString(3, b.getBcontent());
			pstmt.setString(4, b.getBwriter());
			pstmt.setString(5, b.getCategory());
			pstmt.setInt(6, b.getBno());
			
			result = pstmt.executeUpdate();
			
		}catch(SQLException e) {
			throw new CooException("게시판 수정 실패");
		}finally {
			close(pstmt);
		}
		return result;
	}

	public int deleteBoard(Connection con, int bno) throws CooException {
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteBoard");
		int result = 0;
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bno);
			
			result = pstmt.executeUpdate();
			
		}catch(SQLException e) {
			throw new CooException("게시글 삭제 실패");
		}finally {
			close(pstmt);
		}
		return result;
	}
}
