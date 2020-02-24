package com.coo.boardComment.model.dao;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.coo.boardComment.model.vo.BoardComment;
import com.coo.exception.CooException;

import static com.coo.common.JDBCTemplate.*;

public class BoardCommentDao {
	private Properties prop;
	
	public BoardCommentDao() {
		prop = new Properties();
		String filePath = BoardCommentDao.class.getResource("/config/comment-query.properties").getPath();
		
		try {
			prop.load(new FileReader(filePath));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public int insertComment(Connection con, BoardComment bco) throws CooException {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertComment");
		
		try {
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, bco.getBno());
			pstmt.setString(2, bco.getCcontent());
			pstmt.setString(3, bco.getCwriter());
			
			if(bco.getRefcno() > 0) {
				pstmt.setInt(4, bco.getRefcno());
			}else {
				pstmt.setNull(4, java.sql.Types.NULL);
			}
			
			pstmt.setInt(5, bco.getClevel());
			
			result = pstmt.executeUpdate();

		}catch(SQLException e) {
			throw new CooException("댓글 등록 실패!");
		}finally {
			close(pstmt);
		}
		return result;
	}

	public ArrayList<BoardComment> selectList(Connection con, int bno) throws CooException {
		ArrayList<BoardComment> clist = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectListC");
		try {
			clist = new ArrayList<BoardComment>();
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1 , bno);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				BoardComment bco = new BoardComment();
				
				bco.setCno(rset.getInt("CNO"));
				bco.setBno(bno);
				bco.setCcontent(rset.getString("CCONTENT"));
				bco.setCwriterId(rset.getString("CWRITER"));
				bco.setCdate(rset.getDate("CDATE"));
				bco.setRefcno(rset.getInt("REF_CNO"));
				bco.setClevel(rset.getInt("CLEVEL"));
				
				clist.add(bco);
			}
		}catch(SQLException e) {
			throw new CooException("댓글 조회 실패");
		}finally {
			close(rset);
			close(pstmt);
		}
		return clist;
	}

}
