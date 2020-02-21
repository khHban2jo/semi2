package com.coo.notice.service;

import java.util.ArrayList;
import java.sql.Connection;
import java.util.ArrayList;
import static com.coo.common.JDBCTemplate.*;

import com.coo.notice.model.dao.noticeDao;
import com.coo.notice.model.vo.Notice;

public class NoticeService {

	// 전체 검색
	public int getListCount(ArrayList<String> Datelist) {

		Connection con = getConnection();

//		System.out.println("1-2");
//		System.out.println("arraylist : "+ Datelist.toString());
		int listCount = new noticeDao().getListCount(con, Datelist);

		close(con);

		return listCount;
	}
	
	
	// 전체 검색을 통한 데이터를 가져오는 코드
	public ArrayList<Notice> selectList(int currentPage, int limit, ArrayList<String> Datelist) {

		Connection con = getConnection();

//		System.out.println("2-2");
		ArrayList<Notice> list = new noticeDao().selectList(con, currentPage, limit, Datelist);

		close(con);

		return list;
	}
	
	// 데이터 삽입
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

//		System.out.println("Notice : " + n.toString());

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

	// 검색을 위한 전체 페이지 가져 오는기 위한 db연결
	public int getListCount(String search, String keyword, ArrayList<String> Datelist) {
		Connection con = getConnection();

		int listCount = new noticeDao().getListCount(con, search, keyword, Datelist);

		close(con);

		return listCount;
	}

	// 검색을 통한 공지 사항을 가져 오기 위한 코드
	public ArrayList<Notice> selectList(int currentPage, int limit, String search, String keyword, ArrayList<String> Datelist) {
		Connection con = getConnection();

		ArrayList<Notice> list = new noticeDao().selectList(con, currentPage, limit, search, keyword, Datelist);

		close(con);

		return list;
	}


	public ArrayList<Notice> noticeAjax() {
		Connection con = getConnection();

		ArrayList<Notice> list = new noticeDao().noticeAjax(con);

		close(con);

		return list;
	}


}
