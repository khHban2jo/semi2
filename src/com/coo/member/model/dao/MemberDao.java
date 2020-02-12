package com.coo.member.model.dao;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import static com.coo.common.JDBCTemplate.*;
import com.coo.exception.CooException;
import com.coo.member.model.vo.Member;

public class MemberDao {

	private Properties prop;
	
	public MemberDao() {
		prop = new Properties();
		String filePath = MemberDao.class.getResource("/config/member-query.properties").getPath();
		
		try {
			prop.load(new FileReader(filePath));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	public Member selectMember(Member m, Connection con) throws CooException {
		Member result = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectMember");
	
		try {
			 pstmt = con.prepareStatement(sql);
			
			 pstmt.setString(1, m.getEmpId());
			 pstmt.setString(2, m.getEmpPwd());
			 
			 rset = pstmt.executeQuery();
			 
			 if(rset.next()) {
				 result = new Member();
				 result.setEmpId(rset.getString("EMP_ID"));
				 result.setEmpCode(rset.getInt("EMP_CODE"));
				 result.setEmpPwd(rset.getString("PWD"));
				 result.setEmpName(rset.getString("EMP_NAME"));
				 result.setPersonalId(rset.getString("PERSONAL_ID"));
				 result.setEmail(rset.getString("EMAIL"));
				 result.setGender(rset.getString("GENDER"));
				 result.setAge(rset.getInt("AGE"));
				 result.setSalary(rset.getInt("SALARY"));
				 result.setPhone(rset.getString("PHONE")); 
				 result.setAddress(rset.getString("ADDRESS"));
				 result.setDeptCode(rset.getString("DEPT_CODE"));
				 result.setJobCode(rset.getString("JOB_CODE"));
				 result.setDeptTitle(rset.getString("DEPT_TITLE"));
				 result.setJobName(rset.getString("JOB_NAME")); 
				 result.setEtc(rset.getString("ETC"));
				 result.setManagerYn(rset.getString("MANAGER_YN"));
				 result.setHireDate(rset.getDate("HIRE_DATE"));
				 result.setSubDept(rset.getString("SUB_DEPT"));
			 }
			
		}catch(SQLException e) {
			throw new CooException(e.getMessage());
		}finally {
			close(rset);
			close(pstmt);
		}
		return result;
	}

	public int checkEmp(Connection con) throws CooException {
		int result = -1;
		Statement stmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("checkEmp");
		
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(sql);
			
			if(rset.next()) {
				result = rset.getInt(1); 
			}
			
		}catch(SQLException e) {
			throw new CooException("사번 조회 실패");
		}
		return result;
	}

}
