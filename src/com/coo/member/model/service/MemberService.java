package com.coo.member.model.service;

import com.coo.check.model.vo.StockLine;
import com.coo.exception.CooException;
import com.coo.member.model.dao.MemberDao;
import com.coo.member.model.vo.Member;
import java.sql.Connection;
import static com.coo.common.JDBCTemplate.*;

public class MemberService {
	
	private MemberDao mDao = new MemberDao();
	
	public Member selectMember(Member m) throws CooException {
		
		Connection con = getConnection();
		
		Member result = mDao.selectMember(m,con);
		
		close(con);

		if(result == null) {
			throw new CooException("에러");
		}
		
		return result;
	}

	public int checkEmp() {
		Connection con = getConnection();
		
		int result = 0;
		try {
			result = mDao.checkEmp(con);
		} catch (CooException e) {
			e.getMessage();
		}
		
		close(con);
		
		return result;
	}

	public int idDupChk(String id) {
		Connection con = getConnection();
		int result = -1;
		try {
			result = mDao.idDupChk(con,id);
		} catch (CooException e) {
			e.getMessage();
		}
		
		return result;
	}
	
	public int insertMember(Member m) throws CooException{
		Connection con = getConnection();
		int result=0;
	
		result = mDao.insertMember(con,m);
		
		System.out.println("result : " + result);
		if(result>0) commit(con); else rollback(con);
		close(con);
		
		return result;
		
		
	}
	
	public int updateMember(Member m) {
		
		Connection con = getConnection();
		
		int result = 0;
		try {
			result = mDao.updateMember(con,m);
		} catch (CooException e) {

		}
		
		if(result>0) commit(con);
		else rollback(con);
		
		close(con);
		
		return result;
		
	}
	
	public int deleteMember(String empId) throws CooException {

	Connection con = getConnection();
	int result= mDao.deleteMember(con,empId);
	if(result>0) commit(con);
	else rollback(con);
	close(con);
	return result;
	
	}
	
	public Member searchMember(String empId) {
		
		Connection con = getConnection();
		
		Member m = null;
		try {
			m = mDao.searchMember(empId, con);
		
		} catch (CooException e) {
			e.getMessage();
		}
		
		close(con);
		
		return m;
	}

	public int insertStockLine(StockLine d) {
		Connection con = getConnection();
		
		int result = 0;
		
		try {
			result = mDao.insertStockLine(d,con);
			
			if(result>0) commit(con); else rollback(con);
			
		} catch (CooException e) {
			e.getMessage();
		}
		
		return result;
	}

	public int searchEmpCode(int empCode) {
		Connection con = getConnection();
		
		int result = 0;
		
		try {
			result = mDao.searchEmpCode(con,empCode);
		} catch (CooException e) {
			e.getMessage();
		}
		
		return result;
	}

}
