<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인사 관리 시스템</title>
<!-- bootstrp setting -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
	<link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	
	<script type="text/javascript" src="resources/js/httpRequest.js"></script>
	<script src="resources/js/insaInput.js"></script>
	<link rel="stylesheet" href="resources/css/insaInput.css" />
	
<script>
//프로필 미리 보기 이미지 기본 세팅
function setDefaultImg(){
	insaInput.proimg.src="resources/images/profile.jpg";
}
function showImg(profile){
	
	var reader = new FileReader();
	var file = profile.files[0]; //파일 배열로 저장 되기 때문에 첫번째 파일이 현재 선택된 파일
	if(file == undefined){ //파일 선택하지 않은경우
		setDefaultImg();
	}else{ //파일 선택한 경우
		reader.readAsDataURL(file);
		reader.onload = function(){
			var img = insaInput.proimg; //미리보기 이미지 띄우기
			img.src = reader.result;
		}
	}
}

function show_cmp(obj){
	var reader = new FileReader();
	var file = obj.files[0];
	reader.readAsDataURL(file);
	reader.onload = function(){
		var img = insaInput.cmp_reg_file_image;
		img.src = reader.result;
	}
}

function show_carrier(obj){
	var reader = new FileReader();
	var file = obj.files[0];
	reader.readAsDataURL(file);
	reader.onload = function(){
		var img = insaInput.carrier_file_image;
		img.src = reader.result;
	}
}

//비밀번호 일치 여부 출력
function checkPwd(){
	pwd=document.insaInput.pwd.value;
	pwd_check=document.insaInput.pwd_check.value;
	
	if(typeof pwd_check!="undefined"&&pwd_check.length>0){
		if(pwd == pwd_check){
			document.insaInput.checkpwd.value = "비밀번호가 일치합니다.";
			document.insaInput.checkpwd.style.color = 'green';
			document.insaInput.pwd.value=pwd_check;
			return true;
		}else{
			document.insaInput.checkpwd.value = "비밀번호가 일치하지 않습니다.";
			document.insaInput.checkpwd.style.color = 'red';
			return false;
		}
	}else{
		document.insaInput.checkpwd.value = "비밀번호확인을 입력하세요.";
		document.insaInput.checkpwd.style.color = 'red';
		return false;
	}
}

//공백 사용 제거
function noSpace(obj) { // 공백 사용 못하게
    var str_space = /\s/;  // 공백체크
    if(str_space.exec(obj.value)) { //공백 체크
        alert("해당 항목에는 공백을 사용할수 없습니다.\n공백은 자동적으로 제거 됩니다.");
        obj.focus();
        obj.value = obj.value.replace(' ',''); // 공백제거
        return false;
    }
}

