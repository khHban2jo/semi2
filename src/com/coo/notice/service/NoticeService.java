package com.coo.notice.service;

import java.util.ArrayList;
import java.sql.Connection;
import java.util.ArrayList;
import static com.coo.common.JDBCTemplate.*;

import com.coo.notice.model.dao.noticeDao;
import com.coo.notice.model.vo.Notice;

public class NoticeService {

	public int getListCount() {

		Connection con = getConnection();

		System.out.println("1-2");
		int listCount = new noticeDao().getListCount(con);

		close(con);

		return listCount;
	}

	public ArrayList<Notice> selectList(int currentPage, int limit) {

		Connection con = getConnection();

		System.out.println("2-2");
		ArrayList<Notice> list = new noticeDao().selectList(con, currentPage, limit);

		close(con);

		return list;
	}

	public int insertNotice(Notice n) {

		Connection con = getConnection();

		int result = new noticeDao().insertNotice(con, n);

		if (result >= 1) {
			commit(con);
		} else {
			rollback(con);
		}

		return result;
	}

	public Notice selectOne(int nno) {

		Connection con = getConnection();

		Notice n = new noticeDao().selectOne(con, nno);

		System.out.println("Notice : " + n.toString());

		if (n != null)
			commit(con);
		else
			rollback(con);

		close(con);

		return n;

	}

	// 정보 변경
	public int UpdatetNotice(Notice n) {
		
		Connection con = getConnection();
		
		int result = new noticeDao().updateNotice(con, n);
		
		if(result > 0) 
			commit(con);
		else 
			rollback(con);
		
		close(con);
		
		return result;
		
	}

	// 삭제
	public int DeleteUpdate(int nno) {
		
		Connection con = getConnection();
		
		int result = new noticeDao().DeleteUpdate(con, nno);
		
		if(result > 0) 
			commit(con);
		else 
			rollback(con);
		
		close(con);
		
		return result;
	}

}
