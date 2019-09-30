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
<title>record</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="http://fonts.googleapis.com/css?family=Source+Sans+Pro:200,300,400,600,700,900" rel="stylesheet" />
<link href="/project2/resources/default.css" rel="stylesheet" type="text/css" media="all" />
<link href="/project2/resources/fonts.css" rel="stylesheet" type="text/css" media="all" />

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
				<li class="current_page_item"><a href="/project2/record.p2">Record</a></li>
				<li><a href="/project2/edit.p2">Edit</a></li>
				<li><a href="/project2/board.p2">Board</a></li>
				<li><a href="/project2/chatting.p2">Chatting</a></li>
			</ul>
		</div>
	</div>
	<div id="main">
		<div id="featured">
			<div class="title">
				<h2>record</h2>
			</div>
			<c:if test="${recordVO!=null}">
				<c:forEach var="list" items="${recordVO}">
					<ul class="style1">
						<li class="first">
							<p class="date">${list.startTime.substring(0,7)}<b>${list.startTime.substring(8,10)}</b></p>
							<h3>${list.stopWatch}</h3>
							<p>${list.startTime.substring(11)}-${list.endTime.substring(11)}</p>
						</li>
					</ul>
				</c:forEach>
			</c:if>
		</div>

		<c:if test="${pagebar!=null}">${pagebar}</c:if>

		<div id="copyright">
			<span>&copy; Untitled. All rights reserved. | Design by <a href="http://templated.co" rel="nofollow">TEMPLATED</a>.</span>
		</div>
	</div>
</div>
</body>
</html>
