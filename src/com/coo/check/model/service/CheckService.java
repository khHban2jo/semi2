package com.coo.check.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.coo.check.model.dao.CheckDao;
import com.coo.check.model.vo.CheckDoc;
import com.coo.check.model.vo.PayDoc;
import com.coo.check.model.vo.RoundDoc;
import com.coo.check.model.vo.Vacation;

import static com.coo.common.JDBCTemplate.*;

public class CheckService {
	private CheckDao cDao = new CheckDao();

	public int getListCount(String id,int status) {
		Connection con = getConnection();
		
		int listCount = cDao.getListCount(con, id, status);

		close(con);
		return listCount;
	}

	public ArrayList<CheckDoc> getList(int currentPage, int limitPage,String id, int status) {
		Connection con = getConnection();

		ArrayList<CheckDoc> docs= cDao.getList(con, currentPage, limitPage, id, status);

		close(con);
		
		return docs;
	}

	/**
	 * 문서 1개의 상세 정보 출력
	 * @param docnumber
	 * @return
	 */
	public CheckDoc getDocInfo(int docnumber) {
		Connection con = getConnection();
		
		CheckDoc info = cDao.getDocInfo(con, docnumber);
		close(con);
		return info;
	}

	/**
	 * 품의서 가져오기
	 * @param dn
	 * @return
	 */
	public RoundDoc getRoundD(int dn) {
		Connection con = getConnection();
		RoundDoc rd = cDao.getRoundD(con, dn);
		close(con);
		return rd;
	}

	/**
	 * 결재 내역서 
	 * @param dn
	 * @return
	 */
	public PayDoc getPayD(int dn) {
		Connection con = getConnection();
		PayDoc doc = cDao.getPayD(con, dn);
		return doc;
	}

	/**
	 * 휴가 신청서
	 * @param dn
	 * @return
	 */
	public Vacation getVacD(int dn) {
		Connection con = getConnection();
		
		return null;
	}

	public int insertDoc(CheckDoc info, RoundDoc doc) {
		int result = 0;
		int docNum = 0;
		Connection con = getConnection();

		
		result = cDao.insertInfo(con, info);
		if(result >0) {
			docNum = cDao.getDocNum(con,info.getaWriter());
			System.out.println(result);
			if(docNum > 0) {
				doc.setDocNumber(docNum);
				System.out.println(docNum);
				result = cDao.insertText(con, doc, info.getDocType());
				System.out.println(result);
				if(result>0) commit(con);
				else rollback(con);
			}else {
				//에러로 쓰로우
				System.out.println("번호 가져오는데 에러");
			}
		}else {
			System.out.println("인포저장에러");
		}
		//2 체크독 번호 가져오기(int값으로)
		//3 독 넣기
		close(con);
		return result;
	}



}