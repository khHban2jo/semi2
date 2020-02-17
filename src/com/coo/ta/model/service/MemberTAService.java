package com.coo.ta.model.service;

import java.sql.Connection;

import com.coo.ta.model.dao.MemberTADAO;

import static com.coo.common.JDBCTemplate.*;

public class MemberTAService {
	
	private MemberTADAO mtaDao = new MemberTADAO();
	
	public void memberTaDataInsert(String empId) {
		
		Connection con = getConnection();
		
		//	empId로 empCode 가져오기
		int empCode = mtaDao.selectEmpCode(con, empId);
		
		//	TADATA에 insert 하기
		int result = mtaDao.insertMemberTA(con, empCode);
		
		if(result>0) {
			//	LEAVE_COUNT에 insert 하기
			result = mtaDao.insertMemberLeave(con, empCode);
		}
		
		if(result>0) commit(con);
		else rollback(con);
	}
}
