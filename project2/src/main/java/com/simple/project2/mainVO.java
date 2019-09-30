package com.simple.project2;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class mainVO {
	
	private String userIP;
	private int seq;
	
	private String headerTitle1;
	private String headerTitle2;
	private String headerContent;
	
	private String startTime;
	private String endTime;
	
	private String calendarDate;
	private String calendarTitle;
	private String calendarContent;
	
	private String boardDate;
	private String boardTitle;
	private String boardContent;
	
	private int blockSize;
	private int totalCnt;
	private int currentShowPage;
	private int sizePerPage;
	
	public mainVO() {}

	public mainVO(String userIP, int seq, String headerTitle1, String headerTitle2, String headerContent,
			String startTime, String endTime, String calendarDate, String calendarTitle, String calendarContent,
			String boardDate, String boardTitle, String boardContent, int blockSize, int totalCnt, int currentShowPage, int sizePerPage) {
		super();
		this.userIP = userIP;
		this.seq = seq;
		this.headerTitle1 = headerTitle1;
		this.headerTitle2 = headerTitle2;
		this.headerContent = headerContent;
		this.startTime = startTime;
		this.endTime = endTime;
		this.calendarDate = calendarDate;
		this.calendarTitle = calendarTitle;
		this.calendarContent = calendarContent;
		this.boardDate = boardDate;
		this.boardTitle = boardTitle;
		this.boardContent = boardContent;
		this.blockSize = blockSize;
		this.totalCnt = totalCnt;
		this.currentShowPage= currentShowPage;
		this.sizePerPage= sizePerPage;
	}

	public String getUserIP() {
		return userIP;
	}

	public void setUserIP(String userIP) {
		this.userIP = userIP;
	}

	public int getSeq() {
		return seq!=0?seq:0;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getHeaderTitle1() {
		return headerTitle1;
	}

	public void setHeaderTitle1(String headerTitle1) {
		this.headerTitle1 = headerTitle1;
	}

	public String getHeaderTitle2() {
		return headerTitle2;
	}

	public void setHeaderTitle2(String headerTitle2) {
		this.headerTitle2 = headerTitle2;
	}

	public String getHeaderContent() {
		return headerContent;
	}

	public void setHeaderContent(String headerContent) {
		this.headerContent = headerContent;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	
	public String getStopWatch() {
		String result = "";
		SimpleDateFormat f = new SimpleDateFormat("HH:mm:ss", Locale.KOREA);
		try {
			Date d1 = f.parse(endTime.substring(11));
			Date d2 = f.parse(startTime.substring(11));
			long minus = d1.getTime() - d2.getTime();
			long totalSec = minus / 1000;
			int hour = (int) (totalSec/60/60);
			if(hour<10)
				result+="0";
			result+=hour+":";
			int min = (int) ((totalSec/60)%60);
			if(min<10)
				result+="0";
			result+=min+":";
			int sec = (int) (totalSec%60);
			if(sec<10)
				result+="0";
			result+=sec;
				
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return result;
	}

	public String getCalendarDate() {
		return calendarDate;
	}

	public void setCalendarDate(String calendarDate) {
		this.calendarDate = calendarDate;
	}

	public String getCalendarTitle() {
		return calendarTitle;
	}

	public void setCalendarTitle(String calendarTitle) {
		this.calendarTitle = calendarTitle;
	}

	public String getCalendarContent() {
		return calendarContent;
	}

	public void setCalendarContent(String calendarContent) {
		this.calendarContent = calendarContent;
	}

	public String getBoardDate() {
		return boardDate;
	}

	public void setBoardDate(String boardDate) {
		this.boardDate = boardDate;
	}

	public String getBoardTitle() {
		return boardTitle;
	}

	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}

	public String getBoardContent() {
		return boardContent;
	}

	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	};
	
//	페이징처리
	public int getTotalCnt() {
		return totalCnt;
	}

	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}
	
	public int getTotalPage() {
		return (int)Math.ceil((double)totalCnt/sizePerPage);
	}

	public int getCurrentShowPage() {
		return currentShowPage;
	}

	public void setCurrentShowPage(int currentShowPage) {
		this.currentShowPage = currentShowPage;
	}

	public int getStartRno() {
		if(currentShowPage<1)
			currentShowPage = 1;
		return (currentShowPage-1)*sizePerPage+1;
	}

	public int getEndRno() {
		return getStartRno()+sizePerPage-1;
	}

	public int getBlockSize() {
		return blockSize;
	}

	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}

	public int getSizePerPage() {
		return sizePerPage;
	}

	public void setSizePerPage(int sizePerPage) {
		this.sizePerPage = sizePerPage;
	}

	
	
}
