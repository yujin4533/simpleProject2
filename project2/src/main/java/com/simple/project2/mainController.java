package com.simple.project2;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Component
@Controller
public class mainController {

	@Autowired
	private mainService service;
	
	@RequestMapping(value = "/index.p2") //메인화면
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {
		HttpSession session = request.getSession();
		String ip = (String) session.getAttribute("userIP");
		session.removeAttribute("header");
		mainVO header = service.getHeader(ip);	
		List<mainVO> calendar = service.getCalendarList(ip);
		session.setAttribute("header", header);
		mv.addObject("calendar",calendar);
		
		return mv;
	}
	
	@RequestMapping(value = "/stopWatch.p2", produces = "text/plain;charset=UTF-8") //스톱워치
	@ResponseBody
	public String stopWatch(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, mainVO vo) {

		JSONObject jsonObj = new JSONObject();
		
		String msg = ">>등록실패<<";
		if(service.setRecord(vo)==1)
			msg = ">>등록성공<<";
		jsonObj.put("msg", msg);
		return jsonObj.toString();
	}
	
	@RequestMapping(value = "/record.p2") //스톱워치기록
	public ModelAndView record(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, mainVO recordVO) {
		HttpSession session = request.getSession();
		
		recordVO.setTotalCnt(service.getRecordCnt((String) session.getAttribute("userIP")));
		recordVO.setSizePerPage(5);
		recordVO.setUserIP((String) session.getAttribute("userIP"));
		List<mainVO> recordVOlist= service.getRecord(recordVO);
		
		String pagebar = "<ul style='display: inline-flex;'>";
		recordVO.setBlockSize(5);
		pagebar += MyUtil.searchPageBar(request, recordVO, "record");
		pagebar += "</ul>";
		
		mv.addObject("recordVO",recordVOlist);
		mv.addObject("pagebar",pagebar);
		return mv;
	}
	
	@RequestMapping(value = "/edit.p2") //수정
	public ModelAndView edit(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {
		HttpSession session = request.getSession();
		mainVO header = service.getHeader((String)session.getAttribute("userIP"));
		
		mv.addObject("header",header);
		return mv;
	}
	
	@RequestMapping(value = "/chatting.p2") //채팅
	public ModelAndView chatting(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {
		
		return mv;
	}
	
	@RequestMapping(value = "/board.p2") //개인보드
	public ModelAndView board(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {
		if(request.getParameter("seq")!=null && request.getParameter("seq") != "") {
			mainVO boardVO = service.getBoard(request.getParameter("seq"));
			mv.addObject("boardVO",boardVO);
		}
		
		return mv;
	}
	
	@RequestMapping(value = "/showBoard.p2", produces = "text/plain;charset=UTF-8") //보드 ajax
	@ResponseBody
	public String showBoard(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {
		JSONArray jsonArr = new JSONArray();
		List<mainVO> boardVOList = service.getBoardList(request.getParameter("userIP"));
		if(boardVOList != null) {
			for(mainVO boardVO : boardVOList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("seq", boardVO.getSeq());
				jsonObj.put("boardyymm", boardVO.getBoardDate().substring(0,7));
				jsonObj.put("boarddd", boardVO.getBoardDate().substring(8,10));
				jsonObj.put("boardTitle", boardVO.getBoardTitle());
				jsonObj.put("boardContent", boardVO.getBoardContent());
				jsonArr.put(jsonObj);
			}
		}

		return jsonArr.toString();
	}
	
	@RequestMapping(value = "/writeBoard.p2", produces = "text/plain;charset=UTF-8") //보드 ajax
	@ResponseBody
	public void writeBoard(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, mainVO boardVO) {
		service.setBoard(boardVO);
	}
	
	@RequestMapping(value = "/showCalendar.p2", produces = "text/plain;charset=UTF-8") //보드 ajax
	@ResponseBody
	public String showCalendar(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {
		JSONArray jsonArr = new JSONArray();
		List<mainVO> CalendarVOList = service.getCalendarList(request.getParameter("userIP"));
		if(CalendarVOList != null) {
			for(mainVO calVO : CalendarVOList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("seq", calVO.getSeq());
				jsonObj.put("calendaryymm", calVO.getCalendarDate().substring(0,7));
				jsonObj.put("calendardd", calVO.getCalendarDate().substring(8,10));
				jsonObj.put("calendarTitle", calVO.getCalendarTitle());
				jsonObj.put("calendarContent", calVO.getCalendarContent());
				jsonArr.put(jsonObj);
			}
		}
		
		return jsonArr.toString();
	}
	
	@RequestMapping(value = "/editAjax.p2", produces = "text/plain;charset=UTF-8") //보드 ajax
	@ResponseBody
	public void editAjax(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, mainVO boardVO) {
		service.setEdit(boardVO);
	}
	

}
