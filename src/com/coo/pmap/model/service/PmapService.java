package com.coo.pmap.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.coo.pmap.model.Dao.PmapDao;
import com.coo.pmap.model.vo.Pmap;
import static com.coo.common.JDBCTemplate.*;
public class PmapService {

	private PmapDao pDao = new PmapDao();
	
	/**
	 * ������ ��ü����
	 * @return
	 */
	public ArrayList<Pmap> selectList() {
		
		Connection con = getConnection();
		
		ArrayList<Pmap> list = pDao.selectList(con);
		
		close(con);
		return list;
	}

}
