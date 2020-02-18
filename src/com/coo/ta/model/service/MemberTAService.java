package com.coo.ta.model.service;

import java.sql.Connection;

import com.coo.ta.model.dao.MemberTADAO;

import static com.coo.common.JDBCTemplate.*;

public class MemberTAService {
	
	private MemberTADAO mtaDao = new MemberTADAO();
	
	/**
	 * 회원 가입 시
	 * TA_DATA / LEAVE_COUNT 테이블에 정보 생성하기
	 * @param empId
	 * @param l1Value
	 */
	public void memberTaDataInsert(String empId, int l1Value) {
		
		Connection con = getConnection();
		
		//	empId로 empCode 가져오기
		int empCode = mtaDao.selectEmpCode(con, empId);
//		System.out.println("select한 empCode : " + empCode);
		
		//	TADATA에 insert 하기
		int result = mtaDao.insertMemberTA(con, empCode);
//		System.out.println("TADATA INSERT result : " + result);
		
		if(result>0) {
			//	LEAVE_COUNT에 insert 하기
			result = mtaDao.insertMemberLeave(con, empCode, l1Value);
//			System.out.println("LEAVE_COUNT INSERT result" + result);
		}
		
		if(result>0) commit(con);
		else rollback(con);
	}
}
