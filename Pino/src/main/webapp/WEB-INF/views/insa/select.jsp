<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../include/header.jsp" %>


<style>
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
	
	.thText {
		text-align: center;
	}
	
</style>

<script>
$(document).ready(function() {
	
// 	$("#btnTest").click(function() {
// 		var sabun = $("#sabun").val();
// 		$("input[name=sabun]").val(sabun);
// 			console.log(sabun);
		
// 		var name = $("#name").val();
// 		$("input[name=name]").val(name);
// 			console.log(name);
		
// 		var join_gbn_code = $("#join_gbn_code").val();
// 		$("input[name=join_gbn_code]").val(join_gbn_code);
// 			console.log(join_gbn_code);
		
// 		var put_yn = $("#put_yn").val();
// 		$("input[name=put_yn]").val(put_yn);
// 			console.log(put_yn);
		
// 		var pos_gbn_code = $("#pos_gbn_code").val();
// 		$("input[name=pos_gbn_code]").val(pos_gbn_code);
// 			console.log(pos_gbn_code);
		
// 		var join_day = $("#join_day").val();
// 		$("input[name=join_day]").val(join_day);
// 			console.log(join_day);
		
// 		var retire_day = $("#retire_day").val();
// 		$("input[name=retire_day]").val(retire_day);
// 			console.log(retire_day);
		
// 		var job_type = $("#job_type").val();
// 		$("input[name=job_type]").val(job_type);
// 			console.log(job_type);
// 	});
	
	$(".datePicker").datepicker({
        dateFormat: 'yy-mm-dd',
        showOtherMonths: true,
        showMonthAfterYear:true,
        changeYear: true, 
        changeMonth: true,
        showOn: "both",
        buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif",
        buttonImageOnly: true,
        buttonText: "선택",
        yearSuffix: "년",
        monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        dayNamesMin: ['일','월','화','수','목','금','토']
	});
	
	function setPage() {
		var nowPage = "${ pagingDto.nowPage }";
		if (nowPage == "") {
			nowPage = 1;
		}
		
// 		$("input[name=nowPage]").val(nowPage);
// 		$("input[name=perPage]").val(10);
	}
	
	function setSearch() {
		var sabun = $("#sabun").val();
		$("input[name=sabun]").val(sabun);
//			console.log(sabun);
		
		var name = $("#name").val();
		$("input[name=name]").val(name);
//			console.log(name);
		
		var join_gbn_code = $("#join_gbn_code").val();
		$("input[name=join_gbn_code]").val(join_gbn_code);
//			console.log(join_gbn_code);
		
		var put_yn = $("#put_yn").val();
		$("input[name=put_yn]").val(put_yn);
//			console.log(put_yn);
		
		var pos_gbn_code = $("#pos_gbn_code").val();
		$("input[name=pos_gbn_code]").val(pos_gbn_code);
//			console.log(pos_gbn_code);
		
		var join_day = $("#join_day").val();
		$("input[name=join_day]").val(join_day);
//			console.log(join_day);
		
		var retire_day = $("#retire_day").val();
		$("input[name=retire_day]").val(retire_day);
//			console.log(retire_day);
		
		var job_type = $("#job_type").val();
		$("input[name=job_type]").val(job_type);
//			console.log(job_type);
	}
	
	$(".page-link").click(function(e) {
		e.preventDefault();
		var nowPage = $(this).attr("data-page");
		$("input[name=nowPage]").val(nowPage);
		$("input[name=perPage]").val(10);

	 	$("#hiddenData").submit();
	});
	
	$("#btnPrev").click(function() {
		location.href = "/";
	});
	
	$("#btnReset").click(function() {
		location.href = "/insa/select";
	});
	
	$("#btnSubmit").click(function() {
// 		setPage();
		setSearch();
		$("#hiddenData").submit();
	});
	
});
</script>

<title>직원 리스트</title>
</head>
<body>
	
	<div class="container-fluid">
		<div class="row header">
			<div class="col-md-12">
				<div class="scrollmenu">
				  <a href="/main/main">Pinosoft</a>
				  <span style="float: right;">
				  <a href="/main/main">Home</a>
				  <a href="/insa/input">Input</a>
				  <a href="/insa/select">Search</a>
				  </span>
				</div>
			</div>
		</div>
		</div>

	<hr>
	
	
	<div class="container col-sm-12 sub_content">
	<h2>직원 리스트</h2><br>
	
	<form id="hiddenData" action="/insa/select">
		<input type="hidden" name="sabun">
		<input type="hidden" name="name">
		<input type="hidden" name="join_gbn_code">
		<input type="hidden" name="put_yn">
		<input type="hidden" name="pos_gbn_code">
		<input type="hidden" name="join_day">
		<input type="hidden" name="retire_day">
		<input type="hidden" name="job_type">