//정규식 한글만 사용
function hangul(obj){
	var str_hangul = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
	if(str_hangul.exec(obj.value)){
		obj.focus();
		obj.value = obj.value.replace(/[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g,'');
		return false;
	}
}

//아작스 활용 인사 아이디 중복 체크
function insaIdCheck(){
	var id=document.insaInput.id.value;
	if(document.insaInput.id.value==""){
		alert('ID를 입력해주세요');
		return false;
	}
	document.insaInput.ids.value=id;
	var params='id='+id;
	sendRequest('insaIdCheck.do',params,showResult,'GET');
}

function showResult(){
	if(XHR.readyState==4){
		if(XHR.status==200){
			var data=XHR.responseText;
			 var msg=document.all.msg;
			 msg.innerHTML=data;
		}
	}
}
function cmp_reg_filename(obj){
	var num = obj.value.lastIndexOf("\\"); 
	var file_name = obj.value.substr(num+1);
	document.getElementById('cmp_reg_image_text').value=file_name;
}
function carrier_text_filename(obj){
	var num = obj.value.lastIndexOf("\\"); 
	var file_name = obj.value.substr(num+1);
	document.getElementById('carrier_text').value=file_name;
}
function profile_filename(obj){
	var num = obj.value.lastIndexOf("\\"); 
	var file_name = obj.value.substr(num+1);
	document.getElementById('profile').value=file_name;
}
//주민등록번호 앞자리 입력시 연령 계산
function showAge () { 
	var age=0; 
	var jcode=document.insaInput.jumin1.value; 
	if (jcode.length==6) { 
    	var yy=jcode.substr(0,2);    //생년 
    	var mm=jcode.substr(2,2);    //생월 
    	var dd=jcode.substr(4,2);    //생일 
  		if(jcode.substr(2,1)==0){ 
			mm=jcode.substr(3,1); 
  		} 
      	//생년 계산(80세 이전까지 적용하므로 첫자가 0~2이 아니면 1900년대/ 아니면 2000년대) 
      	today=new Date(); 
      	var i=jcode.substr(0,1); 
      	cc=(i>2) ? '0':'2'; 
     	var birthyear=cc+yy; 
      	var m=today.getMonth()+1; //today.getMonth()는 0~11을 반환하기 때문에 +1을 해줘야한다. 6개월 이전 기준 변수 
  		m=(m<0)?m+12:m; //m이 0보다 작으면 m+12를 크면 m을 반환 
      	var d=today.getDate(); 
      	var age=today.getYear()-birthyear; 
      	if (mm>m) { 
        	age++; 
  		}else if (mm==m){ 
        	if (dd<=d) { 
        		
			}else if(dd>d){ 
				age++; 
			} 
		} 
      document.insaInput.years.value=age; 
	} 
} 

// 연봉 입력시 콤마찍기
function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}
//콤마풀기
function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
}
//값 입력시 콤마찍기
function inputNumberFormat(obj) {
    obj.value = comma(uncomma(obj.value));
}
</script>

