package com.coo.check.model.dao;

import static com.coo.common.JDBCTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

import com.coo.check.model.vo.CheckDoc;
import com.coo.check.model.vo.PayDoc;
import com.coo.check.model.vo.PmapMember;
import com.coo.check.model.vo.RoundDoc;
import com.coo.check.model.vo.StockLine;
import com.coo.check.model.vo.Vacation;
import com.sun.xml.internal.bind.v2.runtime.output.StAXExStreamWriterOutput;

public class CheckDao {
	
	private Properties prop;
	public CheckDao() {
		prop = new Properties();
		String sqlPath = CheckDao.class.getResource("/config/check-query.properties").getPath();
		
		try {
			prop.load(new FileReader(sqlPath));
		}catch(IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 테이블의 삭제되지 않은 것 총 수 가져오기
	 * 4일때 전부 2,3 일때 완료/반려  /0 진행
	 * @param con
	 * @return
	 */
	public int getListCount(Connection con, int id, int status) {
		int result =0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql="";
		if(status == 0) {
			sql= prop.getProperty("checkCount");
		}else if(status == 1){
			sql =prop.getProperty("checkflowCount");
		}else if(status == 4){
			sql = prop.getProperty("mydocCount");
			
		}else if(status == 2||status==3){
			sql =prop.getProperty("checkendCount");
		}else {
			sql =prop.getProperty("checkwriterCount");
		}
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			if(status <4) {
				pstmt.setInt(2, id);
				pstmt.setInt(3, id);
				pstmt.setInt(4, id);
			
				if(status == 2 || status ==3) {
					pstmt.setInt(5, status);
				}
			}
			
			
			rset= pstmt.executeQuery();
			
			if(rset.next()) {
				result = rset.getInt(1);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rset);
		}
		
		
		return result;
	}

	/**
	 * 페이징시 가져올 테이블
	 * @param con
	 * @param currentPage
	 * @param limitPage
	 * @param id
	 * @param status 
	 * @return
	 */
	public ArrayList<CheckDoc> getList(Connection con, int currentPage, int limitPage, int id, int status) {
		ArrayList<CheckDoc> docs= null;

		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql ="";
		if(status == 0) {
		sql = prop.getProperty("selectDocList");
		}else if(status == 1){
			sql = prop.getProperty("selectSelectFlowList");
		}else if(status==4){
			sql = prop.getProperty("selectMydoc");
			
		}else if(status==2||status==3){
			sql = prop.getProperty("selectSelectEndList");
		}else {
			sql = prop.getProperty("checkwriterList");
		}
		try {
			
			
			//페이징 눌렀을 때 시작 로우넘  계산 
			int startRow = (currentPage -1)*limitPage+1; //1,11,21
			
			//마지막 로우넘 번호 계산
			int endRow = startRow + limitPage -1; //10,20,30
			
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			if(status <4) {
				pstmt.setInt(2, id);
				pstmt.setInt(3, id);
				pstmt.setInt(4, id);
				int i = 5;
					if(status == 2|| status ==3) {
						pstmt.setInt(i, status);
						i++;
			}
				pstmt.setInt(i, endRow);
				pstmt.setInt(i+1, startRow);
			}else {
				pstmt.setInt(2, endRow);
				pstmt.setInt(3, startRow);
			}
			
			rset=pstmt.executeQuery();
			
			
			docs = new ArrayList<CheckDoc>();
			
			while(rset.next()) {
				CheckDoc cd = new CheckDoc();
				cd.setDocNumber(rset.getInt("DOC_NUMBER"));
				cd.setaTitle(rset.getString("ATITLE"));
				cd.setaWriter(rset.getInt("AWRITER"));
				cd.setAwriterName(rset.getString("AWRITERNAME"));
				cd.setDocType(rset.getString("DOC_TYPE"));
				cd.setaStatus(rset.getInt("ASTATUS"));
				cd.setApprover(rset.getString("APPROVER"));
				cd.setDeptName(rset.getString("DEPT_TITLE"));
				cd.setIndept(rset.getString("IN_DEPTNAME"));
				cd.setInPeople(rset.getString("INPEOPLE"));
				cd.setInStatus(rset.getString("INSTATUS"));
				cd.setColdeptName(rset.getString("COL_DEPTNAME"));
				cd.setColPeople(rset.getString("COL_PEOPLE"));
				cd.setColStatus(rset.getString("COL_STATUS"));
				cd.setViewPeople(rset.getString("VIEW_PEOPLE"));
				cd.setDocDate(rset.getDate("DOC_DATE"));
				cd.setReturnComment(rset.getString("RETURNCOMMENT"));

				
				docs.add(cd);
			}

			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return docs;
	}
	
	

	/**
	 * 찾기 줄수 
	 * @param con
	 * @param id
	 * @param search
	 * @param keyword
	 * @return
	 */
	public int getListSearchCount(Connection con, int id, int search, String keyword) {
		int result = 0;
		PreparedStatement pstmt  = null;
		ResultSet rset = null;
		
		String sql = null;
		if(search ==1) {// 타이틀
			sql= prop.getProperty("selectTtileCount");
		}else {//기안자
			sql= prop.getProperty("selectWriterCount");
		}
			
		try {
		
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,id);
			pstmt.setInt(2,id);
			pstmt.setInt(3,id);
			if(search ==1) {
				pstmt.setInt(4,id);
				pstmt.setString(5, keyword);
			}else {
				pstmt.setString(4,keyword);
			}
			
			
			
			rset = pstmt.executeQuery();
			if(rset.next()) {
				result = rset.getInt(1);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return result;
	}
	
	public ArrayList<CheckDoc> getSearchList(Connection con, int id, int search, String keyword, int currentPage, int limitPage) {
		ArrayList<CheckDoc> docs = null;
		PreparedStatement pstmt = null;
		ResultSet rset= null;
		String sql= null;
				if(search ==1) {// 타이틀
					sql= prop.getProperty("selectTitle");
				}else {//기안자
					sql= prop.getProperty("selectWriter");
				}
				
				
		try {
			//페이징 눌렀을 때 시작 로우넘  계산 
			int startRow = (currentPage -1)*limitPage+1; //1,11,21
			
			//마지막 로우넘 번호 계산
			int endRow = startRow + limitPage -1; //10,20,30
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,id);
			pstmt.setInt(2,id);
			pstmt.setInt(3,id);
			
			int i;
			if(search ==1) {
				pstmt.setInt(4,id);
				pstmt.setString(5, keyword);
				i = 6;
			}else {
				pstmt.setString(4,keyword);
				i=5;
			}
				
				pstmt.setInt(i,endRow);
				pstmt.setInt(i+1, startRow);
		
			
			rset = pstmt.executeQuery();
			docs = new ArrayList<CheckDoc>();
			while(rset.next()) {
				CheckDoc cd = new CheckDoc();
				cd.setDocNumber(rset.getInt("DOC_NUMBER"));
				cd.setaTitle(rset.getString("ATITLE"));
				cd.setaWriter(rset.getInt("AWRITER"));
				cd.setAwriterName(rset.getString("AWRITERNAME"));
				cd.setDocType(rset.getString("DOC_TYPE"));
				cd.setaStatus(rset.getInt("ASTATUS"));
				cd.setApprover(rset.getString("APPROVER"));
				cd.setDeptName(rset.getString("DEPT_TITLE"));
				cd.setIndept(rset.getString("IN_DEPTNAME"));
				cd.setInPeople(rset.getString("INPEOPLE"));
				cd.setInStatus(rset.getString("INSTATUS"));
				cd.setColdeptName(rset.getString("COL_DEPTNAME"));
				cd.setColPeople(rset.getString("COL_PEOPLE"));
				cd.setColStatus(rset.getString("COL_STATUS"));
				cd.setViewPeople(rset.getString("VIEW_PEOPLE"));
				cd.setDocDate(rset.getDate("DOC_DATE"));
				cd.setReturnComment(rset.getString("RETURNCOMMENT"));

				
				docs.add(cd);
			}
			
		}catch(SQLException e){
			e.printStackTrace();
		}
		return docs;
	}


	/**
	 * 해당 문서의 결재자 등 정보 가져오기
	 * @param con
	 * @param docnumber
	 * @return
	 */
	public CheckDoc getDocInfo(Connection con, int docnumber) {
		CheckDoc info = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("docInfo");
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, docnumber);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				info = new CheckDoc();
				info.setDocNumber(rset.getInt("DOC_NUMBER"));
				info.setaTitle(rset.getString("ATITLE"));
				info.setaWriter(rset.getInt("AWRITER"));
				info.setAwriterName(rset.getString("AWRITERNAME"));
				info.setJobName(rset.getString("JOB_NAME"));
				info.setDocType(rset.getString("DOC_TYPE"));
				info.setaStatus(rset.getInt("ASTATUS"));
				info.setApprover(rset.getString("APPROVER"));
				info.setDeptName(rset.getString("DEPT_TITLE"));
				info.setIndept(rset.getString("IN_DEPTNAME"));
				info.setInPeople(rset.getString("INPEOPLE"));
				info.setInStatus(rset.getString("INSTATUS"));
				info.setColdeptName(rset.getString("COL_DEPTNAME"));
				info.setColPeople(rset.getString("COL_PEOPLE"));
				info.setColStatus(rset.getString("COL_STATUS"));
				info.setViewPeople(rset.getString("VIEW_PEOPLE"));
				info.setDocDate(rset.getDate("DOC_DATE"));
				info.setDeleteyn(rset.getString("DELETE_YN"));
				info.setReturnComment(rset.getString("RETURNCOMMENT"));
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return info;
	}

	/**
	 * 품의서 내용
	 * @param dn
	 * @return
	 */
	public RoundDoc getRoundD(Connection con, int dn) {
		RoundDoc doc = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectRound");
		//System.out.println(dn);
		
		try {
			pstmt = con.prepareStatement(sql);
			//System.out.println(sql);
			pstmt.setInt(1, dn);
			rset = pstmt.executeQuery();
			doc = new RoundDoc();
			if(rset.next()) {
				doc.setDocNumber(dn);
				doc.setText(rset.getString("TCONTENT"));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return doc;
	}
	/**
	 * 결재서 내용
	 * @param con
	 * @param dn
	 * @return
	 */

	public PayDoc getPayD(Connection con, int dn) {
		PayDoc doc = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectPay");
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dn);
			rset = pstmt.executeQuery();
			doc = new PayDoc();
			if(rset.next()) {
				doc.setDocNumber(dn);
				doc.setText(rset.getString("TCONTENT"));
				doc.setEndPay(rset.getInt("PAID"));
			}
			
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return doc;
	}
	/**
	 * 휴가신청서 내용
	 * @param con
	 * @param dn
	 * @return
	 */
	public Vacation getVacD(Connection con, int dn) {
		Vacation doc = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectVacation");
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dn);
			rset = pstmt.executeQuery();
			doc = new Vacation();
			if(rset.next()) {
				doc.setDocNumber(dn);
				doc.setText(rset.getString("TCONTENT"));
				doc.setLeave_code(rset.getString("LEAVE_CODE"));
				doc.setStart_Date(rset.getDate("START_DATE"));
				doc.setEnd_Date(rset.getDate("END_DATE"));
				doc.setDayOff_MA(rset.getString("DAYOFF_MA"));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return doc;
	}
	
	
	/**
	 * 파일 정보 가져오기
	 * @param con
	 * @param docnumber
	 * @return
	 */
	public ArrayList<String> getFiles(Connection con, int docnumber) {
		ArrayList<String> files = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("findfile");
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, docnumber);
			rset = pstmt.executeQuery();
			files = new ArrayList<String>();
			while(rset.next()) {
				files.add(rset.getString("DOC_FILES"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return files;
	}

	/**
	 * 문서 결재 정보 저장
	 * @param con
	 * @param info
	 * @return
	 */
	public int insertInfo(Connection con, CheckDoc info) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertDoc");
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,info.getaTitle() );
			pstmt.setInt(2,info.getaWriter());
			pstmt.setString(3,info.getAwriterName());
			pstmt.setString(4, info.getDeptName());
			pstmt.setString(5,info.getDocType());
			pstmt.setString(6,info.getApprover());
			
			
			pstmt.setString(7, info.getIndept());
			pstmt.setString(8,info.getInPeople());
			pstmt.setString(9,info.getInStatus());
			if(info.getColdeptName()!= null ){ 
				pstmt.setString(10,info.getColdeptName());
				pstmt.setString(11,info.getColPeople());
				pstmt.setString(12,info.getColStatus());
				
			}else {
			pstmt.setNull(10,java.sql.Types.NULL); //sql의 null 설정
			pstmt.setNull(11,java.sql.Types.NULL);
			pstmt.setNull(12,java.sql.Types.NULL);
			}
			
		 
			if(info.getViewPeople()!=null) {
				pstmt.setString(13,info.getViewPeople());
			
			}else {
				pstmt.setNull(13,java.sql.Types.NULL);
			}
			result =pstmt.executeUpdate();
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		
		return result;
	}


	/**
	 * 문서 내용저장
	 * @param con
	 * @param doc
	 * @param docType
	 * @return
	 */
	public int insertText(Connection con, RoundDoc doc, String docType) {
		int result = 0;
		RoundDoc docText= null;
		PreparedStatement pstmt = null;
		String sql= "";
		
		if(docType.equals("품의서")) {
			sql = prop.getProperty("insertRoundDoc");
		}else if(docType.equals("지출결의서")) {
			sql = prop.getProperty("insertPayDoc");
			
		}else {
			sql=prop.getProperty("insertVacDoc");
		}
		try {
			//System.out.println(sql);
			docText = doc;
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,doc.getText());
		if(docType.equals("지출결의서")) {
			pstmt.setInt(2, ((PayDoc)doc).getEndPay());
			 
			}else if(docType.equals("휴가신청서")) {
				sql=prop.getProperty("insertVacDoc");
				
				
				pstmt.setString(2,((Vacation)doc).getLeave_code());
				pstmt.setDate(3,((Vacation)doc).getStart_Date());
				pstmt.setDate(4,((Vacation)doc).getEnd_Date());
				pstmt.setString(5,((Vacation)doc).getDayOff_MA());

			}
			result=pstmt.executeUpdate();
			
			
		}catch(SQLException e) {
			e.printStackTrace();
			
		}finally {
			close(pstmt);
		}

		return result;
	}
	
	public int insertfile(Connection con,  ArrayList<String> files) {
		int result = 0;
		
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertFile");
		System.out.println(files.size());

		
		try {
			pstmt = con.prepareStatement(sql);
			for(int i = 0; i<files.size(); i++) {
			pstmt.setString(1, files.get(i));
			
			
			result=pstmt.executeUpdate();
			
			}
		}catch(SQLException e) {
			e.printStackTrace();
			
		}finally {
			close(pstmt);
		}

		return result;
	}
	
	

	/**
	 * 
	 * 결재 해야될 카운트 가져오기
	 * @param con
	 * @param id
	 * @return
	 */
	public int getMyCount(Connection con, int id) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int result = -1;
		String sql = prop.getProperty("mydocCount");
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				result = rset.getInt(1);
			}
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return result;
	}

	/**
	 * 조직도용 부서코드, 부서명 가져오기
	 * @param con
	 * @param st 
	 * @return
	 */
	public ArrayList<String> getDcnList(Connection con, int st) {
		ArrayList<String> dcnlist= null;
		Statement stmt = null;
		ResultSet rset = null;
		String sql ="";
		 if(st== 0) {
			sql = prop.getProperty("selectDN");
		 }else if(st == 1) {
			sql= prop.getProperty("selectDC");
		 }
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(sql);
			dcnlist = new ArrayList<String>();
			while(rset.next()) {
				String dcode = 	(rset.getString(1));

				
				dcnlist.add(dcode);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();	
		}finally {
			close(rset);
			close(stmt);
		}
		
		
		return dcnlist;
		
	}

	/**
	 * 조직도용 멤버 가져오기
	 * @param con
	 * @return
	 */
	public ArrayList<PmapMember> getPmapList(Connection con) {
		ArrayList<PmapMember> pmaplist =null;
		Statement stmt = null;
		ResultSet rset = null;
		String sql= prop.getProperty("selectMapmember");
		
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(sql);
			pmaplist = new ArrayList<PmapMember>();
			while(rset.next()) {
				PmapMember pm = new PmapMember();
				pm.setEmpCode(rset.getInt("EMP_CODE"));
				pm.setEmpName(rset.getString("EMP_NAME"));
				pm.setDeptCode(rset.getString("DEPT_CODE"));
				pm.setDeptName(rset.getString("DEPT_TITLE"));
				pm.setJob(rset.getString("JOB_NAME"));
				
				pmaplist.add(pm);
				
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(stmt);
		}
		
		return pmaplist;
	}

	/**
	 * 저장된 결제라인 가져오기
	 * @param con
	 * @param empcode
	 * @return
	 */
	public ArrayList<StockLine> getStocklist(Connection con, int empcode) {
		ArrayList<StockLine> line = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql= prop.getProperty("getStockline");
		try {
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, empcode);
			
			rset = pstmt.executeQuery();
			line = new ArrayList<StockLine>();
			while(rset.next()) {
				StockLine sl = new StockLine();
				sl.setEmpcode(empcode);
				sl.setDeptCode(rset.getString("DEPT_CODE"));
				sl.setDeptName(rset.getString("DEPT_TITLE"));
				sl.setList1(rset.getString("LINE1"));
				sl.setList2(rset.getString("LINE2"));
				sl.setList3(rset.getString("LINE3"));
				
				
				line.add(sl);
			}
			if(!line.isEmpty()) {
			
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return line;
	}

	/**
	 * 결제라인 저장하기
	 * @param con
	 * @param empcode
	 * @param deptcode
	 * @param number
	 * @param table
	 * @return
	 */
	public int saveStockline(Connection con, int empcode, String deptcode, int number, String table) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql =prop.getProperty("saveline" + number);


		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,table);
			pstmt.setInt(2, empcode);
			pstmt.setString(3, deptcode);
			
			result = pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}
	

	/**
	 * 정부 부서코드 가져오기
	 * @param con
	 * @param pcode
	 * @param dename
	 * @return
	 */
	public ArrayList<StockLine> getMassub(Connection con, ArrayList<Integer> pcode, ArrayList<String> dename) {
		ArrayList<StockLine> masub = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql= prop.getProperty("getMassubcode");// dept code, id 조인
		
		try {
			
			masub = new ArrayList<StockLine>();
			pstmt = con.prepareStatement(sql);
			for(int i = 0; i<pcode.size(); i++) {
				
				int j = Integer.valueOf(pcode.get(i));
			 pstmt.setInt(1, j);
			 pstmt.setString(2,dename.get(i));
			 rset = pstmt.executeQuery();
			 if(rset.next()) {
				 StockLine save = new StockLine();
				 save.setEmpcode(rset.getInt("EMP_CODE"));
				 save.setSubcode(rset.getInt("SUB_CODE"));
				 save.setDeptCode(rset.getString("DEPT_CODE"));
				 save.setDeptName(dename.get(i));
				 masub.add(save);
				 
			 	}	
				
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		
		return masub;
	}

	/**
	 * 정/부 이름 가져오기
	 * @param con
	 * @param savePcodes
	 * @return
	 */
	public ArrayList<String> getMSName(Connection con, ArrayList<Integer> savePcodes) {
		ArrayList<String> names = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getEmpName");// dept code, id 조인
		
		try {
			
			names = new ArrayList<String>();
			pstmt = con.prepareStatement(sql);
			for(int i = 0; i<savePcodes.size(); i++) {
				int j = savePcodes.get(i);
				 pstmt.setInt(1, j);
				 rset = pstmt.executeQuery();
				if(savePcodes.get(i)==0) {
					names.add("없음");
				}
			
			 if(rset.next()) {
				 names.add(rset.getString("EMP_NAME"));
				
			 	}	
				
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		
		return names;
	}

	/**
	 * 참조인원 부서 이름 가져오기
	 * @param con
	 * @param savePcodes
	 * @return
	 */
	public ArrayList<StockLine> getDeptTN(Connection con, ArrayList<Integer> savePcodes) {
		ArrayList<StockLine> tn= null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getEmpNDt");
		
		try {
			
			tn = new ArrayList<StockLine>();
			pstmt = con.prepareStatement(sql);
			for(int i = 0; i<savePcodes.size(); i++) {
				
				int j = savePcodes.get(i);
			 pstmt.setInt(1, j);
			 rset = pstmt.executeQuery();
			 if(rset.next()) {
				 StockLine cl = new StockLine ();
				 cl.setEmpName(rset.getString("EMP_NAME"));
				 cl.setDeptName(rset.getString("DEPT_TITLE"));
				 
				 tn.add(cl);
			 	}	
				
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		
		return tn;
	}

	/**
	 * 진행상황 업데이트
	 * @param con
	 * @param info
	 * @return
	 */
	public int updateInfo(Connection con, CheckDoc info) {
		int result =0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateInfo");
		
		try {
			pstmt = con.prepareStatement(sql);
			
				 
				
			pstmt.setInt(1, info.getaStatus());
			pstmt.setString(2, info.getApprover());
			pstmt.setString(3,info.getInStatus());
			if(info.getColStatus()!=null) {
			pstmt.setString(4,info.getColStatus());
			}else {
				pstmt.setNull(4,java.sql.Types.NULL);
			}
			if(info.getReturnComment()!=null) {
			pstmt.setString(5,info.getReturnComment());
			}else {
				pstmt.setNull(5,java.sql.Types.NULL);
			}
			pstmt.setInt(6,info.getDocNumber());
			
			result = pstmt.executeUpdate();
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}

	/**
	 * 결재자 정 상태 가져오기
	 * @param con
	 * @param mascode
	 * @return
	 */
	public boolean getMasStauts(Connection con, int mascode) {
		boolean status = false;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("checkmaster");
		//쿼리문 부터 작성필요
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, mascode);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				String ttc= rset.getString("TA_TYPE_CODE");
				if(ttc.equals("T1")||ttc.equals("T4")) {
					status = true;
				}
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return status;
	}

	

	

}

