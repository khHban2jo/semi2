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
	
	// 총 등록된 공지 사항 리스트 전체 수를 가젼 온다. 
	public int getListCount(Connection con, ArrayList<String> Datelist) {
		// 총 게시글 수
			
		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = "";
		
		try {
			
//			System.out.println("Datelist.get(0) : "+Datelist.get(0));
//			System.out.println("Datelist.get(1) : "+Datelist.get(1));
			
			if(Datelist.get(0).equals("") || Datelist.get(1).equals("")) {
//				System.out.println("date 가 ''인 상태 ");
				 sql = prop.getProperty("listCount");
				 pstmt = con.prepareStatement(sql);
			}else if( !Datelist.get(0).equals(Datelist.get(1))){
				sql = prop.getProperty("lisDatetCount");
				
//				System.out.println("sql : "+sql);
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, Datelist.get(0));
				pstmt.setString(2, Datelist.get(1));
				
			}else if(Datelist.get(0).equals(Datelist.get(1))) {
				sql = prop.getProperty("lisDatetCount2");
				
//				System.out.println("sql : "+sql);
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, Datelist.get(0));
			}
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				listCount = rset.getInt(1);
			}

//			System.out.println("총 db에 있는 행의 수 : "+listCount);
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		
		return listCount;
	}
	
	// 전체 검색을 통한 데이터를 가져오는 코드
	public ArrayList<Notice> selectList(Connection con, int currentPage, int limit, ArrayList<String> Datelist) {
		// 페이징 처리를 위한 곳
		
		ArrayList<Notice> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String sql = ""; 

		try {
			
			if(Datelist.get(0).equals("") && Datelist.get(1).equals("") ) {
				//selectList
				sql = prop.getProperty("selectList");
//				System.out.println("sql : " + sql);
				pstmt = con.prepareStatement(sql);
				
				int startRow = (currentPage-1)*limit+1;	// 1 11
				int endRow = startRow + limit - 1; 		// 5
				
				pstmt.setInt(1, endRow);
				pstmt.setInt(2, startRow);
			}else if( !Datelist.get(0).equals(Datelist.get(1))){
				// 두개의 날짜가 서로 다를때
				sql = prop.getProperty("selecDatetList");
				//System.out.println("sql : " + sql);
				pstmt = con.prepareStatement(sql);
				
				int startRow = (currentPage-1)*limit+1;	// 1 11
				int endRow = startRow + limit - 1; 		// 5
				
				pstmt.setString(1, Datelist.get(0));
				pstmt.setString(2, Datelist.get(1));
				pstmt.setInt(3, endRow);
				pstmt.setInt(4, startRow);
			}else if(Datelist.get(0).equals(Datelist.get(1))){
				// 두개의 날짜가 서로 같거나 동일한 한 날짜만 검색시
				sql = prop.getProperty("selecDatetList2");
				pstmt = con.prepareStatement(sql);
				
				int startRow = (currentPage-1)*limit+1;	// 1 11
				int endRow = startRow + limit - 1; 		// 5
				
				pstmt.setString(1, Datelist.get(0));
				pstmt.setInt(2, endRow);
				pstmt.setInt(3, startRow);
			}
			
//			pstmt = con.prepareStatement(sql);
//			
//			int startRow = (currentPage-1)*limit+1;	// 1 11
//			int endRow = startRow + limit - 1; 		// 5
//			
//			System.out.println("2-4");
//			pstmt.setInt(1, endRow);
//			pstmt.setInt(2, startRow);
			
			rset = pstmt.executeQuery();
			
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

	// 삽입
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
			
//			System.out.println("pstmt.executeUpdate() : " + result);
			
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
			
//			System.out.println("StringBuffer : " +sql.toString());
			
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, nno);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				n = new Notice(nno, rset.getString("NTITLE"), rset.getString("NWRITER"), rset.getString("NCONTENT"), rset.getInt("NCOUNT"), rset.getDate("NDATE"));
//				System.out.println("Notice : "+n.toString());
				
				// 조회수 1증가
				if(n != null) {
					sql.replace(0, sql.length(), prop.getProperty("updateReadCount"));
					
					// 에러 확인을 위한 출력문
//					System.out.println("sql.replace : " + sql.toString());
//					System.out.println("sql.length() : "+ sql.length());
					
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

	// 정보 변경 작업
	public int updateNotice(Connection con, Notice n) {
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		Notice m = null;
		int result = 0;
		
//		System.out.println(n.getNno());
				
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
			
//			System.out.println("어떤 값을 수정 하는지 확인 : " +m);
//			System.out.println("수정할 값 확인 : " +n);
			
			pstmt = con.prepareStatement( prop.getProperty("updateData"));
			
			pstmt.setString(1, n.getNtitle());
			pstmt.setString(2, n.getNcontent());
			pstmt.setDate(3, n.getNdate());
			pstmt.setInt(4, n.getNno());
			
			result = pstmt.executeUpdate();
			
//			System.out.println("result : " +result);
			
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
//		System.out.println("DeleteUpdate Dao 1-1");
		
		try {
//			System.out.println("DeleteUpdate Dao 1-2");
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, nno);
			
//			System.out.println("DeleteUpdate Dao 1-3");
			
			
			result = pstmt.executeUpdate();
			
//			System.out.println("DeleteUpdate Dao 1-4");
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}

	// 제목 or 내용 search 와 keyword 검색을 쿼리로 공지사항의 전체 갯수를 구하는 코드
	public int getListCount(Connection con, String search, String keyword, ArrayList<String> Datelist) {
		
		int listCount = 0;
		ArrayList<Notice> temp = new ArrayList<Notice>();
		
		Notice n = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = "";
		
//		System.out.println("====================================");
//		System.out.println("search : "+ search);
//		System.out.println("date1 : "+Datelist.get(0));
//		System.out.println("date2 : "+Datelist.get(1));
//		System.out.println("====================================");
		
//		switch(search) {
//		case "title":
//			sql = prop.getProperty("searchTitleNotice");
//			break;
//		case "content":
//			sql = prop.getProperty("searchContentNotice");
//			break;
//		}
		
		if(Datelist.get(0).equals("") || Datelist.get(1).equals("") ) {
			switch(search) {
			case "title":
				sql = prop.getProperty("searchTitleNotice");
				break;
			case "content":
				sql = prop.getProperty("searchContentNotice");
				break;
			}
		}else {
			switch(search) {
				case "title":
					sql = prop.getProperty("searchTitleNotice1");
					break;
				case "content":
					sql = prop.getProperty("searchContentNotice1");
					break;
			}
		}
		
		try {
//			System.out.println("sql : "+ sql);
			pstmt = con.prepareStatement(sql);

			if(Datelist.get(0).equals("") || Datelist.get(1).equals("") ) {
				
				pstmt.setString(1, keyword);
				
			}else {
				
				pstmt.setString(1, keyword);
				pstmt.setString(2, Datelist.get(0));
				pstmt.setString(3, Datelist.get(1));
				
			}
			
			rset = pstmt.executeQuery();
			
//			System.out.println("조건이 있는 상태에서 날짜를 적용 하여 전체 행의 갯수 출력");
			while(rset.next()) {
				n = new Notice();
				n.setNno(rset.getInt("NNO"));
				n.setNdate(rset.getDate("NDATE"));
				temp.add(n);
				
				if( !Datelist.get(0).equals("")) {
					System.out.println("listCount 실행");
					listCount += (Datelist.get(0).compareTo(n.getNdate().toString()) > 0)? 0 : (Datelist.get(1).compareTo(n.getNdate().toString()) >= 0)? 1: 0;	
				}else {
					listCount = temp.size();
				}
				
				// listCount 가 제대로 작동 하는 지 확인 해보는 테스트용 
				if(Datelist.get(0).compareTo(n.getNdate().toString()) > 0) {
					
				}else {
					if(Datelist.get(1).compareTo(n.getNdate().toString()) >= 0) {
						System.out.println("답 : "+n.toString());
					}
				}
				
			}
//			System.out.println(temp.size());
//			System.out.println("총 db에 있는 행의 수 : " + listCount);
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		
		return listCount;
	}

	// 검색 결과를 위한 페이징 처리 및 공지 사항 데이터 가져오는 코드
	public ArrayList<Notice> selectList(Connection con, int currentPage, int limit, String search, String keyword, ArrayList<String> Datelist) {
		
		ArrayList<Notice> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = "";
		
//		switch(search) {
//		
//			case "title":
//				sql = prop.getProperty("searchTitleList");
//				break;
//			case "content":
//				sql = prop.getProperty("searchContentList");
//				break;
//		}
		if(Datelist.get(0).equals("") || Datelist.get(1).equals("") ) {
			switch(search) {
			case "title":
				sql = prop.getProperty("searchTitle");
				break;
			case "content":
				sql = prop.getProperty("searchContent");
				break;
			}
		}else {
			switch(search) {
				case "title":
					sql = prop.getProperty("searchTitleList");
					break;
				case "content":
					sql = prop.getProperty("searchContentList");
					break;
			}
		}

		try {
			pstmt = con.prepareStatement(sql);
			
			int startRow = (currentPage-1)*limit+1;	
			int endRow = startRow + limit - 1; 		
			
//			System.out.println("startRow : "+ startRow);
//			System.out.println("endRow : "+ endRow);
//			System.out.println("sql : "+ sql);
			
			if(Datelist.get(0).equals("") && Datelist.get(1).equals("") ) {
				pstmt.setString(1, keyword);
				pstmt.setInt(2, endRow);
				pstmt.setInt(3, startRow);
			}else {				
				pstmt.setString(1, keyword);
				pstmt.setString(2, Datelist.get(0));
				pstmt.setString(3, Datelist.get(1));
				pstmt.setInt(4, endRow);
				pstmt.setInt(5, startRow);
			}
			
//			System.out.println(sql);
//			System.out.println("rset 까지 실행");
			
			rset = pstmt.executeQuery();
			
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
//		System.out.println("list 정보 확인");
		for(Notice show : list) {
			System.out.println(show.toString());
		}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public ArrayList<Notice> noticeAjax(Connection con) {
		
		ArrayList<Notice> list = new ArrayList<Notice>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = "listFiveNotice";
		
		try {
			sql = prop.getProperty(sql);
			pstmt = con.prepareStatement(sql);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Notice b = new Notice(
						rset.getInt("NNO"),
						rset.getString("NTITLE"),
						rset.getString("NWRITER"),
						rset.getString("NCONTENT"),
						rset.getInt("NCOUNT"),
						rset.getDate("NDATE")
						);
//				System.out.println(b.toString());
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


}
