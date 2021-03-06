package com.coo.check.model.service;

import static com.coo.common.JDBCTemplate.close;
import static com.coo.common.JDBCTemplate.commit;
import static com.coo.common.JDBCTemplate.getConnection;
import static com.coo.common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import com.coo.check.model.dao.CheckDao;
import com.coo.check.model.vo.CheckDoc;
import com.coo.check.model.vo.PayDoc;
import com.coo.check.model.vo.PmapMember;
import com.coo.check.model.vo.RoundDoc;
import com.coo.check.model.vo.StockLine;
import com.coo.check.model.vo.Vacation;

public class CheckService {
	private CheckDao cDao = new CheckDao();

	/**
	 * 버튼 찾기 카운트
	 * @param id
	 * @param status
	 * @return
	 */
	public int getListCount(int id,int status) {
		Connection con = getConnection();
		
		int listCount = cDao.getListCount(con, id, status);
		close(con);
		return listCount;
	}

	/**
	 * 버튼찾기 게시글
	 * @param currentPage
	 * @param limitPage
	 * @param id
	 * @param status
	 * @return
	 */
	public ArrayList<CheckDoc> getList(int currentPage, int limitPage,int id, int status) {
		Connection con = getConnection();

		ArrayList<CheckDoc> docs= cDao.getList(con, currentPage, limitPage, id, status);
		

		close(con);
		
		return docs;
	}
	
	
	
	/**
	 * 키워드 찾기 카운트
	 * @param id
	 * @param search
	 * @param keyword
	 * @return
	 */
	public int getSearchListCount(int id, int search, String keyword) {
		Connection con = getConnection();
		
		int listCount = cDao.getListSearchCount(con, id, search, keyword);
		close(con);
		return listCount;
	}
	
	/**
	 * 키워드 찾기 게시글
	 * @param id
	 * @param search
	 * @param keyword
	 * @param limitPage 
	 * @param currentPage 
	 * @return
	 */
	public ArrayList<CheckDoc> getSearchList(
			int id, int search, String keyword, int currentPage, int limitPage){
		
		Connection con = getConnection();
		ArrayList<CheckDoc> docs = cDao.getSearchList(
				con,id,search,keyword, currentPage, limitPage);
			
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
		close(con);
		return doc;
	}

	/**
	 * 휴가 신청서
	 * @param dn
	 * @return
	 */
	public Vacation getVacD(int dn) {
		Connection con = getConnection();
		Vacation doc = cDao.getVacD(con, dn);
		close(con);
		return doc;
	}
	
	/**
	 * 파일 찾아오기
	 * @param docnumber
	 * @return
	 */
	public ArrayList<String> getFiles(int docnumber) {
		Connection con = getConnection();
		ArrayList<String> files = cDao.getFiles(con, docnumber);
		close(con);
		
		return files;
	}




	public int insertDoc(CheckDoc info, RoundDoc doc, ArrayList<String> files) {
		int result = 0;

		Connection con = getConnection();

		
		result = cDao.insertInfo(con, info);
		if(result >0) {
			//System.out.println(info.getDocType());
				result = cDao.insertText(con, doc, info.getDocType());
				if(result>0) {
					if(!files.isEmpty() ) {
					result = cDao.insertfile(con, files);
					}
					if(result >0) 	commit(con);
					else rollback(con);
				}else { 
					System.out.println("업데이트 에러");
				}
			}else {
			System.out.println("인포저장에러");
		}
		//2 체크독 번호 가져오기(int값으로)
		//3 독 넣기
		close(con);
		return result;
	}
	
	

	/**
	 * 자신이 결재중인 것 갯수
	 * @param id
	 * @return
	 */
	public int getMyCount(int id) {
		Connection con = getConnection();
		
		
		int result = cDao.getMyCount(con, id);
		
		close(con);
		
		return result;
	}

	/**
	 * 조직도 부서 가져오기
	 * @param st 
	 * @return
	 */
	public ArrayList<String> getDcnList(int st) {
		Connection con = getConnection();
		
		ArrayList<String> dcnlist = cDao.getDcnList(con, st);
		
		if(dcnlist == null) {
			//에러 처리용
			System.out.println("dcn null");
		}
		close(con);
		return dcnlist;
	}

	public ArrayList<PmapMember> getPmapList() {
		Connection con = getConnection();
		
		ArrayList<PmapMember> pmaplist = cDao.getPmapList(con);
		if(pmaplist == null) {
			//에러 처리용
			System.out.println("dcn null");
		}
		close(con);
		return pmaplist;
	}

	
	/**
	 * 결제라인 가져오기
	 * @param empcode
	 * @return
	 */
	public ArrayList<StockLine> getStocklist(int empcode) {
		Connection con = getConnection();
		
		ArrayList<StockLine> line = cDao.getStocklist(con,empcode);
	
		close(con);
		return line;
	}

	/**
	 * 결제라인 저장
	 * @param empcode
	 * @param deptcode
	 * @param number
	 * @param table
	 * @return
	 */
	public int saveStockline(int empcode, String deptcode, int number, String table) {
		Connection con = getConnection();
		int result = cDao.saveStockline(con, empcode, deptcode, number, table);
			
		if(result>0) commit(con);
		else rollback(con);
		
		close(con);
		return result;
	}

	/**
	 * 정/부,부서코드 
	 * @param pcode
	 * @param dename
	 * @return
	 */
	public ArrayList<StockLine> getMassub(ArrayList<Integer> pcode, ArrayList<String> dename) {
		Connection con = getConnection();
		
		ArrayList<StockLine> masub = cDao.getMassub(con, pcode, dename);

		close(con);
		return masub;
	}

	public ArrayList<String> getMSName(ArrayList<Integer> savePcodes) {
		Connection con = getConnection();
		
		ArrayList<String> names = cDao.getMSName(con, savePcodes);
			
		close(con);
		return names;
	}

	public ArrayList<StockLine> getDeptTN(ArrayList<Integer> savePcodes) {
		Connection con = getConnection();
		ArrayList<StockLine> list = cDao.getDeptTN(con, savePcodes);
		close(con);
		return list;
	}

	/**
	 * 진행상황 업데이트(진행/완료/반려)
	 * @param info
	 * @return
	 */
	public int updateInfo(CheckDoc info) {
		Connection con = getConnection();
		
		int result = cDao.updateInfo(con, info);
		if(result>0) commit(con);
		else rollback(con);
		close(con);
		
		return result;
	}

	/**
	 * 정 결재자 상태 확인
	 * @param mascode
	 * @return
	 */
	public boolean getMasStauts(int mascode) {
		Connection con = getConnection();
		
		boolean masStatus = cDao.getMasStauts(con,  mascode);
		close(con);
		return masStatus;
	}




}