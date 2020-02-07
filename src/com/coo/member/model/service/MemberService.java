package com.coo.member.model.service;

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
		
		String val = result.getJobCode();
		
		switch(val) {
			case "J1":
			case "J2":
			case "J3":
			case "J4":
			case "J5":
			case "J6":
			case "J7": result.setJobCode("관리자"); break;
		}
		
		return result;
	}

}
