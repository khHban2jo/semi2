package com.coo.ta.model.service;

import com.coo.exception.CooException;
import com.coo.ta.model.dao.TaDataDao;
import com.coo.ta.model.vo.TaData;
import static com.coo.common.JDBCTemplate.*;

import java.sql.Connection;

public class TaDataService {

	private TaDataDao tdDao = new TaDataDao();
	
	public TaData selectOne(int empCode) throws CooException {

		Connection con = getConnection();
		
		TaData td = tdDao.selectOne(con, empCode);
		
		close(con);
		
		return td;
	}

}
