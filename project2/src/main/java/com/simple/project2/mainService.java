package com.simple.project2;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class mainService {
	
	@Autowired
	private mainDAO dao;
	
	public void insertUserIP(String ip) {
		dao.insertUserIP(ip);
	}

	public mainVO getHeader(String ip) {
		return dao.getHeader(ip);
	}

	public int setRecord(mainVO vo) {
		return dao.setRecord(vo);
	}

	public int getRecordCnt(String ip) {
		return dao.getRecordCnt(ip);
	}

	public List<mainVO> getRecord(mainVO vo) {
		return dao.getRecord(vo);
	}

	public List<mainVO> getBoardList(String ip) {
		return dao.getBoardList(ip);
	}

	public void setBoard(mainVO boardVO) {
		dao.setBoard(boardVO);
	}

	public mainVO getBoard(String seq) {
		return dao.getBoard(seq);
	}

	public void setEdit(mainVO boardVO) {
		dao.setEdit(boardVO);		
	}

	public List<mainVO> getCalendarList(String ip) {
		return dao.getCalendarList(ip);
	}

}
