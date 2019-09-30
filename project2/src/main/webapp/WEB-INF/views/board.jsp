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
<title>board</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="http://fonts.googleapis.com/css?family=Source+Sans+Pro:200,300,400,600,700,900" rel="stylesheet" />
<link href="/project2/resources/default.css" rel="stylesheet" type="text/css" media="all" />
<link href="/project2/resources/fonts.css" rel="stylesheet" type="text/css" media="all" />

<!--[if IE 6]><link href="default_ie6.css" rel="stylesheet" type="text/css" /><![endif]-->
<script src="<%=request.getContextPath()%>/resources/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		showBoard();
		
		$("#submitBtn").click(function(){
			if($("#boardTitle").val().trim()==""){
				alert(">>타이틀을 입력해주세요<<");
				return;
			}
			if($("#boardContent").val().trim()==""){
				alert(">>내용을 입력해주세요<<");
				return;
			}
			
			var queryString = $("form[name=ajaxFrm]").serialize();
			$.ajax({
				url:"writeBoard.p2",
				type:"POST",
				data:queryString,
				success:function(){
					document.ajaxFrm.boardTitle.value="";
					document.ajaxFrm.boardContent.value="";
					showBoard();
				},error: function(request, status, error){alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);}
			});
		});
		
	});
	
	function showBoard(){
		$.ajax({
			url:"showBoard.p2",
			type:"GET",
			data:{userIP:"${sessionScope.userIP}"},
			dataType:"JSON",
			success:function(json){
				var html = "";
				
				if (json.length > 0) {    
					$.each(json, function(index, item){
						html += '<ul class="style1">';
						html += '<li class="first">';
						html += '<p class="date">'+item.boardyymm+'<b>'+item.boarddd+'</b><a style="font-size: 13px;" href="/project2/board.p2?seq='+item.seq+'">수정 / </a><a style="font-size: 13px;">삭제</a></p>';
						html += '<h3>'+item.boardTitle+'</h3>';
						html += '<p>'+item.boardContent+'</p>';
						html += '</li>';
						html += '</ul>';
					});
				} else {
					html += '<ul class="style1">';
					html += '<li class="first">';
					html += '<p class="date"><b></b></p>';
					html += '<h3>아직 게시글이 없습니다</h3>';
					html += '<p>나만의 첫 게시글을 작성해보세요</p>';
					html += '</li>';
					html += '</ul>';
				}
				
				$("#boardAjax").html(html);
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
				<li><a href="/project2/edit.p2">Edit</a></li>
				<li class="current_page_item"><a href="/project2/board.p2">Board</a></li>
				<li><a href="/project2/chatting.p2">Chatting</a></li>
			</ul>
		</div>
	</div>
	<div id="main">
		<div id="featured" style="padding-top: 0px;">
			<form name="ajaxFrm" action="board.p2" method="post">
				<table>
					<tr>
						<th><input  type="hidden" name="userIP" value="${sessionScope.userIP}"/></th>
						<c:if test="${boardVO!=null}">
							<th><input  type="hidden" name="seq" value="${boardVO.seq}"/></th>
						</c:if>
						<th><input type="text" id="boardTitle" name="boardTitle" value="${boardVO.boardTitle}" class="form-control" style="margin-bottom: 10px; width: 600px;"/><br />
						<textarea id="boardContent" name="boardContent" class="form-control" rows="5" cols="3" style="width: 600px;">${boardVO.boardContent}</textarea></th>
						<th><button type="button" id="submitBtn" style="height: 130px; width: 30px; background: #2980b9; border: 0px;" >등록</button></th>
					</tr>
				</table>
			</form>
		</div>
		<div id="featured" style="padding-top: 0px;">
			<div class="title">
				<h2>Board</h2>
			</div>
			<div id="boardAjax">
			</div>
		</div>
		<div id="copyright">
			<span>&copy; Untitled. All rights reserved. | Design by <a href="http://templated.co" rel="nofollow">TEMPLATED</a>.</span>
		</div>
	</div>
</div>
</body>
</html>
