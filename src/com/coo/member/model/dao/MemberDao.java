package com.coo.member.model.dao;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
				 result = new Member(rset.getString("EMP_ID"), rset.getInt("EMP_CODE"), 
						 rset.getString("PWD"), rset.getString("EMP_NAME"), rset.getString("PERSONAL_ID"), 
						 rset.getString("EMAIL"), rset.getString("GENDER"), rset.getInt("AGE"), rset.getInt("SALARY"), 
						 rset.getString("PHONE"), rset.getString("ADDRESS"), rset.getString("DEPT_TITLE"), rset.getString("JOB_NAME"), 
						 rset.getString("ETC"), rset.getString("MANAGER_YN"), rset.getDate("HIRE_DATE"), rset.getString("SUB_DEPT"));
			 }
			
		}catch(SQLException e) {
			throw new CooException(e.getMessage());
		}finally {
			close(rset);
			close(pstmt);
		}
		return result;
	}

}
