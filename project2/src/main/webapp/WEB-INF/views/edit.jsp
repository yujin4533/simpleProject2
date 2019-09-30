<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<!--
Design by TEMPLATED
http://templated.co
Released for free under the Creative Commons Attribution License

Name       : Skeleton 
Description: A two-column, fixed-width design with dark color scheme.
Version    : 1.0
Released   : 20130902

-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>edit</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="http://fonts.googleapis.com/css?family=Source+Sans+Pro:200,300,400,600,700,900" rel="stylesheet" />
<link href="/project2/resources/default.css" rel="stylesheet" type="text/css" media="all" />
<link href="/project2/resources/fonts.css" rel="stylesheet" type="text/css" media="all" />

<!--[if IE 6]><link href="default_ie6.css" rel="stylesheet" type="text/css" /><![endif]-->
<script src="<%=request.getContextPath()%>/resources/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
		showCalendar();
	});	
	
	function chage(){
		var queryString = $("form[name=ajaxFrm]").serialize();
		$.ajax({
			url:"editAjax.p2",
			type:"POST",
			data:queryString,
			success:function(){
				document.ajaxFrm.calendarDate.value="";
				document.ajaxFrm.calendarTitle.value="";
				document.ajaxFrm.calendarContent.value="";
				showCalendar();
			},error: function(request, status, error){alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);}
		});
	};
	
	function showCalendar(){
		$.ajax({
			url:"showCalendar.p2",
			type:"GET",
			data:{userIP:"${sessionScope.userIP}"},
			dataType:"JSON",
			success:function(json){
				var html = "";
				
				if (json.length > 0) {    
					$.each(json, function(index, item){
						html += '<ul class="style1">';
						html += '<li class="first">';
						html += '<p class="date">'+item.calendaryymm+'<b>'+item.calendardd+'</b><a style="font-size: 13px;" href="/project2/board.p2?seq='+item.seq+'">수정 / </a><a style="font-size: 13px;">삭제</a></p>';
						html += '<h3>'+item.calendarTitle+'</h3>';
						html += '<p>'+item.calendarContent+'</p>';
						html += '</li>';
						html += '</ul>';
					});
				} else {
					html += '<ul class="style1">';
					html += '<li class="first">';
					html += '<p class="date"><b></b></p>';
					html += '<h3>아직 일정이 없습니다</h3>';
					html += '<p>일정을 등록해보세요</p>';
					html += '</li>';
					html += '</ul>';
				}
				$("#calendarAjax").html(html);
			}
		});
	};
		
</script>
</head>
<body>
<div id="page" class="container">
	<div id="header">
		<div id="logo">
			<h1><a href="#">USER</a></h1>
			<span>${sessionScope.userIP}</span>
		</div>
		<div id="menu">
			<ul>
				<li><a href="/project2/index.p2">Home</a></li>
				<li><a href="/project2/record.p2">Record</a></li>
				<li class="current_page_item"><a href="/project2/edit.p2">Edit</a></li>
				<li><a href="/project2/board.p2">Board</a></li>
				<li><a href="/project2/chatting.p2">Chatting</a></li>
			</ul>
		</div>
	</div>
	<div id="main">
		<form name="ajaxFrm">
			<div id="welcome">
				<input type="hidden" value="${sessionScope.userIP}" name="userIP"/>
				<div class="title">
					<input type="text" name="headerTitle1" value="${sessionScope.header.headerTitle1}" style="font-size: 2.8em; background: transparent; border: 0; text-transform: lowercase; font-weight: 600; display: block;margin: 0 auto; text-align: center;"/>
					<input type="text" name="headerTitle2" value="${sessionScope.header.headerTitle2}" style="font-size: 1.3em; background: transparent; border: 0; text-transform: lowercase; font-weight: 600; display: block; margin: 0 auto; text-align: center;"/>
				</div>
				<textarea rows="3" cols="50" style="font-size: 16px;" name="headerContent">${sessionScope.header.headerContent}</textarea>
			</div>
			<div id="featured">
				<div class="title">
					<h2>Calendar</h2>
				</div>
				<div id="addCal">
				<input type="date" name="calendarDate"/>
				<input type="text" style="width: 270px;" name="calendarTitle"/><br/><br/>
				<textarea rows="3" cols="50" style="font-size: 16px;" name="calendarContent"></textarea>
				</div>
				
			</div>
			<div>
				<button type="button" onclick="chage()">변경</button>
			</div>
		</form>
		<div id="welcome">
			<div id="calendarAjax">
			</div>
		</div>
		<div id="copyright">
			<span>&copy; Untitled. All rights reserved. | Design by <a href="http://templated.co" rel="nofollow">TEMPLATED</a>.</span>
		</div>
	</div>
</div>
</body>
</html>
