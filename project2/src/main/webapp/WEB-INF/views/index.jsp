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
<title>index</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="http://fonts.googleapis.com/css?family=Source+Sans+Pro:200,300,400,600,700,900" rel="stylesheet" />
<link href="/project2/resources/default.css" rel="stylesheet" type="text/css" media="all" />
<link href="/project2/resources/fonts.css" rel="stylesheet" type="text/css" media="all" />

<!--[if IE 6]><link href="default_ie6.css" rel="stylesheet" type="text/css" /><![endif]-->
<script src="<%=request.getContextPath()%>/resources/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	init();

	function init() {
		clock();
		setInterval(clock, 1000);
	}
	
	function clock() {
		date = new Date();
		year = date.getFullYear();
		month = date.getMonth()+1;
		clockDate = date.getDate();
		day = date.getDay();
		week = ["일", '월', '화', '수', '목', '금', '토'];
		hours = date.getHours();
		minutes = date.getMinutes();
		seconds = date.getSeconds();
		
		result = year+"년 "+month+"월 "+clockDate+"일 "+week[day]+"요일 "+hours+"시 "+minutes+"분 "+seconds+"초";
		$("#clock").html(result);
		
	}

	state = false;
	
	function swStart(){
		
		date = new Date();
		year = date.getYear()-100;
		month = date.getMonth()+1;
		clockDate = date.getDate();
		hours = date.getHours();
		minutes = date.getMinutes();
		seconds = date.getSeconds();

		month = ""+month;
		clockDate = ""+clockDate;
		hours = ""+hours;
		minutes = ""+minutes;
		seconds = ""+seconds;

		if(month.length!=2)
			month = "0"+month;
		if(clockDate.length!=2)
			clockDate = "0"+clockDate;
		if(hours.length!=2)
			hours = "0"+hours;
		if(minutes.length!=2)
			minutes = "0"+minutes;
		if(seconds.length!=2)
			seconds = "0"+seconds;
		
		result = year+"/"+month+"/"+clockDate+"/"+hours+"/"+minutes+"/"+seconds;
		result2 = year+""+month+""+clockDate+"/"+hours+":"+minutes+":"+seconds;
		
		if(state){
			state = false;
			timer(0,0,0,state);
			document.watchFrm.endTime.value = result;
			
			var form_data = $("form[name=watchFrm]").serialize();
			$.ajax({
				url:"<%= request.getContextPath()%>/stopWatch.p2",
				type:"post",
				data:form_data,
				dataType:"JSON",
				success:function(json){
					alert(json.msg );
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					console.log("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
		} else {
			state = true;
			$("#startTime").html(result2);
			document.watchFrm.startTime.value = result;
			timer(0,0,0,state);
		}
		
	}
	
	function timer(sec,min,hour,state){
		if(state){
			sec++;
			if(sec==60){
				sec = 0;
				min++;
			}
			if(min==60){
				min = 0;
				hour++;
			}
			
			sec = ""+sec;
			min = ""+min;
			hour = ""+hour;
			
			if(sec.length!=2)
				sec = "0"+sec;
			if(min.length!=2)
				min = "0"+min;
			if(hour.length!=2)
				hour = "0"+hour;
			
			$("#stopwatch").html(hour+":"+min+":"+sec);
			
			timerF = setTimeout("timer("+sec+","+min+","+hour+",true)", 1000);
			
		} else {
			clearTimeout(timerF);
		}
	}

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
				<li class="current_page_item"><a href="/project2/index.p2">Home</a></li>
				<li><a href="/project2/record.p2">Record</a></li>
				<li><a href="/project2/edit.p2">Edit</a></li>
				<li><a href="/project2/board.p2">Board</a></li>
				<li><a href="/project2/chatting.p2">Chatting</a></li>
			</ul>
		</div>
	</div>
	<div id="main">
		<div id="welcome">
		<c:if test="${sessionScope.header!=null}">
			<div class="title">
				<h2>${sessionScope.header.headerTitle1}</h2>
				<span class="byline">${sessionScope.header.headerTitle2}</span>
			</div>
			<p>${sessionScope.header.headerContent}</p>
		</c:if>
		</div>
		<div id="featured">
			<div class="title">
				<h3 id="clock" style="color:gray;">0000년 0월 00일 요일 00시 00분 00초</h3>
				<h2>Record</h2>
				<form name="watchFrm">
					<input type="hidden" name="startTime"/>
					<input type="hidden" name="endTime"/>
					<input type="hidden" name="userIP" value="${sessionScope.userIP}"/>
					<h3>시작시간 : <span id="startTime" style="color:gray;">000000/00:00:00</span></h3>
					<h2 id="stopwatch" style="color:gray;">00:00:00</h2>
					<input type="button" name="startBut" value="start/stop" onclick="swStart()"/>
				</form>
			</div>
		</div>
		<div id="featured">
			<div class="title">
				<h2>Calendar</h2>
			</div>
			<c:if test="${calendar!=null}">
				<c:forEach var="cal" items="${calendar}">
					<ul class="style1">
						<li class="first">
							<p class="date"><a href="#">${cal.calendarDate.substring(2,7)}<b>${cal.calendarDate.substring(8,10)}</b></a></p>
							<h3>${cal.calendarTitle}</h3>
							<p>${cal.calendarContent}</p>
						</li>
					</ul>
				</c:forEach>					
			</c:if>
			<c:if test="${calendar==null}">
				<p>일정이 없습니다</p>
			</c:if>
		</div>
		<div id="copyright">
			<span>&copy; Untitled. All rights reserved. | Design by <a href="http://templated.co" rel="nofollow">TEMPLATED</a>.</span>
		</div>
	</div>
</div>
</body>
</html>
