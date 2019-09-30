package com.simple.project2;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class mainDAO {
	
	@Autowired
	private SqlSessionTemplate sql;//mainMapper
	
	public void insertUserIP(String ip) {
		int existUser = sql.selectOne("mainMapper.getUserIP",ip);
		if(existUser==0)
			sql.insert("mainMapper.setUserIP",ip);
	}

	public mainVO getHeader(String ip) {
		mainVO header = sql.selectOne("mainMapper.getHeader",ip);
		return header;
	}

	public int setRecord(mainVO vo) {
		int n = sql.insert("mainMapper.setRecord",vo);
		return n;
	}
	
	public int getRecordCnt(String ip) {
		int n = sql.selectOne("mainMapper.getRecordCnt",ip);
		return n;
	}

	public List<mainVO> getRecord(mainVO vo) {
		List<mainVO> calendar = sql.selectList("mainMapper.getRecord",vo);
		return calendar;
	}

	public List<mainVO> getBoardList(String ip) {
		List<mainVO> list = sql.selectList("mainMapper.getBoardList",ip);
		return list;
	}

	public void setBoard(mainVO boardVO) {
		if(boardVO.getSeq()!=0)
			sql.update("mainMapper.setBoardUpdate",boardVO);
		else
			sql.insert("mainMapper.setBoard",boardVO);
	}

	public mainVO getBoard(String seq) {
		mainVO mvo = sql.selectOne("mainMapper.getBoard",seq);
		return mvo;
	}

	public void setEdit(mainVO boardVO) {
		if(boardVO.getCalendarDate()!=null & boardVO.getCalendarDate().length()>=10)
			sql.insert("mainMapper.setCalendar",boardVO);
		sql.update("mainMapper.setTitle",boardVO);
	}

	public List<mainVO> getCalendarList(String ip) {
		List<mainVO> list = sql.selectList("mainMapper.getCalendarList",ip);
		return list;
	}

}