</head>
<body>
	<nav class="navbar navbar-default">
	  <div class="container">
	    <div class="navbar-header">
	      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>                        
	      </button>
	      <a class="navbar-brand" href="index.do" >PinoSoft</a>
	    </div>
	    <div class="collapse navbar-collapse" id="myNavbar">
	      <ul class="nav navbar-nav navbar-right">
	        <li><a href="insaInput.do">입력하기</a></li>
	        <li><a href="insaList.do">조회하기</a></li>
	      </ul>
	    </div>
	  </div>
	</nav>
	
	<div class="container col-sm-12 sub_content">
		<h2>직원 정보 입력</h2>
		<form name="insaInput" id="insaInput" action="insaInputProcess.do" method="post" enctype="multipart/form-data"> 
			<input type="hidden" name="ids">
			<div class="col-sm-12 padding text-right btn_box">
				<input type="submit" id="submit_btn" class="btn btn-primary" value="등록" />
				<input type="reset" class="btn btn-primary" value="초기화" />
				<input type="button" id="previewBtn" class="btn btn-default" value="이전" />

			</div>
			<div class="col-sm-12 warning_text"><p></p></div>
			<div class="col-sm-12 warning_text"><p></p></div>
			<div class="col-sm-12 warning_text"><p></p></div>
			<div class="col-sm-3 padding text-center profile_box">
				<div class='uploadResult'>
					<img width="200" height="200" id="proimg" src="resources/images/profile.jpg" />
				</div>
				<div class="filebox"> 
					<label for="ex_file"><i class="fas fa-camera"></i>&nbsp;사진올리기</label>
					<input type="hidden" id="profile" name="profile" />
					<input type="file" id="ex_file" name="profile_ex" onchange="showImg(this);profile_filename(this);" accept=".gif, .jpg, .png" /> 
				</div>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-3 text_area">* 사번</div>
				<div class="col-sm-9"><input type="text" class="form-control" id="sabun" disabled />
					<input type="hidden" name="sabun" id="sabunInt" />
					<input type="hidden" id="sabunCheck" value="${sabun}"/>
				</div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-3 text_area">* 한글성명</div>
				<div class="col-sm-9"><input type="text" class="form-control" id="name" name="name" onkeyup="noSpace(this);hangul(this);" /></div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-3 text_area">영문성명</div>
				<div class="col-sm-9"><input type="text" class="form-control" id="eng_name" name="eng_name" onkeyup="noSpace(this);" style="ime-mode:disabled" />
				</div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-3 text_area">* ID</div>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="id" name="id" onkeyup="noSpace(this)" style="ime-mode:inactive" />
					<div id="msg"></div>
				</div>
				<div class="col-sm-3">
				<input type="button" class="btn btn-default" value="중복체크" id="idCheckBtn" onclick="insaIdCheck()"/>
				</div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-3 text_area">* PW</div>
				<div class="col-sm-9">
					<input type="password" class="form-control" id="pwd" name="pwd" onkeyup="noSpace(this)" />
				</div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-3 text_area">* PW 확인</div>
				<div class="col-sm-9">
					<input type="password" class="form-control" id="pwd_check" onkeyup="checkPwd();noSpace(this)" />
					<input type="text" class="form-control" id="checkpwd" disabled="disabled" style="width: 250px; border: none; background: none;">
				</div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-3 text_area">전화번호</div>
				<div class="col-sm-9">
				<input type="text" class="form-control" id="phone" name="phone" onkeyup="noSpace(this)" maxlength="13" />
				</div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-3 text_area">*핸드폰번호</div>
				<div class="col-sm-9"><input type="text" class="form-control" id="hp" name="hp" onkeyup="noSpace(this)" maxlength="13" /></div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-3 text_area">*주민번호</div>
				<input type="hidden" id="reg_no" name="reg_no">
				<div class="col-sm-4">
					<input type="text" class="form-control" id="jumin1" onkeyup="noSpace(this);showAge();" maxlength="6" />
				</div>
				<div class="col-sm-5">
					<input type="password" class="form-control" id="jumin2" onkeyup="noSpace(this);" maxlength="7" />
				</div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-3 text_area">*연령</div>
				<div class="col-sm-9"><input type="text" class="form-control" id="years" name="years" maxlength="3" onkeyup="noSpace(this)"  placeholder="주민번호 입력시 계산 됩니다." readonly /></div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-3 text_area">*이메일</div>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="emailAddr" style="width:180px;" onkeyup="noSpace(this)" style="ime-mode:inactive" />
					<input type="hidden" name="email" id="email" />
				</div>
				<div class="col-sm-4">
					<select class="form-control" id="selectEmail"  style="width:130px;">
						<option value="">(선택)</option>
						<option value="naver.com">@naver.com</option>
						<option value="hanmail.net">@hanmail.net</option>
						<option value="nate.com">@nate.com</option>
						<option value="daum.net">@daum.net</option>
						<option value="hotmail.com">@hotmail.com</option>
						<option value="gmail.com">@gmail.com</option>
					</select>
				</div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-3 text_area">*직종체크</div>
				<div class="col-sm-3">
					<select class="form-control" id="job_type" name="job_type" style="width:100px;">
						<option value="">선택</option>
						<c:forEach var="dto" items="${list}">
							<c:if test="${dto.note == 'job_type'}">
								<option value="${dto.name}">${dto.name}</option>
							</c:if>
						</c:forEach>
					</select>
				</div>
				<div class="col-sm-2 text_area">*성별</div>
				<div class="col-sm-3">
					<select class="form-control" id="sex" name="sex" style="width:100px;">
						<option value="">선택</option>
						<c:forEach var="dto" items="${list}">
							<c:if test="${dto.note == 'sex'}">
								<option value="${dto.name}">${dto.name}</option>
							</c:if>
						</c:forEach>
					</select>
				</div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			
			<div class="col-sm-9 padding">
				<div class="col-sm-1 text_area">주소</div>
				<div class="col-sm-11 form-inline text-left address_box">
					<input type="text" class="form-control" id="zip" placeholder="우편번호" maxlength="6" />&nbsp;&nbsp;&nbsp;
					<input type="hidden" name="zip" id="zipHidden" />
					<input type="button" class="form-control" id="inputFormAddr" value="주소검색">&nbsp;&nbsp;&nbsp;
					<input type="text" class="form-control" id="addr1" name="addr1" placeholder="주소" style="width:450px;" />
					<input type="text" class="form-control" id="addr2" name="addr2" placeholder="상세주소" style="width:450px;" />
				</div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-3 text_area">*직위</div>
				<div class="col-sm-9">
					<select class="form-control" id="pos_gbn_code" name="pos_gbn_code">
						<option value="">선택</option>
						<c:forEach var="dto" items="${list}">
							<c:if test="${dto.note == 'pos_gbn_code'}">
								<option value="${dto.name}">${dto.name}</option>
							</c:if>
						</c:forEach>
					</select>
				</div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-3 text_area">*부서</div>
				<div class="col-sm-9">
					<select class="form-control" id="dept_code" name="dept_code">
						<option value="">선택</option>
						<c:forEach var="dto" items="${list}">
							<c:if test="${dto.note == 'dept_code'}">
								<option value="${dto.name}">${dto.name}</option>
							</c:if>
						</c:forEach>
					</select>
				</div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-3 text_area">연봉(만원)</div>
				<div class="col-sm-9">
					<input type="text" class="form-control" id="salary" placeholder="(만원)" maxlength="12" onkeyup="noSpace(this);inputNumberFormat(this);" onchange="inputNumberFormat(this);" 
						style="text-align:right;"/>
					<input type="hidden" id="salaryComma" name="salary" />
				</div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-3 text_area">*입사구분</div>
				<div class="col-sm-9">
					<select class="form-control" id="join_yn" name="join_yn">
						<option value="">선택</option>
						<c:forEach var="dto" items="${list}">
							<c:if test="${dto.note == 'join_yn'}">
								<option value="${dto.name}">${dto.name}</option>
							</c:if>
						</c:forEach>
					</select>
				</div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-3 text_area">등급</div>
				<div class="col-sm-9">
					<select class="form-control" id="gart_level" name="gart_level">
						<option value="">선택</option>
						<c:forEach var="dto" items="${list}">
							<c:if test="${dto.note == 'gart_level'}">
								<option value="${dto.name}">${dto.name}</option>
							</c:if>
						</c:forEach>
					</select>
				</div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-3 text_area">*투입여부</div>
				<div class="col-sm-9">
					<select class="form-control" id="put_yn" name="put_yn" >
						<option value="">선택</option>
						<c:forEach var="dto" items="${list}">
							<c:if test="${dto.note == 'put_yn'}">
								<option value="${dto.name}">${dto.name}</option>
							</c:if>
						</c:forEach>
					</select>
				</div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-3 text_area">군필여부</div>
				<div class="col-sm-9">
					<select class="form-control" id="mil_yn" name="mil_yn">
						<option value="">선택</option>
						<c:forEach var="dto" items="${list}">
							<c:if test="${dto.note == 'mil_yn'}">
								<option value="${dto.name}">${dto.name}</option>
							</c:if>
						</c:forEach>
					</select>
				</div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			<div class="layer">
			<div class="col-sm-3 padding">
				<div class="col-sm-3 text_area">군별</div>
				<div class="col-sm-9">
					<select class="form-control" id="mil_type" name="mil_type">
						<option value="">선택</option>
						<c:forEach var="dto" items="${list}">
							<c:if test="${dto.note == 'mil_type'}">
								<option value="${dto.name}">${dto.name}</option>
							</c:if>
						</c:forEach>
					</select>
				</div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-3 text_area">계급</div>
				<div class="col-sm-9">
					<select class="form-control" id="mil_level" name="mil_level">
						<option value="">선택</option>
						<c:forEach var="dto" items="${list}">
							<c:if test="${dto.note == 'mil_level'}">
								<option value="${dto.name}">${dto.name}</option>
							</c:if>
						</c:forEach>
					</select>
				</div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-3 text_area">입영일자</div>
				<div class="col-sm-9">
					<input type="text" class="form-control" id="datepicker1" name="mil_startdate" readonly="readonly">
				</div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			<div class="col-sm-3 padding">
				<div class="col-sm-3 text_area">전역일자</div>
				<div class="col-sm-9">
					<input type="text" class="form-control" id="datepicker2" name="mil_enddate" readonly="readonly"/>
				</div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			</div>
			<div class="col-sm-3 padding">
				<div class="col-sm-3 text_area">KOSA등록</div>
				<div class="col-sm-9">
					<select class="form-control" id="kosa_reg_yn" name="kosa_reg_yn">
						<option value="">선택</option>
						<c:forEach var="dto" items="${list}">
							<c:if test="${dto.note == 'kosa_reg_yn'}">
								<option value="${dto.name}">${dto.name}</option>
							</c:if>
						</c:forEach>
					</select>
				</div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-3 text_area">KOSA등급</div>
				<div class="col-sm-9">
					<select class="form-control" id="kosa_class_code" name="kosa_class_code">
						<option value="">선택</option>
						<c:forEach var="dto" items="${list}">
							<c:if test="${dto.note == 'kosa_class_code'}">
								<option value="${dto.name}">${dto.name}</option>
							</c:if>
						</c:forEach>
					</select>
				</div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-3 text_area">*입사일자</div>
				<div class="col-sm-9">
					<input type="text" class="form-control" id="datepicker3" name="join_day" readonly="readonly" />
	 			</div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-3 text_area">퇴사일자</div>
				<div class="col-sm-9">
					<input type="text" class="form-control" id="datepicker4" name="retire_day" readonly="readonly"/>
				</div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-3 text_area">사업자번호</div>
				<div class="col-sm-9"><input type="text" class="form-control" id="cmp_reg_no" name="cmp_reg_no" onkeyup="noSpace(this)" maxlength="10"></div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			
			<div class="col-sm-3 padding">
				<div class="col-sm-3 text_area">업체명</div>
				<div class="col-sm-9"><input type="text" class="form-control" id="crm_name" name="crm_name" onkeyup="noSpace(this)" /></div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			
			<div class="col-sm-6 padding">
				<div class="col-sm-2 text_area">사업자등록증</div>
				<div class="col-sm-10 form-inline text-left">
					<div class="filebox">
					<input type="text" class="form-control" id="cmp_reg_image_text" name="cmp_reg_image" readonly="readonly">
					<input type="button" class="form-control" data-toggle="modal" data-target="#cmpModal" value="미리보기">
						<label for="cmp_reg_image_ex">&nbsp;등록</label>
						<input type="file" id="cmp_reg_image_ex" name="cmp_reg_image_ex" onchange="cmp_reg_filename(this);show_cmp(this);"> 
					</div>
				</div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			<!-- Modal -->
			<div class="modal fade" id="cmpModal" role="dialog">
				<div class="modal-dialog">

					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">사업자등록증</h4>
						</div>
						<div class="modal-body">
						<img width="560" height="560" id="cmp_reg_file_image">
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">Close</button>
						</div>
					</div>

				</div>
			</div>
			
			<div class="col-sm-6 padding">
				<div class="col-sm-2 text_area">자기소개</div>
				<div class="col-sm-10"><textarea class="form-control" rows="2" name="self_intro" placeholder="100자 이내로 작성하세요." ></textarea></div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			
			<div class="col-sm-6 padding">
				<div class="col-sm-2 text_area">이력서</div>
				<div class="col-sm-10 form-inline text-left">
					<div class="filebox">
					<input type="text" class="form-control" id="carrier_text" name="carrier" readonly="readonly">
					<input type="button" class="form-control" data-toggle="modal" data-target="#carrierModal" value="미리보기">
					<label for="carrier_ex">파일업로드</label>
  					<input type="file" id="carrier_ex" name="carrier_ex" class="form-control" onchange="carrier_text_filename(this);show_carrier(this);">
					</div>
				</div>
				<div class="col-sm-12 warning_text"><p></p></div>
			</div>
			
			<!-- Modal -->
			<div class="modal fade" id="carrierModal" role="dialog">
				<div class="modal-dialog">

					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">이력서</h4>
						</div>
						<div class="modal-body">
							<img width="560" height="560" id="carrier_file_image">
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div> 
</body>
</html>



