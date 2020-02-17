package com.coo.board.model.vo;
import java.util.Comparator;

public class Decending implements Comparator<Board>{

	@Override
	public int compare(Board o1, Board o2) {
		//내림 차순을 위한 메소드 구현
		
		if(o1.getBno() > o2.getBno()) {
			return -1;
		}else if(o1.getBno() < o2.getBno()) {
			return 1;
		}
		else {
			return 0;
		}
	}

}
