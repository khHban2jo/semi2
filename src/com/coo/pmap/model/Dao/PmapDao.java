package com.coo.pmap.model.Dao;


import static com.coo.common.JDBCTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

import com.coo.member.model.vo.Member;
import com.coo.pmap.model.vo.Pmap;

public class PmapDao {

	private Properties prop;

	public PmapDao() {

		prop = new Properties();

		String filePath = Pmap.class.getResource("/config/pmap-query.properties").getPath();


		try {
			prop.load(new FileReader(filePath));
		}catch(IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 전체 조직도 불러오기
	 * @param con
	 * @param currentPage
	 * @param limit
	 * @return
	 */
	public ArrayList<Member> selectList(Connection con,int currentPage, int limit) {
		Member p = null;
		ArrayList<Member> list = null;

		Statement stmt = null;

		ResultSet rset = null;

		String sql = prop.getProperty("selectList");

		try {
			stmt = con.createStatement();

			rset = stmt.executeQuery(sql);

			list = new ArrayList<Member>();

			while(rset.next()) {
				p = new Member();

				p.setEmpCode(rset.getInt("EMP_CODE"));
				p.setEmpName(rset.getString("emp_name"));
				p.setEmail(rset.getString("email"));
				p.setJobCode(rset.getString("job_name"));
				p.setDeptCode(rset.getString("dept_title"));

				list.add(p);
			}

			System.out.println(list);
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(stmt);
		}

		return list;
	}

	/**
	 * 조직도 페이징
	 * @param con
	 * @return
	 */
	public int getListCount(Connection con) {

		int listCount = 0;

		Statement stmt = null;

		ResultSet rset = null;

		String sql = prop.getProperty("listCount");

		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(sql);

			if(rset.next()) {
				listCount = rset.getInt(1);
			}

		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(stmt);
		}


		return listCount;
	}

	/**
	 *  조직도 검색 
	 * @param con
	 * @param category
	 * @param keyword
	 * @return
	 */
	public ArrayList<Member> searchPmap(Connection con, String category, String keyword) {
		
		ArrayList<Member> list = null;
		
		PreparedStatement pstmt = null;
		
		ResultSet rset = null;
				
		String sql = null;
		
		switch(category) { // 검색 조건
		case "deptTitle" : 
			sql = prop.getProperty("searchDeptTitle");
			break;
		
		case "jobName" : 
			sql = prop.getProperty("searchJobName");
			break;
			
		case "empName" : 
			sql = prop.getProperty("searchEmpName");
			break;
		}
		System.out.println("에스큐엘이 머냐 : " + sql);
		
		try {
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, keyword);
			
			rset = pstmt.executeQuery();
			
			list = new ArrayList<Member>();
			
			while(rset.next()) {
				
				Member m = new Member();
				
				m.setEmpName(rset.getString("emp_name"));
				m.setEmail(rset.getString("email"));
				m.setDeptCode(rset.getString("dept_title"));
				m.setJobCode(rset.getString("job_name"));
				m.setEmpCode(rset.getInt("emp_code"));
				
				list.add(m);
			}
				
				
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		for(Member p : list) System.out.println("요녀석을뽑아보자 =  " +p);
		
		return list;
	}

}
