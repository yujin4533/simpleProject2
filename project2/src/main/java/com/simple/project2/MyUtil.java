package com.simple.project2;

import javax.servlet.http.HttpServletRequest;

public class MyUtil {

	public static String searchPageBar(HttpServletRequest request, mainVO vo, String url) {
		String pageBar = "";
		String searchVO = "";
		int loop = 1;
		int pageNo = ((vo.getCurrentShowPage()-1)/vo.getBlockSize())*vo.getBlockSize()+1;
		if(pageNo!=1)
			pageBar+= "<li><a href='/project2/"+url+".p2?currentShowPage="+(pageNo-1)+searchVO+"'><<</a></li>&nbsp;";
		
		while( !(loop>vo.getBlockSize() || pageNo>vo.getTotalPage()) ) {
			// 1>5 || 1>5
			if(pageNo == vo.getCurrentShowPage()) 
				pageBar += "<li class='active'><span>"+pageNo+"</span></li>&nbsp;";
			
			else 
				pageBar += "<li><a href='/project2/"+url+".p2?currentShowPage="+pageNo+searchVO+"'>"+pageNo+"</a><li/>&nbsp;"; 
			
			loop++;
			pageNo++;
		}
		
		if( !(pageNo>vo.getTotalPage()) ) 
			pageBar += "<li><a href='/project2/"+url+".p2?currentShowPage="+pageNo+searchVO+"'>>></a></li>&nbsp;"; 
		
		
		return pageBar;
	}

}
