package com.coo.pmap.model.Dao;


import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

import com.coo.pmap.model.vo.Pmap;
import static com.coo.common.JDBCTemplate.*;

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
	
	public ArrayList<Pmap> selectList(Connection con) {
		
		ArrayList<Pmap> list = null;
		
		Statement stmt = null;
		
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectList");
		
		try {
			stmt = con.createStatement();
			
			rset = stmt.executeQuery(sql);
			
			list = new ArrayList<Pmap>();
			
			while(rset.next()) {
				
				Pmap p = new Pmap();
				
				p.setEmp_code(rset.getString("emp_code"));
				p.setEmp_name(rset.getString("emp_name"));
				p.setEmail(rset.getString("email"));
				p.setJob_code(rset.getString("job_code"));
				p.setDept_code(rset.getString("dept_code"));
				
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

}
