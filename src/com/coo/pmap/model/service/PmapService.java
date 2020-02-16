package com.coo.pmap.model.service;

import static com.coo.common.JDBCTemplate.close;
import static com.coo.common.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;

import com.coo.member.model.vo.Member;
import com.coo.pmap.model.Dao.PmapDao;

import javafx.scene.control.Alert;
public class PmapService {

	private PmapDao pDao = new PmapDao();
	
	/**
	 * 전체 조회
	 * @return
	 */
	public ArrayList<Member> selectList(int currentPage, int limit) {
		
		Connection con = getConnection();
		
		ArrayList<Member> list = pDao.selectList(con,currentPage,limit);
		
		close(con);
		
		return list;
	}

	/**
	 * 총 게시글 수
	 * @return
	 */
	public int getListCount() {
		
		Connection con = getConnection();
		
		int listCount = pDao.getListCount(con);
		
		close(con);
		
		return listCount;
	}

	public ArrayList<Member> searchPmap(String category, String keyword) {
		
		Connection con = getConnection();
		
		ArrayList<Member> list = null;
		
		String page = "";
		
		if(category.length() > 0) {
			list = pDao.searchPmap(con,category,keyword);
		}else {
			page = "views/popup/Peoplemap.jsp";
		}
		
		return list;
	}

}
