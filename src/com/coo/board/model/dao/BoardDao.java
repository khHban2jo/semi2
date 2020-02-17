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
import java.util.Collections;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Properties;

import javax.servlet.http.HttpSession;

import static com.coo.common.JDBCTemplate.*;

import com.coo.board.model.vo.Board;
import com.coo.board.model.vo.Decending;
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
			if (rset.next()) {
				result = rset.getInt(1);
			}

		} catch (SQLException e) {
			throw new CooException(e.getMessage());
		} finally {
			close(rset);
			close(stmt);
		}
		return result;
	}

	public ArrayList<Board> selectList(Connection con, int currentPage, int limit, String deptView)
			throws CooException {
		ArrayList<Board> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectList");

		try {
			list = new ArrayList<Board>();

			int startRow = (currentPage - 1) * limit + 1;
			int endRow = startRow + limit - 1;

			System.out.println("startRow : " + startRow);
			System.out.println("endRow : " + endRow);

			pstmt = con.prepareStatement(sql);

//			pstmt.setString(1, deptView);
			pstmt.setInt(1, endRow);
			pstmt.setInt(2, startRow);

			rset = pstmt.executeQuery();

			while (rset.next()) {
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
				
				System.out.println(b.toString());
				list.add(b);
			}
		} catch (SQLException e) {
			throw new CooException(e.getMessage());
		} finally {
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

			if (rset.next()) {
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

		} catch (SQLException e) {
			throw new CooException("게시판 글 조회 실패");
		} finally {
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

		} catch (SQLException e) {
			throw new CooException("조회수 증가 실패");
		} finally {
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
			pstmt.setInt(1, b.getBtype());
			pstmt.setString(2, b.getBtitle());
			pstmt.setString(3, b.getBcontent());
			pstmt.setString(4, b.getBwriter());
			pstmt.setString(5, b.getCategory());
			pstmt.setString(6, b.getBdeptCode());

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			throw new CooException("게시글 작성 실패");
		} finally {
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

		} catch (SQLException e) {
			throw new CooException("게시판 수정 실패");
		} finally {
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

		} catch (SQLException e) {
			throw new CooException("게시글 삭제 실패");
		} finally {
			close(pstmt);
		}
		return result;
	}

	// ========================== 검색을 위한 코드 ==================================
	public ArrayList<Board> getListCount(Connection con, Hashtable<String, String> parameters, ArrayList<Board> list) {

		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String inputSql = "";

		String title = parameters.get("title"); // 검색 조건

		System.out.println("title : " + title);

		String date1 = parameters.get("date1");
		String date2 = parameters.get("date2");

		// 페이징 처리를 위한 데이터 아래 3개의 int 형 데이터는 페이징 처리를 위한 계산을 하여  parameters에 추가하여 다시 보낸다.
		int startPage;
		int endPage;
		int maxPage;
		// 
		int limit = Integer.parseInt(parameters.get("limit"));
		int currentPage = Integer.parseInt(parameters.get("currentPage"));;
		
		System.out.println("========================== DAO : 게시판의 전체 갯수 디버깅 ==========================================");
		
		// 검색 조건으로 먼저 걸러 낸다.
		if (parameters.get("etc").equals("관리자")) {
			if (title.equals("title")) {

				if (!parameters.get("searchType").equals("1")) {
					inputSql = (date1.isEmpty() && date2.isEmpty()) ? "adminListTitleCount"
							: (date1.equals(date2)) ? "adminListTitleOneDateCount" : "adminListTitleTwoDateCount";
				} else {
					inputSql = (date1.isEmpty() && date2.isEmpty()) ? "adminListTitleCount1"
							: (date1.equals(date2)) ? "adminListTitleOneDateCount1" : "adminListTitleTwoDateCount1";
				}

			} else if (title.equals("content")) {

				if (!parameters.get("searchType").equals("1")) {
					inputSql = (date1.isEmpty() && date2.isEmpty()) ? "adminListBContentCount"
							: (date1.equals(date2)) ? "adminListBContentOneDateCount" : "adminListBContentTwoDateCount";
				} else {
					inputSql = (date1.isEmpty() && date2.isEmpty()) ? "adminListBContentCount1"
							: (date1.equals(date2)) ? "adminListBContentOneDateCount1"
									: "adminListBContentTwoDateCount1";
				}

			} else if (title.equals("dept")) {
				
				// parameters.get("searchType")
				if ( !parameters.get("searchType").equals("1")) {
					inputSql = (date1.isEmpty() && date2.isEmpty()) ? "adminListJOB_NAMEOne1" : (date1.equals(date2)) ? "adminListJOB_NAMEOne2" : "adminListJOB_NAMEOne3";
				}else {					
					inputSql = (date1.isEmpty() && date2.isEmpty()) ? "adminListJOB_NAME1" : (date1.equals(date2)) ? "adminListJOB_NAME2" : "adminListJOB_NAME3";
				}
				
			} else if (title.equals("all")) { // 전체조건
				// 전체조건 에서는 제목 내용 상관 없이 모두 보여주는 것
				// 관리자 처음 올시에 조건이 없는 상태에서의 페이지 처리와 페이징 처리를 위해 따로 '전체조건' 을 위한 코드를 만든다. 
				if (!parameters.get("searchType").equals("1")) {
					
					// parameters.get("searchType") - 2
					if(parameters.get("searchType").equals("2")) {						
						inputSql = "adminlist2";
					}
					
					// parameters.get("searchType") - 3
					if(parameters.get("searchType").equals("3")) {						
						inputSql = "adminlist3";
					}
					
					// parameters.get("searchType") - 4		
					if(parameters.get("searchType").equals("4")) {						
						inputSql = "adminlist4";
					}
					
				}else {
					inputSql = "adminlistAll";
				}
			}

			// 관리자가 아닌 조건 유저 쿼리
		} else {
			if (title.equals("title")) { // 제목

				if (!parameters.get("searchType").equals("1")) {
					inputSql = (date1.isEmpty() && date2.isEmpty()) ? "listTitleCount1" : (date1.equals(date2)) ? "listTitleCount2" : "listTitleCount3";
				} else {
					inputSql = (date1.isEmpty() && date2.isEmpty()) ? "listTitleCount11": (date1.equals(date2)) ? "listTitleCount21" : "listTitleCount31";
				}
			} else if (title.equals("content")) { // 내용

				if (!parameters.get("searchType").equals("1")) {
					inputSql = (date1.isEmpty() && date2.isEmpty()) ? "listBcontentCount1"
							: (date1.equals(date2)) ? "listBcontentCount2" : "listBcontentCount3";
				} else {
					inputSql = (date1.isEmpty() && date2.isEmpty()) ? "listBcontentCount11"
							: (date1.equals(date2)) ? "listBcontentCount21" : "listBcontentCount31";
				}

			} else if (title.equals("dept")) { // 직급
				
				if (!parameters.get("searchType").equals("1")) {
					inputSql = (date1.isEmpty() && date2.isEmpty()) ? "listJOB_NAMECount1" : (date1.equals(date2)) ? "listJOB_NAMECount2" : "listJOB_NAMECount3";
				}else {					
					inputSql = (date1.isEmpty() && date2.isEmpty()) ? "listJOB_NAMECount11" : (date1.equals(date2)) ? "listJOB_NAMECount21" : "listJOB_NAMECount31";
				}
				
			} else if (title.equals("all")) { // 전체조건
				
				// 전체조건 에서는 제목 내용 상관 없이 모두 보여주는 것
				// 유저가 처음 올시에 조건이 없는 상태에서의 페이지 처리와 페이징 처리를 위해 따로 '전체조건' 을 위한 코드를 만든다. 
				if (!parameters.get("searchType").equals("1")) {
					// parameters.get("searchType") - 2
					inputSql = "listAll2";
					// parameters.get("searchType") - 3
					inputSql = "listAll3";
					// parameters.get("searchType") - 4			
					inputSql = "listAll4";
				}else {
					inputSql = "listAll";
				}
			}
		}

// 처음 검색 조건을 잘못 설정 해서 위의 코드는 그냥 두고 다시 btype == 1 인 전체 조건일시 때만 다시 조건에 따라 sql을 구하게 한다.
//		if(parameters.get("searchType").equals("1")) {
//			if(title.equals("title")) { // 제목
//				inputSql = (date1.isEmpty() && date2.isEmpty())? "listTitleCount1" : (date1.equals(date2))? "listTitleCount2" : "listTitleCount3"; 
//			}else if(title.equals("content")) { // 내용
//				inputSql = (date1.isEmpty() && date2.isEmpty())? "listBcontentCount1" : (date1.equals(date2))? "listBcontentCount2" : "listBcontentCount3"; 
//			}else if(title.equals("dept")) { // 직급
//				inputSql = (date1.isEmpty() && date2.isEmpty())? "listJOB_NAMECount1" : (date1.equals(date2))? "listJOB_NAMECount2" : "listJOB_NAMECount3"; 
//			}else if(title.equals("all")) { // 전체조건 
//				inputSql = "listAll"; 
//			}
//		}

		System.out.println("inputSql : " + inputSql);

		String sql = prop.getProperty(inputSql);

		System.out.println("==파라미터 값 확인==");
		Enumeration<String> out = parameters.keys();
		while (out.hasMoreElements()) {
			String keys = out.nextElement();
			System.out.println(keys + " : " + parameters.get(keys));
		}
		System.out.println("==============================");

		System.out.println("sql : " + sql);

		ArrayList<Board> copy = null;
		try {
			pstmt = con.prepareStatement(sql);

			// 조건에 따른 검색 구분
			if (parameters.get("etc").equals("관리자")) {

				if ( !parameters.get("searchType").equals("1")) { // 전체 검색인지 구분
																  // 전체 조건아닌 경우, parameters.get("searchType") : o
					if (title.equals("title")) { // 제목
						// pstmt.setString(1, parameters.get("searchType")); // 분류
						if (date1.isEmpty() && date2.isEmpty()) {

							// 관리자는 모든 부서를 봐야 되므로 부서 코드 x
							pstmt.setString(1, parameters.get("searchType")); // 분류
							pstmt.setString(2, parameters.get("keyword")); // 내용
						} else if (date1.equals(date2)) {

							// 관리자는 모든 부서를 봐야 되므로 부서 코드 x
							pstmt.setString(1, parameters.get("searchType")); // 분류
							pstmt.setString(2, parameters.get("keyword")); // 내용
							pstmt.setString(3, parameters.get("date1")); // 날짜 1
						} else if (!date1.equals(date2)) {

							// 관리자는 모든 부서를 봐야 되므로 부서 코드 x
							pstmt.setString(1, parameters.get("searchType")); // 분류
							pstmt.setString(2, parameters.get("keyword")); // 내용
							pstmt.setString(3, parameters.get("date1")); // 날짜 1
							pstmt.setString(4, parameters.get("date2")); // 날짜 2

							System.out.println("1 : " + parameters.get("searchType"));
							System.out.println("2 : " + parameters.get("keyword"));
							System.out.println("3 : " + parameters.get("date1"));
							System.out.println("4 : " + parameters.get("date2"));
						}

					} else if (title.equals("content")) { // 내용
						if (date1.isEmpty() && date2.isEmpty()) {
							// 관리자는 모든 부서를 봐야 되므로 부서 코드 x
							pstmt.setString(1, parameters.get("searchType")); // 분류
							pstmt.setString(2, parameters.get("keyword")); // 내용
						} else if (date1.equals(date2)) {

							// 관리자는 모든 부서를 봐야 되므로 부서 코드 x
							pstmt.setString(1, parameters.get("searchType")); // 분류
							pstmt.setString(2, parameters.get("keyword")); // 내용
							pstmt.setString(3, parameters.get("date1")); // 날짜 1

						} else if (!date1.equals(date2)) {

							// 관리자는 모든 부서를 봐야 되므로 부서 코드 x
							pstmt.setString(1, parameters.get("searchType")); // 분류
							pstmt.setString(2, parameters.get("keyword")); // 내용
							pstmt.setString(3, parameters.get("date1")); // 날짜 1
							pstmt.setString(4, parameters.get("date2")); // 날짜 2

							System.out.println("1 : " + parameters.get("searchType"));
							System.out.println("2 : " + parameters.get("keyword"));
							System.out.println("3 : " + parameters.get("date1"));
							System.out.println("4 : " + parameters.get("date2"));
						}
					} else if (title.equals("dept")) { // 직급

						if (date1.isEmpty() && date2.isEmpty()) {
							pstmt.setString(1, parameters.get("searchType"));
							pstmt.setString(2, parameters.get("keyword")); // 내용
						} else if (date1.equals(date2)) {
							pstmt.setString(1, parameters.get("searchType"));
							pstmt.setString(2, parameters.get("keyword")); // 내용
							pstmt.setString(3, parameters.get("date1")); // 날짜 1
						} else if (!date1.equals(date2)) {
							pstmt.setString(1, parameters.get("searchType"));
							pstmt.setString(2, parameters.get("keyword")); // 내용
							pstmt.setString(3, parameters.get("date1")); // 날짜 1
							pstmt.setString(4, parameters.get("date2")); // 날짜 2
						}

					} else if (title.equals("all")) { // 전체조건
						// 관리자는 모든 부서와 내용 날짜 상관없이 봐야 되므로 조건 x
						// 전체 조건이 아니므로 전체 조건이 아니고 title.equals("all") 할시에는 부서 searchType 에 따라서 sql구문에서 걸러 내준다.
						// 
					}
				} else {
					
					// 전체 조건 검색인 경우, parameters.get("searchType") : x
					
					if (title.equals("title")) { // 제목
						// pstmt.setString(1, parameters.get("searchType")); // 분류
						if (date1.isEmpty() && date2.isEmpty()) {

							// 관리자는 모든 부서를 봐야 되므로 부서 코드 x
							pstmt.setString(1, parameters.get("keyword")); // 내용
						} else if (date1.equals(date2)) {

							// 관리자는 모든 부서를 봐야 되므로 부서 코드 x
							pstmt.setString(1, parameters.get("keyword")); // 내용
							pstmt.setString(2, parameters.get("date1")); // 날짜 1
						} else if (!date1.equals(date2)) {

							// 관리자는 모든 부서를 봐야 되므로 부서 코드 x
							pstmt.setString(1, parameters.get("keyword")); // 내용
							pstmt.setString(2, parameters.get("date1")); // 날짜 1
							pstmt.setString(3, parameters.get("date2")); // 날짜 2

						}

					} else if (title.equals("content")) { // 내용
						if (date1.isEmpty() && date2.isEmpty()) {
							// 관리자는 모든 부서를 봐야 되므로 부서 코드 x
							pstmt.setString(1, parameters.get("keyword")); // 내용
						} else if (date1.equals(date2)) {

							// 관리자는 모든 부서를 봐야 되므로 부서 코드 x
							pstmt.setString(1, parameters.get("keyword")); // 내용
							pstmt.setString(2, parameters.get("date1")); // 날짜 1

						} else if (!date1.equals(date2)) {

							// 관리자는 모든 부서를 봐야 되므로 부서 코드 x
							pstmt.setString(1, parameters.get("keyword")); // 내용
							pstmt.setString(2, parameters.get("date1")); // 날짜 1
							pstmt.setString(3, parameters.get("date2")); // 날짜 2

						}
					} else if (title.equals("dept")) { // 직급

						if (date1.isEmpty() && date2.isEmpty()) {
							pstmt.setString(1, parameters.get("keyword")); // 내용
						} else if (date1.equals(date2)) {
							pstmt.setString(1, parameters.get("keyword")); // 내용
							pstmt.setString(2, parameters.get("date1")); // 날짜 1
						} else if (!date1.equals(date2)) {
							pstmt.setString(1, parameters.get("keyword")); // 내용
							pstmt.setString(2, parameters.get("date1")); // 날짜 1
							pstmt.setString(3, parameters.get("date2")); // 날짜 2
						}

					} else if (title.equals("all")) { // 전체조건 
						// 
					}
				}
				
			} else { 
				// 관리자가 아닌 유저
				
				if ( !parameters.get("searchType").equals("1")) { // 전체 검색인지 구분
																 // 전체 조건 아닌 경우, parameters.get("searchType") : o
					System.out.println("관리자가 아닌 유저 검색 시작");
					
					if (title.equals("title")) { // 제목

						// pstmt.setString(1, parameters.get("searchType")); // 분류
						if (date1.isEmpty() && date2.isEmpty()) {

							pstmt.setString(1, parameters.get("deptView")); // 부서 코드
							pstmt.setString(2, parameters.get("searchType")); // 분류
							pstmt.setString(3, parameters.get("keyword")); // 내용
						} else if (date1.equals(date2)) {

							pstmt.setString(1, parameters.get("deptView")); // 부서 코드
							pstmt.setString(2, parameters.get("searchType")); // 분류
							pstmt.setString(3, parameters.get("keyword")); // 내용
							pstmt.setString(4, parameters.get("date1")); // 날짜 1
						} else if (!date1.equals(date2)) {

							pstmt.setString(1, parameters.get("deptView")); // 부서 코드
							pstmt.setString(2, parameters.get("searchType")); // 분류
							pstmt.setString(3, parameters.get("keyword")); // 내용
							pstmt.setString(4, parameters.get("date1")); // 날짜 1
							pstmt.setString(5, parameters.get("date2")); // 날짜 2

							System.out.println("1 : " + parameters.get("deptView"));
							System.out.println("2 : " + parameters.get("searchType"));
							System.out.println("3 : " + parameters.get("keyword"));
							System.out.println("4 : " + parameters.get("date1"));
							System.out.println("5 : " + parameters.get("date2"));

						}

					} else if (title.equals("content")) { // 내용
						if (date1.isEmpty() && date2.isEmpty()) {
							pstmt.setString(1, parameters.get("deptView")); // 부서 코드
							pstmt.setString(2, parameters.get("searchType")); // 분류
							pstmt.setString(3, parameters.get("keyword")); // 내용
						} else if (date1.equals(date2)) {
							pstmt.setString(1, parameters.get("deptView")); // 부서 코드
							pstmt.setString(2, parameters.get("searchType")); // 분류
							pstmt.setString(3, parameters.get("keyword")); // 내용
							pstmt.setString(4, parameters.get("date1")); // 날짜 1
						} else if (!date1.equals(date2)) {
							pstmt.setString(1, parameters.get("deptView")); // 부서 코드
							pstmt.setString(2, parameters.get("searchType")); // 분류
							pstmt.setString(3, parameters.get("keyword")); // 내용
							pstmt.setString(4, parameters.get("date1")); // 날짜 1
							pstmt.setString(5, parameters.get("date2")); // 날짜 2
						}
					} else if (title.equals("dept")) { // 직급

						if (date1.isEmpty() && date2.isEmpty()) {
							pstmt.setString(1, parameters.get("keyword")); // 내용
							pstmt.setString(2, parameters.get("deptView")); // 부서 코드
							pstmt.setString(3, parameters.get("searchType")); // 분류
						} else if (date1.equals(date2)) {
							pstmt.setString(1, parameters.get("keyword")); // 내용
							pstmt.setString(2, parameters.get("date1")); // 날짜 1
							pstmt.setString(3, parameters.get("deptView")); // 부서 코드
							pstmt.setString(4, parameters.get("searchType")); // 분류
						} else if (!date1.equals(date2)) {
							pstmt.setString(1, parameters.get("keyword")); // 내용
							pstmt.setString(2, parameters.get("date1")); // 날짜 1
							pstmt.setString(3, parameters.get("date2")); // 날짜 2
							pstmt.setString(4, parameters.get("deptView")); // 부서 코드
							pstmt.setString(5, parameters.get("searchType")); // 분류
						}

					} else if (title.equals("all")) { // 전체조건
						pstmt.setString(1, parameters.get("deptView")); // 부서 코드
					}

				} else {
					
					// 전체 조건 검색인 경우, parameters.get("searchType") : x
					
					if (title.equals("title")) { // 제목

						// pstmt.setString(1, parameters.get("searchType")); // 분류
						if (date1.isEmpty() && date2.isEmpty()) {

							pstmt.setString(1, parameters.get("deptView")); // 부서 코드
							pstmt.setString(2, parameters.get("keyword")); // 내용
						} else if (date1.equals(date2)) {

							pstmt.setString(1, parameters.get("deptView")); // 부서 코드
							pstmt.setString(2, parameters.get("keyword")); // 내용
							pstmt.setString(3, parameters.get("date1")); // 날짜 1
						} else if (!date1.equals(date2)) {

							pstmt.setString(1, parameters.get("deptView")); // 부서 코드
							pstmt.setString(2, parameters.get("keyword")); // 내용
							pstmt.setString(3, parameters.get("date1")); // 날짜 1
							pstmt.setString(4, parameters.get("date2")); // 날짜 2

						}

					} else if (title.equals("content")) { // 내용
						if (date1.isEmpty() && date2.isEmpty()) {
							pstmt.setString(1, parameters.get("deptView")); // 부서 코드
							pstmt.setString(2, parameters.get("keyword")); // 내용
						} else if (date1.equals(date2)) {
							pstmt.setString(1, parameters.get("deptView")); // 부서 코드
							pstmt.setString(2, parameters.get("keyword")); // 내용
							pstmt.setString(3, parameters.get("date1")); // 날짜 1
						} else if (!date1.equals(date2)) {
							pstmt.setString(1, parameters.get("deptView")); // 부서 코드
							pstmt.setString(2, parameters.get("keyword")); // 내용
							pstmt.setString(3, parameters.get("date1")); // 날짜 1
							pstmt.setString(4, parameters.get("date2")); // 날짜 2
						}
					} else if (title.equals("dept")) { // 직급

						if (date1.isEmpty() && date2.isEmpty()) {
							pstmt.setString(1, parameters.get("keyword")); // 내용
							pstmt.setString(2, parameters.get("deptView")); // 부서 코드
						} else if (date1.equals(date2)) {
							pstmt.setString(1, parameters.get("keyword")); // 내용
							pstmt.setString(2, parameters.get("date1")); // 날짜 1
							pstmt.setString(3, parameters.get("deptView")); // 부서 코드
						} else if (!date1.equals(date2)) {
							pstmt.setString(1, parameters.get("keyword")); // 내용
							pstmt.setString(2, parameters.get("date1")); // 날짜 1
							pstmt.setString(3, parameters.get("date2")); // 날짜 2
							pstmt.setString(4, parameters.get("deptView")); // 부서 코드
						}

					} else if (title.equals("all")) { // 전체조건
						pstmt.setString(1, parameters.get("deptView")); // 부서 코드
					}
				}
			}

			rset = pstmt.executeQuery();
			
			while (rset.next()) {
				System.out.println("실행");
				
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
				//result = rset.getInt(1);
			}
			
			// 리스트로 받아온 값을 bno을 기준으로 정렬 하여 ROWNUM을 대체 하고 (empid를 기준으로 자료를 다시 걸러 내고 => sql에서 한번 해보자)
			// int startRow = (currentPage - 1) * limit + 1; ,, int endRow = startRow + limit - 1; 을 계산 
			System.out.println("-------- 가져오는 리스트 확인 -------");
			for(Board show : list) {
				System.out.println(show.toString());
			}
			
			Collections.sort(list, new Decending());
			
			System.out.println();
			System.out.println("내림 차순 정렬 확인용");
			for(Board show : list) {
				System.out.println(show.toString());
			}			
			
			// list에 저장된 데이터의 갯수를 지정하여 가져 갈수 있도 록 하기 위한 것
			copy = new ArrayList<Board>();
			
			int startRow = (currentPage - 1) * limit + 1;
			int endRow = startRow + limit - 1;

			System.out.println("list.size() : "+list.size());
			
			// 8개 데이터를 가져 오는 경우 : 1 ~ 8 => 0 ~ 7
			for(int i = startRow-1; i<endRow && i < list.size(); i++) {
				copy.add(list.get(i));
			}
			
			System.out.println();
			System.out.println("================== 제대로 입력 되었는지 확인 ==================");
			for(Board show : copy) {
				System.out.println(show.toString());
			}	
			
			listCount = list.size();
			maxPage = (int) ((double) listCount / limit + 0.9);
			startPage = ((int) ((double) currentPage / limit + 0.9) - 1) * limit + 1;
			endPage = startPage + limit - 1;
			
			System.out.println("listCount : " +listCount);
			parameters.put("maxPage", String.valueOf(maxPage));
			parameters.put("startPage", String.valueOf(startPage));
			parameters.put("endPage", String.valueOf(endPage));
			
			System.out.println("=================== 페이징 처리를 위한 계산이 제대로 되었는지 확인 ========================");
			System.out.println("currentPage : "+ currentPage);
			System.out.println("startPage : "+ startPage);
			System.out.println("endPage : "+ endPage);
			System.out.println("maxPage : "+ maxPage);
			System.out.println("list.size() : " + list.size());
			System.out.println("copy.size() : " + copy.size());

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		System.out.println("======================================================================================");

		return copy;
	}
}
