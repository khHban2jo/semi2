package com.coo.board.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Properties;

import javax.servlet.http.HttpSession;

import static com.coo.common.JDBCTemplate.*;

import com.coo.board.model.vo.Board;
import com.coo.exception.CooException;
import com.coo.member.model.vo.Member;


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

	public ArrayList<Board> selectList(Connection con, int currentPage, int limit,String deptView) throws CooException {
		ArrayList<Board> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectList");
		
		try {
			list = new ArrayList<Board>();
			
			int startRow = (currentPage - 1)*limit + 1;
			int endRow = startRow + limit - 1;
			
			System.out.println("startRow : "+ startRow);
			System.out.println("endRow : "+ endRow);
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, endRow);
			pstmt.setInt(2, startRow);
			pstmt.setString(3, deptView);
			
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
				b.setBdeptCode(rset.getString("BDEPT_CODE"));
				
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
				b.setBdeptCode(rset.getString("BDEPT_CODE"));
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
			pstmt.setString(6, b.getBdeptCode());
			pstmt.setInt(7, b.getBno());
			
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
	
	// ========================== 검색을 위한 코드 ==================================
	public int getListCount(Connection con, Hashtable<String, String> parameters) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String inputSql= "";
		
		
		String title = parameters.get("title"); //  검색 조건
		
		System.out.println("title : "+ title);
		
		String date1 = parameters.get("date1");
		String date2 = parameters.get("date2");
		
		System.out.println("========================== DAO : 게시판의 전체 갯수 디버깅 ==========================================");
		// 검색 조건으로 먼저 걸러 낸다.
		if(title.equals("title")) { // 제목
			inputSql = (date1.isEmpty() && date2.isEmpty())? "listTitleCount1" : (date1.equals(date2))? "listTitleCount2" : "listTitleCount3"; 
		}else if(title.equals("content")) { // 내용
			inputSql = (date1.isEmpty() && date2.isEmpty())? "listBcontentCount1" : (date1.equals(date2))? "listBcontentCount2" : "listBcontentCount3"; 
		}else if(title.equals("dept")) { // 직급
			inputSql = (date1.isEmpty() && date2.isEmpty())? "listJOB_NAMECount1" : (date1.equals(date2))? "listJOB_NAMECount2" : "listJOB_NAMECount3"; 
		}else if(title.equals("all")) { // 전체조건 
			inputSql = "listAll"; 
		}
		
		System.out.println("inputSql : "+ inputSql);
		
		String sql = prop.getProperty(inputSql);
		
		System.out.println("==파라미터 값 확인==");
		Enumeration<String> out = parameters.keys();
		while(out.hasMoreElements()) {
			String keys = out.nextElement();
			System.out.println(keys+" : "+parameters.get(keys));
		}
		System.out.println("==============================");

		System.out.println("sql : "+ sql);
		
		try {
			pstmt = con.prepareStatement(sql);
			
			// 검색 조건에 맞는 값(?) 삽입, 
			if(title.equals("title")) { // 제목
				//pstmt.setString(1, parameters.get("searchType")); // 분류 
				if(date1.isEmpty() && date2.isEmpty()) {
					
					pstmt.setString(1, parameters.get("deptView"));		// 부서 코드
					pstmt.setString(2, parameters.get("searchType"));	// 분류
					pstmt.setString(3, parameters.get("keyword"));		// 내용
				}else if(date1.equals(date2)){
					
					pstmt.setString(1, parameters.get("deptView"));		// 부서 코드
					pstmt.setString(2, parameters.get("searchType"));	// 분류
					pstmt.setString(3, parameters.get("keyword"));		// 내용
					pstmt.setString(4, parameters.get("date1"));		// 날짜 1
				}else if(!date1.equals(date2)){
					
					pstmt.setString(1, parameters.get("deptView"));		// 부서 코드
					pstmt.setString(2, parameters.get("searchType"));	// 분류
					pstmt.setString(3, parameters.get("keyword"));		// 내용
					pstmt.setString(4, parameters.get("date1"));		// 날짜 1
					pstmt.setString(5, parameters.get("date2"));		// 날짜 2
					
					System.out.println("1 : "  + parameters.get("deptView"));
					System.out.println("2 : "  + parameters.get("searchType"));
					System.out.println("3 : "  + parameters.get("keyword"));
					System.out.println("4 : "  + parameters.get("date1"));
					System.out.println("5 : "  + parameters.get("date2"));
					
				}

			}else if(title.equals("content")) { // 내용
				if(date1.isEmpty() && date2.isEmpty()) {
					pstmt.setString(1, parameters.get("deptView"));		// 부서 코드
					pstmt.setString(2, parameters.get("searchType"));	// 분류
					pstmt.setString(3, parameters.get("keyword"));		// 내용
				}else if(date1.equals(date2)){
					pstmt.setString(1, parameters.get("deptView"));		// 부서 코드
					pstmt.setString(2, parameters.get("searchType"));	// 분류
					pstmt.setString(3, parameters.get("keyword"));		// 내용
					pstmt.setString(4, parameters.get("date1"));		// 날짜 1
				}else if(!date1.equals(date2)){
					pstmt.setString(1, parameters.get("deptView"));		// 부서 코드
					pstmt.setString(2, parameters.get("searchType"));	// 분류
					pstmt.setString(3, parameters.get("keyword"));		// 내용
					pstmt.setString(4, parameters.get("date1"));		// 날짜 1
					pstmt.setString(5, parameters.get("date2"));		// 날짜 2
				}
			}else if(title.equals("dept")) { // 직급
				
				if(date1.isEmpty() && date2.isEmpty()) {
					pstmt.setString(1, parameters.get("keyword"));		// 내용
				}else if(date1.equals(date2)){
					pstmt.setString(1, parameters.get("keyword"));		// 내용
					pstmt.setString(2, parameters.get("date1"));		// 날짜 1
				}else if(!date1.equals(date2)){
					pstmt.setString(1, parameters.get("keyword"));		// 내용
					pstmt.setString(2, parameters.get("date1"));		// 날짜 1
					pstmt.setString(3, parameters.get("date2"));		// 날짜 2
				}
				
			}else if(title.equals("all")) { // 전체조건 
				pstmt.setString(1, parameters.get("deptView"));		// 부서 코드
				pstmt.setString(2, parameters.get("searchType"));	// 분류
				pstmt.setString(3, parameters.get("keyword"));		// 제목 검색
				pstmt.setString(4, parameters.get("keyword"));		// 내용 검색
				pstmt.setString(5, parameters.get("date1"));		// 날짜 1
				pstmt.setString(6, parameters.get("date2"));		// 날짜 2
			}
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				System.out.println("실행");
				result = rset.getInt(1);
			}
			
			
			System.out.println("result : "+ result);
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		
		System.out.println("======================================================================================");
		
		return result;
	}
}