<!-- 		<input type="hidden" name="nowPage"> -->
<!-- 		<input type="hidden" name="perPage"> -->
	</form>
	
		<!-- 첫번째 줄 시작 -->
		<div class="col-sm-12" style="margin-bottom: 8px;">
			<div class="col-sm-3 padding">
				<div class="col-sm-4">사번</div>
				<div class="col-sm-8">
					<input type="text" class="form-control" id="sabun">
				</div>
			</div>
						 
			<div class="col-sm-3 padding">
				<div class="col-sm-4">성명</div>
				<div class="col-sm-8">
					<input type="text" class="form-control" id="name">
				</div>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-4">입사구분</div>
				<select class="col-sm-8 form-control" id="join_gbn_code">
					<option value=""></option>
					<c:forEach var="insaComVo" items="${ getInsaCom }">
					<c:if test="${ insaComVo.note eq 'join_gbn_code' }">
						<option value="${ insaComVo.name }">${ insaComVo.name }</option>
					</c:if>
					</c:forEach>
				</select>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-4">투입여부</div>
				<select class="col-sm-8 form-control" id="put_yn">
					<option value=""></option>
					<c:forEach var="insaComVo" items="${ getInsaCom }">
					<c:if test="${ insaComVo.note eq 'put_yn' }">
						<option value="${ insaComVo.name }">${ insaComVo.name }</option>
					</c:if>
					</c:forEach>
				</select>
			</div>
		</div>
		<!-- 첫번째 줄 끝 -->
		
		
		<!-- 두번째 줄 시작 -->
		<div class="col-sm-12">
			<div class="col-sm-3 padding">
				<div class="col-sm-4">직위</div>
				<select class="col-sm-8 form-control" id="pos_gbn_code">
					<option value=""></option>
					<c:forEach var="insaComVo" items="${ getInsaCom }">
					<c:if test="${ insaComVo.note eq 'pos_gbn_code' }">
						<option value="${ insaComVo.name }">${ insaComVo.name }</option>
					</c:if>
					</c:forEach>
				</select>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-4">입사일자</div>
				<div class="col-sm-7">
					<input type="text" class="form-control datePicker" id="join_day" disabled="disabled">
				</div>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-4">퇴사일자</div>
				<div class="col-sm-7">
					<input type="text" class="form-control datePicker" id="retire_day" disabled="disabled">
				</div>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-4">직종분류</div>
				<select class="form-control col-sm-8" id="job_type">
					<option value=""></option>
					<c:forEach var="insaComVo" items="${ getInsaCom }">
					<c:if test="${ insaComVo.note eq 'job_type' }">
						<option value="${ insaComVo.name }">${ insaComVo.name }</option>
					</c:if>
					</c:forEach>
				</select>
			</div>
		</div>
		
	
		<!-- 두번째 줄 끝 -->
		
		
		<div class="col-sm-12 padding" style="margin-bottom: 8px;"></div>

		<!-- 버튼 모음 시작 -->			
		<div class="col-sm-12 padding text-right btn_box">
<!-- 			<input type="button" id="btnTest" class="btn btn-danger" value="테스트"> -->
			<input type="button" class="btn btn-default" id="btnSubmit" value="검색" />
			<input type="button" id="btnReset" class="btn btn-default" value="초기화" />
			<input type="button" id="btnPrev" class="btn btn-default" value="이전" />
		</div>
		<!-- 버튼 모음 끝 -->
		
		
		
		<div class="col-sm-12 padding" style="margin-bottom: 8px;"></div>
		
		<!-- 직원 리스트 테이블 시작 -->
		<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0" style="text-align: center;">
	          <thead>
	            <tr class="theadText">
	              <th class="thText">사 번</th>
	              <th class="thText">성 명</th>
	              <th class="thText">주민번호</th>
	              <th class="thText">핸드폰번호</th>
	              <th class="thText">직 위</th>
	              <th class="thText">입사일자</th>
	              <th class="thText">퇴사일자</th>
	              <th class="thText">투입여부</th>
	              <th class="thText">연 봉</th>
	            </tr>
	          </thead>
	          <tbody>
	          
				<c:choose>
				
					<c:when test="${empty getMemberList}">
						<tr>
							<td colspan="9">검색된 데이터가 없습니다.</td>
						</tr>
					</c:when>
					
					<c:otherwise>
						<c:forEach items="${ getMemberList }" var="memberList">
							<tr>
								<td>${ memberList.sabun }</td>
								<td>
									<a href="/insa/update?sabun=${ memberList.sabun }">
										${ memberList.name }
									</a>
								</td>
								<td>${ memberList.reg_no }</td>
								<td>${ memberList.hp }</td>
								
								<c:choose>
									<c:when test="${ memberList.pos_gbn_code eq 'select' }">
										<td>미입력</td>
									</c:when>
									<c:otherwise>
										<td>${ memberList.pos_gbn_code }</td>
									</c:otherwise>
								</c:choose>
								
								<td>${ memberList.join_day }</td>
								<td>${ memberList.retire_day }</td>
								<td>${ memberList.put_yn }</td>
								<td>${ memberList.salary } 만원</td>
							</tr>
						</c:forEach>
					</c:otherwise>
					
				</c:choose>
	          	
	          </tbody>
	        </table>
       		<!-- 직원 리스트 테이블 끝 -->
	        
	   	<div class="row text-center">
			<div class="col-md-12">
				<nav>
					<ul class="pagination">
					
<%-- 						<c:if test="${ memberCount.prev eq true }"> --%>
							<li class="page-item">
								<a class="page-link" href="#" data-page="${ memberCount.nowPage - 1}">이전</a>
							</li>
<%-- 						</c:if> --%>
						
<%-- 						<c:forEach var="i" begin="${ memberCount.startPage }" end="${ memberCount.endPage }"> --%>
							<li class="page-item <c:if test="${ memberCount.nowPage eq i }">active</c:if>">
								<a class="page-link" href="#" data-page="${ i }">1</a>
							</li>
<%-- 						</c:forEach> --%>
							
<%-- 						<c:if test="${ memberCount.next eq true }"> --%>
							<li class="page-item">
								<a class="page-link" href="#" data-page="${ memberCount.nowPage + 1}">다음</a>
							</li>
<%-- 						</c:if> --%>
						
					</ul>
				</nav>
			</div>
		</div>
		
	      </div>
	
</body>
</html>