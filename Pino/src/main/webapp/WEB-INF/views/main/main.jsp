<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../include/header.jsp" %>

<title>인사시스템</title>

<style>
	.bodyBackgroundColor {
		background-color: #333;
	}
	
	.font_color {
		color: white;
		text-align: center;
	}
	
	div.scrollmenu {
	  background-color: #333;
	  overflow: auto;
	  white-space: nowrap;
	}
	
	div.scrollmenu a {
	  display: inline-block;
	  color: white;
	  text-align: center;
	  padding: 14px;
	  text-decoration: none;
	}
	
	div.scrollmenu a:hover {
	  background-color: #777;
	}
	
	.header {
		margin-bottom: 200px;
	}
	
	.content {
		margin-top: 220px;
		margin-bottom: 200px;
	}
	
	.footer {
		margin-top: 240px;
		text-align: center;
		color: white;
	}
	
</style>

<script>
	$(document).ready(function() {
		$("#btnInput").click(function() {
// 			console.log("클릭됨");
			location.href="/insa/input";
		});
		
		$("#btnSelect").click(function() {
			location.href="/insa/select?nowPage=1&perPage=10";
		});
// 		$("#member_input").click(function() {
// 			location.href="/insa/member_input";
// 		});
	});
</script>

</head>
<body class="bodyBackgroundColor">

	<div class="container-fluid">
		<div class="row header">
			<div class="col-md-3">
			</div>
			<div class="col-md-6">
				<div class="scrollmenu">
				  <a href="/main/main">Pinosoft</a>
				  <span style="float: right;">
				  <a href="/main/main">Home</a>
				  <a href="/insa/input">Input</a>
				  <a href="/insa/select">Search</a>
				  </span>
				</div>
			</div>
			<div class="col-md-3">
			</div>
		</div>
	</div>
		
	<div class="content">
		<h1 style="color: white; text-align: center;">인사관리시스템</h1><br>
		<p class="font_color">인사정보를 입력하겠습니다. &nbsp;<button class="btn btn-light btn-sm" id="btnInput">입력</button></p>
		<p class="font_color">인사정보를 조회하겠습니다. &nbsp;<button class="btn btn-light btn-sm" id="btnSelect">조회</button></p>
<!-- 		<p>테스트<button class="btn btn-light btn-sm" id="member_input">테스트</button></p> -->
	</div>
	
	<div class="footer">
		서울특별시 금천구 디지털로9길 46 이앤씨드림타워7차 3층 306호(가산동 60-44 이앤씨드림타워7차) / Tel. 02-6049-1114 / Fax. 02-861-9883<br>
		Copyright 2019 Pinosoft co. LTD All right
	</div>

</body>
</html>