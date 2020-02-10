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
import com.coo.check.model.vo.RoundDoc;
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
	 * 4일때 전부 2,3 일때 완료/반려  0,1 일땐 진행
	 * @param con
	 * @return
	 */
	public int getListCount(Connection con, String id, int status) {
		int result =0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql="";
		if(status == 4) {
		 sql= prop.getProperty("checkCount");
		}else if(status == 3 || status ==2) {
		 sql =prop.getProperty("checkendCount");
		}else {
			sql =prop.getProperty("checkflowCount");
		}
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, id);
			pstmt.setString(3, id);
			pstmt.setString(4, id);
			pstmt.setString(5, id);
			
			if(status == 3 || status ==2) {
				pstmt.setInt(6, status);
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
	public ArrayList<CheckDoc> getList(Connection con, int currentPage, int limitPage, String id, int status) {
		ArrayList<CheckDoc> docs= null;

		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql ="";
		if(status == 4) {
		sql = prop.getProperty("selectDocList");
		}else if(status == 3 || status ==2){
			sql = prop.getProperty("selectSelectEndList");
		}else {
			sql = prop.getProperty("selectSelectFlowList");
		}
		try {
			
			//페이징 눌렀을 때 시작 로우넘  계산 
			int startRow = (currentPage -1)*limitPage+1; //1,11,21
			
			//마지막 로우넘 번호 계산
			int endRow = startRow + limitPage -1; //10,20,30
			
		
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, id);
			pstmt.setString(3, id);
			pstmt.setString(4, id);
			pstmt.setString(5, id);
			int i = 6;
			if(status ==2 || status ==3) {
			pstmt.setInt(i, status);
			i++;
			}
			pstmt.setInt(i, endRow);
			pstmt.setInt(i+1, startRow);
				
			
			rset=pstmt.executeQuery();
			
			
			docs = new ArrayList<CheckDoc>();
			
			while(rset.next()) {
				CheckDoc cd = new CheckDoc();
				cd.setDocNumber(rset.getInt("DOC_NUMBER"));
				cd.setaTitle(rset.getString("ATITLE"));
				cd.setaWriter(rset.getString("AWRITER"));
				cd.setDocType(rset.getString("DOC_TYPE"));
				cd.setaStatus(rset.getInt("ASTATUS"));
				cd.setApprover(rset.getString("APPROVER"));
				cd.setDeptCode(rset.getString("DEPT_CODE"));
				cd.setInPeople(rset.getString("INPEOPLE"));
				cd.setInStatus(rset.getString("INSTATUS"));
				cd.setColDept(rset.getString("COL_DEPT"));
				cd.setColPeople(rset.getString("COL_PEOPLE"));
				cd.setColStatus(rset.getString("COL_STATUS"));
				cd.setEndPerson(rset.getString("END_PERSON"));
				cd.setViewPeople(rset.getString("VIEW_PEOPLE"));
				cd.setDocDate(rset.getDate("DOC_DATE"));
				cd.setReturnComment(rset.getString("RETURNCOMMENT"));
				cd.setDocfile(rset.getString("DOCFILE"));
				
				docs.add(cd);
			}
			System.out.println(docs.get(0));
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
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
				info.setaWriter(rset.getString("AWRITER"));
				info.setDocType(rset.getString("DOC_TYPE"));
				info.setaStatus(rset.getInt("ASTATUS"));
				info.setApprover(rset.getString("APPROVER"));
				info.setDeptCode(rset.getString("DEPT_CODE"));
				info.setInPeople(rset.getString("INPEOPLE"));
				info.setInStatus(rset.getString("INSTATUS"));
				info.setColDept(rset.getString("COL_DEPT"));
				info.setColPeople(rset.getString("COL_PEOPLE"));
				info.setColStatus(rset.getString("COL_STATUS"));
				info.setEndPerson(rset.getString("END_PERSON"));
				info.setViewPeople(rset.getString("VIEW_PEOPLE"));
				info.setDocDate(rset.getDate("DOC_DATE"));
				info.setDeleteyn(rset.getString("DELETE_YN"));
				info.setReturnComment(rset.getString("RETURNCOMMENT"));
				info.setDocfile(rset.getString("DOCFILE"));
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
		System.out.println(dn);
		
		try {
			pstmt = con.prepareStatement(sql);
			System.out.println(sql);
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
	 * 휴가계획서 내용
	 * @param con
	 * @param dn
	 * @return
	 */
	public Vacation geVacD(Connection con, int dn) {
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
				doc.setStart(rset.getDate("startDate"));
				doc.setEnd(rset.getDate(""));
				doc.setType(rset.getString("type"));
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
			pstmt.setString(2,info.getaWriter());
			pstmt.setString(3,info.getDocType());
		
			pstmt.setString(4,info.getApprover());
			
			pstmt.setString(5,info.getDeptCode());
			pstmt.setString(6,info.getInPeople() );
			pstmt.setString(7,info.getInStatus());
			if(info.getDeptCode()!= null ){ 
				pstmt.setString(8,info.getColDept());
				pstmt.setString(9,info.getColPeople());
				pstmt.setString(10,info.getColStatus());
			
			}else {
			pstmt.setNull(8,java.sql.Types.NULL); //sql의 null 설정
			pstmt.setNull(9,java.sql.Types.NULL);
			pstmt.setNull(10,java.sql.Types.NULL);
			}
			
		
			if(info.getEndPerson()!=null) {
			 pstmt.setString(11,info.getEndPerson());
			}else {
				pstmt.setNull(11,java.sql.Types.NULL);
			}
		 
			if(info.getDeptCode()!=null) {
				pstmt.setString(12,info.getViewPeople());
			
			}else {
				pstmt.setNull(12,java.sql.Types.NULL);
			}
			if(info.getDocfile()!=null) {
			pstmt.setString(13,info.getDocfile());
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
	 * 저장된 문서번호 가져오기
	 * @param con
	 * @param getaWriter
	 * @return
	 */
	public int getDocNum(Connection con, String getaWriter) {
		int docNum =0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectDocNo");
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, getaWriter);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				docNum = rset.getInt("DOC_NUMBER");
			}
			System.out.println(docNum);
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
			
		}
		
		return docNum;
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
		if(docType =="품의서") {
			sql = prop.getProperty("insertRoundDoc");
			docText = doc;
		}else if(docType =="지출결의서") {
			sql = prop.getProperty("insertPayDoc");
			docText = (PayDoc)doc;
		}else {
			sql=prop.getProperty("insertVacDoc");
		}
		try {
			System.out.println(sql);
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, doc.getDocNumber());
			pstmt.setString(2,doc.getText());
			if(docType =="지출결의서") {
			pstmt.setInt(3, ((PayDoc)doc).getEndPay());
			}else if(docType =="휴가신청서") {
				//sql=prop.getProperty("insertVacDoc");
				//sql.setDate(3,((Vacation)doc).getStart());
				//sql.setDate(4,((Vacation)doc).getStart());
				//sql.setDate(5,((Vacation)doc).getStart());
				//sql.setDate(6,((Vacation)doc).getStart());
				//sql.setDate(6,((Vacation)doc).getStart());
			}
			result=pstmt.executeUpdate();
			
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}

		return result;
	}

}