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
<title>chatting</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="http://fonts.googleapis.com/css?family=Source+Sans+Pro:200,300,400,600,700,900" rel="stylesheet" />
<link href="/project2/resources/default.css" rel="stylesheet" type="text/css" media="all" />
<link href="/project2/resources/fonts.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/json2.js"></script>
<script src="<%=request.getContextPath()%>/resources/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		
		url = window.location.host; // ip:port
		pathname = window.location.pathname; // port뒤
		appCtx = pathname.substring(0, pathname.lastIndexOf("/")); // project2까지
		root = "ws://"+url + appCtx+"/websokeyChatting.p2";
		
		websocket = new WebSocket(root);
		
		websocket.onopen = function() {
			$("#chatMessage").append("<span style='color:navy; font-weight:bold;'>채팅방에 입장했습니다</span><br/>");
		};

		websocket.onmessage = function(evt) {
			$("#chatMessage").append(evt.data);
			$("#chatMessage").append("<br />");
			$("#chatMessage").scrollTop(99999999);
		};	
		
		$("#message").keydown(function (key) {
			if (key.keyCode == 13)
				$("#sendMessage").click();
		});
		
		$("#sendMessage").click(function() {
			if( $("#message").val() != "") {
				messageVal = $("#message").val();
				messageVal = messageVal.replace(/<script/gi, "&lt;script");
				
				$("#chatMessage").append("<span style='color:navy; font-weight:bold;'>[나] ▷ " + messageVal + "</span><br/>");
				$("#chatMessage").scrollTop(99999999);
				$("#message").val("");
				websocket.send(messageVal);
			}
		});
	});

</script>

<!--[if IE 6]><link href="default_ie6.css" rel="stylesheet" type="text/css" /><![endif]-->

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
				<li><a href="/project2/edit.p2">Edit</a></li>
				<li><a href="/project2/board.p2">Board</a></li>
				<li class="current_page_item"><a href="/project2/chatting.p2">Chatting</a></li>
			</ul>
		</div>
	</div>
	<div id="main">
		<div id="featured" style="padding-top: 10px;">
			<div class="title">
				<h2>Chatting</h2>
			</div>
			<div id="chatMessage" style="overFlow: auto; height: 500px; text-align: left;"></div>
			<input type="text" id="message" size="50" />
			<input type="button" id="sendMessage" value="전송" />
		</div>
		<div id="copyright">
			<span>&copy; Untitled. All rights reserved. | Design by <a href="http://templated.co" rel="nofollow">TEMPLATED</a>.</span>
		</div>
	</div>
</div>
</body>
</html>
