<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
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
	
	 label {
	 	font-size: 12px;
	 }
 
	 div .location-top {
	 	position: absolute;
	 	left: 50px;
	 	top: 20px;
	 }
	
</style>

<script>

function noSpace(obj) {
    var str_space = /\s/;
    if(str_space.exec(obj.value)) {
        alert("해당 항목에는 공백을 사용할수 없습니다.\n공백은 자동적으로 제거 됩니다.");
        obj.focus();
        obj.value = obj.value.replace(' ','');
        return false;
    }
}

function checkPwd(){
 	var pwd = document.getElementById("pwd").value;
 	var pwd_check = $("#ck-pwd").val();
 	
 	if(pwd_check != "undefined" && pwd_check.length > 0) {
 		if (pwd == pwd_check) {
 			$("#pw-span").text("비밀번호가 일치합니다.").css("font-size", "5px").css("color", "green");
 			pwd = pwd_check;
 			return true;
 		} else {
 			$("#pw-span").text("비밀번호가 일치하지 않습니다.").css("font-size", "5px").css("color", "red");
 			pwd = pwd_check;
 			return false;
 		}
 	} else {
			$("#pw-span").text("비밀번호를 확인해주세요.").css("font-size", "5px").css("color", "red");
			pwd = pwd_check;
 		return false;
 	}
}

// function phoneTest() {
// 	var phoneVal = document.getElementById("phone").value;
// 	var key = phoneVal.replace(/\-/g,'');
// 	var spanId = document.getElementById("phone-span");
// 	var tel = "";
// 	onlyNum(key, spanId);
	
// 	if(key.substring(0,2) == "02") {
// 	       if(key.length < 3) {
// 	           return key;
// 	       } else if(key.length < 6) {
// 	           tel += key.substr(0, 2);
// 	           tel += "-";
// 	           tel += key.substr(2);
// 	       } else if(key.length < 10) {
// 	           tel += key.substr(0, 2);
// 	           tel += "-";
// 	           tel += key.substr(2, 3);
// 	           tel += "-";
// 	           tel += key.substr(5);
// 	       } else {
// 	           tel += key.substr(0, 2);
// 	           tel += "-";
// 	           tel += key.substr(2, 4);
// 	           tel += "-";
// 	           tel += key.substr(6);
// 	       }
// 			this.value(tel);
// 		} else {
// 			if(key.length < 4) {
// 				return key;
// 			} else if (key.length < 7) {
// 				tel += key.substr(0, 3);
// 				tel += "-";
// 				tel += key.substr(3, 3);
// 			} else if (key.length < 15) {
// 				tel += key.substr(0, 3);
// 				tel += "-";
// 				tel += key.substr(3, 3);
// 				tel += "-";
// 				tel += key.substr(6);
// 			}
// 			this.value(tel);
// 		}
// }

// var check = 0;

// function onlyNum(key, spanId) {
// 	 var onlyNum = /^[0-9]+$/;
// 	 var spanId = document.getElementById("span-id");
// //	 console.log("ck : " + key + spanId );
// 	 if (!onlyNum.test(key)) {
// 		 spanId.text("숫자만 입력하세요");
// 		 spanId.css("font-size", "5px");
// 		 spanId.css("color", "red");
// 		 check = 1;
// 	 } else {
// 		 spanId.text("");
// 		 check = 0;
// 	 }
// 	 if (spanId == "") {
// 		 spanId.text("");
// 		 check = 0;
// 	 }
// }

$(document).ready(function() {
	
	var checkInput = [0, 0, 0, 0, 0, 0, 0, 0];
	
	$("#email").blur(function() {
		checkInput[3] = 0;
	});
	
	$("#id").keyup(function() {
// 		var id = $("#id").val();
// 		if (id == null || id == "") {
// 			alert("ID를 입력하세요.")
// 			$("#id").focus();
// 			return;
// 		}
		var url = "/insa/dup_id";
		var id = $("input[name=id]").val();
// 		console.log(id);
		var data = {
				"id" : id
		}
// 		console.log(data);
		$.ajax({
			"type" : "post",
			"url" : url,
			"headers" : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "post"
			},
			"dataType" : "text",
			"data" : id,
			"success" : function(rData) {
				var result = rData.trim();
// 				console.log(result);
				if (result == "fail") {
					$("#id-span").text("아이디 중복").css("font-size", "5px").css("color", "red");
				} else if (result == "success") {
					$("#id-span").text("아이디 사용가능").css("font-size", "5px").css("color", "green");
				}
			}
		})
	});
	
	$("select[name=mil_yn]").change(function() {
		var mil_yn = $("#mil_yn").val();
// 		console.log(mil_yn);
		var strHtml = "";
		if (mil_yn == "군필") {
			strHtml += '<div class="col-md-3">'
				+ '<label class="col-md-4" style="text-align: center;margin-top: 5px;">군별</label>'
				+ '<select id="mil_type" name="mil_type" class="col-md-8 form-control">'
				+ '<c:forEach var="insaComVo" items="${ getInsaCom }">'
				+ '<c:if test="${ insaComVo.note eq 'mil_type' }">'
				+ '<option value="${ insaComVo.name }">${ insaComVo.name }</option>'
				+ '</c:if>'
				+ '</c:forEach>'
				+ '</select>'
				+ '</div>'
				+ '<div class="col-md-3">'
				+ '<label class="col-md-4" style="text-align: center;margin-top: 5px;">계급</label>'
				+ '<select id="mil_level" name=mil_level class="col-md-8 form-control">'
				+ '<c:forEach var="insaComVo" items="${ getInsaCom }">'
				+ '<c:if test="${ insaComVo.note eq 'mil_level' }">'
				+ '<option value="${ insaComVo.name }">${ insaComVo.name }</option>'
				+ '</c:if>'
				+ '</c:forEach>'
				+ '</select>'
				+ '</div>';
				+ '<div class="col-sm-3 padding">'
				+ '<div class="col-sm-4 text_area">입영일자</div>'
				+ '<input type="text" class="col-sm-7 form-control datePicker" disabled="disabled" id="mil_startdate" name="mil_startdate">'
				+ '</div>'
				+ '<div class="col-sm-3 padding">'
				+ '<div class="col-sm-4 text_area">전역일자</div>'
				+ '<input type="text" class="col-sm-7 form-control datePicker" disabled="disabled" id="mil_enddate" name="mil_enddate">'
				+ '</div>';
		} 
		if (mil_yn == "미필") {
			strHtml += '<div class="col-md-3">'
				+ '<label class="col-md-4" style="text-align: center;margin-top: 5px;">군별</label>'
				+ '<select class="col-sm-8 form-control" id="mil_type" name="mil_type" disabled="disabled">'
				+ '<option value="N">해당없음</option>'
				+ '</select>'
				+ '</div>'
				+ '<div class="col-sm-3">'
				+ '<label class="col-md-4" style="text-align: center;margin-top: 5px;">계급</label>'
				+ '<select class="col-sm-8 form-control" id="mil_level" name="mil_level" disabled="disabled">'
				+ '<option value="N">해당없음</option>'
				+ '</select>'
				+ '</div>';
				+ '<div class="col-sm-3 padding">'
				+ '<div class="col-sm-4 text_area">입영일자</div>'
				+ '<input type="text" class="col-sm-7 form-control" disabled="disabled" id="mil_startdate" name="mil_startdate" value="해당없음">'
				+ '</div>'
				+ '<div class="col-sm-3 padding">'
				+ '<div class="col-sm-4 text_area">전역일자</div>'
				+ '<input type="text" class="col-sm-7 form-control" disabled="disabled" id="mil_enddate" name="mil_enddate" value="해당없음">'
				+ '</div>';	
		}
		$(".mil_test").html(strHtml);
	});
	
	var check = 0;
	$.datepicker.setDefaults({
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
	
	 $("#datepicker1").datepicker({
		 onClose: function(selectedDate) {
			 $("#datepicer2").datepicker("option", "minDate", selectedDate);
		 }
	 });
	 
     $("#datepicker2").datepicker({
    	 onClose: function(selectedDate) {
    		 $("#datepicker1").datepicker("option", "maxDate", selectedDate)
    	 }
     });
     
     $("#datepicker3").datepicker();
     
     $("#datepicker4").datepicker();
     
     $("#btn-upload").on("click", function() {
    	 $("#upload_cmp").trigger("click");
     });
     
     $("#btn-upload-file").on("click", function() {
    	 $("#upload_file").trigger("click");
     });
     
     $("#btn-profile").on("click", function() {
    	 $("#profile").trigger("click");
     });
     
     $("#name").keyup(function() {
    	 var name = $("#name").val();
//     	 console.log(name);
    	 var ko =  /^[가-힣]+$/;
//     	 console.log(ko.test(name));
    	 if (!ko.test(name)) {
			$("#name-span").text("한글만 입력하세요.").css("font-size", "5px").css("color", "red");
			check = 1;
    	 } else {
    		 $("#name-span").text("");
    		 check = 0;
    	 }
    	 if (name == "") {
    		 $("#name-span").text("");
    		 check = 0;
    	 }
     });
     
     $("#eng_name").keyup(function() {
    	 var eng_name = $("#eng_name").val();
//     	 console.log("eng_name: " + eng_name);
    	 var eng = /^[a-zA-Z\s]+$/;
//     	 console.log("ck: " + eng.test(eng_name));
    	if(!eng.test(eng_name)) {
    		$("#eng_name-span").text("영어만 입력하세요").css("font-size", "5px").css("color", "red");
    		check = 1;
    	} else {
    		$("#eng_name-span").text("");
    		check = 0;
    	}
    	if (eng_name == "") {
    		$("#eng_name-span").text("");
    		check = 0;
    	}
     });
     
     $("#id").keyup(function() {
    	 var id = $("#id").val();
    	 var spanId = "#id-span";
    	 engAndNum(id, span_id);
     });
     
     $("#email").keyup(function() {
    	 var email = $("#email").val();
    	 var spanId = "#email-span";
    	 engAndNum(id, span_id);
     });
     
     function engAndNum(value, span_id) {
    	 var value = value;
    	 var engAndNum =  /^[a-zA-Z0-9]+$/;
    	 if(!engAndNum.test(value)) {
     		$(span_id).text("영어/숫자만 입력하세요").css("font-size", "5px").css("color", "red");
     		check = 1;
     	} else {
     		$(span_id).text("");
     		check = 0;
     	}
     	if (id == "") {
     		$(span_id).text("");
     		check = 0;
     	}
     }
     
     $("#phone").keyup(function() {
    	 var phone = $("#phone").val();
    	 var key = phone.replace(/\-/g,'');
    	 var spanId = "#phone-span";
    	 var tel = "";
    	 onlyNum(key, spanId);
    	 console.log("전화번호" + key.substring(0,2));
    	 console.log("전화번호" + (key.substring(0,2) == "02"));
    	if(key.substring(0,2) == "02") {
	        if(key.length < 3) {
	            return key;
	        } else if(key.length < 6) {
	            tel += key.substr(0, 2);
	            tel += "-";
	            tel += key.substr(2);
	        } else if(key.length < 10) {
	            tel += key.substr(0, 2);
	            tel += "-";
	            tel += key.substr(2, 3);
	            tel += "-";
	            tel += key.substr(5);
	        } else {
	            tel += key.substr(0, 2);
	            tel += "-";
	            tel += key.substr(2, 4);
	            tel += "-";
	            tel += key.substr(6);
	        }
    		$(this).val(tel);
    	} else {
    		if(key.length < 4) {
    			return key;
    		} else if (key.length < 7) {
    			tel += key.substr(0, 3);
    			tel += "-";
    			tel += key.substr(3, 3);
    		} else if (key.length < 15) {
    			tel += key.substr(0, 3);
    			tel += "-";
    			tel += key.substr(3, 3);
    			tel += "-";
    			tel += key.substr(6);
    		}
    		$(this).val(tel);
    	}
     });
     
     $("#hp").keyup(function() {
    	 var hp = $("#hp").val();
    	 var key = hp.replace(/\-/g,'');
//     	 console.log("hp: " + hp);
    	 var spanId = "#hp-span";
    	 var tel = "";
    	 onlyNum(key, spanId);
    	 if(key.substring(0, 3) != "010") {
    		 if(key.length < 4) {
    			 return key;
    		 } else if(key.length < 7) {
    			 tel += key.substr(0, 3);
    			 tel += "-";
    			 tel += key.substr(3);
    		 } else if (key.length < 12) {
    			 tel += key.substr(0, 3);
    			 tel += "-";
    			 tel += key.substr(3, 3);
    			 tel += "-";
    			 tel += key.substr(6);
    		 }
    		 $(this).val(tel);
    	 }
    	 
    	 if(key.substring(0,3) == "010") {		
    		 if(key.length < 4) {
    			 return key;
    		 } else if(key.length < 8) {
    			 tel += key.substr(0, 3);
    			 tel += "-";
    			 tel += key.substr(3);
    		 } else if (key.length < 12) {
    			 tel += key.substr(0, 3);
    			 tel += "-";
    			 tel += key.substr(3, 4);
    			 tel += "-";
    			 tel += key.substr(7);
    		 }
    		 $(this).val(tel);
    	 }
    	 
     });
     
     var reg_no_array = new Array();

     $("#reg_no").on("keyup", function(e) {
    	 var reg_no = $("#reg_no").val();
    	 var key = reg_no.replace(/\-/g,'');
    	 var spanId = "#reg_no-span";
    	 var num = "";
    	 var ch_num = "";
    	 var star_num = "";
   		 var key_num = e.key;
   		 var hidden_num = "";
   		if (key.length < 7) {
   		 $(this).val(key);
   		 ch_num = key;
	   	 } else if (key.length >= 7 && key.length < 14) {
	  			 reg_no_array.push(key_num);
	   		 post_reg_no = key.substr(6, 7);
	   		 for(i = 0; i < post_reg_no.length-1; i++) {
	   			 star_num += "*";
	   		 }
	   		 
	   		 num += key.substr(0, 6);
	   		 num += "-";
	   		 num += key.substr(6, 1);
	   		 num += star_num;
	   		 num += key.substr(12, 2);
	   		 $(this).val(num);
	   		 
	   		 ch_num += key.substr(0, 7);
	   		 ch_num += reg_no_array.join("");
	   	 }
// 	   	 console.log("reg_no_array" + reg_no_array.join(""));
	   	 hidden_num += key.substr(0, 6);
	   	 hidden_num += "-";
	   	 hidden_num += reg_no_array.join("");
	   	 $("#reg_no-hidden").val(hidden_num);
	   	 onlyNum(ch_num, spanId);
//    	 console.log($("#reg_no-hidden").val() + "ck");
    	 
    	 if (ch_num.length == 14) {
    		var age = agecalc(hidden_num) + 1;
    		$("#years").val(age);
    	 }
     });
     
     function agecalc(reg_no) {
    	 var num = reg_no.replace(/\-/g,'');
    	 var pre_reg = num.substr(0, 6);
    	 var post_reg = num.substr(6, 7);
    	 var reg_year = pre_reg.substr(0, 2);
    	 var ch_year = post_reg.substr(0, 1);
    	 var age = "";
    	 var full_year = "";
    	 var date = new Date();
    	 var year = date.getFullYear();
    	 if (!(reg_year.substr(0, 1) >= 0 && reg_year.substr(0, 1) <= 2)) {
    		 full_year = "19" + reg_year;
    	 } else {
    		 if (ch_year == 1 || ch_year == 2) {
    			 full_year = "18" + reg_year;
    		 } else {
    			 full_year = "20" + reg_year;
    		 }
    	 }
    	 age = parseInt(year) - parseInt(full_year);
//     	 console.log("year: " + year);
//     	 console.log("full_year: " + full_year);
//     	 console.log("age: " + age);
    	 return age;
     }
     
     $("#cmp_reg_no").keyup(function() {
    	 var cmp_reg_no = $("#cmp_reg_no").val();
    	 var spanId = "#cmp_reg_no-span";
    	 var key = cmp_reg_no.replace(/\-/g,'');
    	 var number = "";
    	 onlyNum(cmp_reg_no, spanId);
	 		if(key.length < 4) {
				return key;
			} else if (key.length < 7) {
				number += key.substr(0, 3);
				number += "-";
				number += key.substr(3, 3);
			} else if (key.length < 15) {
				number += key.substr(0, 3);
				number += "-";
				number += key.substr(3, 2);
				number += "-";
				number += key.substr(5);
			}
 		$(this).val(number);
     });

     function onlyNum(key, spanId) {
    	 var onlyNum = /^[0-9]+$/;
//     	 console.log("ck : " + key + spanId );
    	 if (!onlyNum.test(key)) {
    		 $(spanId).text("숫자만 입력하세요").css("font-size", "5px").css("color", "red");
    		 check = 1;
    	 } else {
    		 $(spanId).text("");
    		 check = 0;
    	 }
    	 if (spanId == "") {
    		 $(spanId).text("");
    		 check = 0;
    	 }
     }

     function daumPostcode() {
         new daum.Postcode({
             oncomplete: function(data) {
                 var addr = '';

                 if (data.userSelectedType === 'R') {
                     addr = data.roadAddress;
                 } else {
                     addr = data.jibunAddress;
                 }
                 $("#zip").val(data.zonecode);
                 $("#addr1").val(addr);
                 $("#addr2").focus();
             }
         }).open();
     }
     
     $("#btn-search").click(function() {
    	 daumPostcode();
     });

     $("#show-salary").keyup(function() {
    	 var salary = $("#show-salary").val();
    	 var temp = salary.replace(/\,/g,'');
    	 var span_id = "#salary-span";
    	 var comma_salary = temp.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
//     	 console.log("comma: " + comma_salary);
    	 $("#show-salary").val(comma_salary);
    	 var no_comma_salary = comma_salary.replace(/\,/g,'');
    	 $("#salary").val(no_comma_salary);
//     	 console.log("no-salary : " + $("#salary").val());
    	 onlyNum(no_comma_salary, span_id);
     });

     $("#profile").change(function() {
//     	 console.log("filename: " + this.files[0].name);
    	 var filename = this.files[0].name;
    	 
    	 var url = "/file/fileUpload";
    	
    	 var inputFile = $("#profile");
     	 var files = inputFile[0].files;
	 	 var formData = new FormData();
	 	 formData.append("uploadFile", files[0]);
	 	 
			 $.ajax({
				 "url" : url,
				 "contentType" : false,
				 "processData" : false,
				 "data" : formData,
				 "type" : "POST",
				 success : function(receivedData) {
					 alert("파일을 업로드 하였습니다.");
// 					 console.log("receivedData: " + receivedData);
					$("#profile").attr("data-img", receivedData);
					$("#hidden_profile").val(receivedData);
				 },
				 error : function() {
					 alert("업로드에 실패하였습니다.");
				 }
			 });
    		 
     });
     
     $("#modal-cmp").click(function() {
    	 $("#btn_modal").trigger("click");
     });
     
     $("#upload_cmp").change(function(e) {
//     	 console.log("filename: " + this.files[0].name);
    	 var filename = this.files[0].name;
    	 $("#cmp_reg_image").val(filename);
    	 
    	var inputFile = $("#upload_cmp");
    	url = "/file/fileUpload";
    	
    	var file_name = "#modal-cmp";
    	var hidden_name = "#cmp_hidden_image";
    	
    	 uploadAjax(url, inputFile, file_name, hidden_name); 
     });
     
     $("#modal-cmp").click(function() {
    	 var file_name = $("#modal-cmp").attr("data-img");
		 var div = "";
		 div += "<div id='div_img'>";
		 div += "<img src='/file/display?fileName=" + file_name + "' style='width:300px; height: auto;'>";
		 div += "</div>";
		 $("#modal_body").append(div);
    	 
     }); 

     $("#modal_carrier").click(function() {
    	 $("#btn_modal").trigger("click");
     });

     $("#upload_file").change(function() {
    	 var filename = this.files[0].name;
    	 $("#carrier").val(filename);
    	 
    	var inputFile = $("#upload_file");
    	
    	url = "/file/fileUpload";
    	
    	var file_name = "#modal_carrier";
    	var hidden_name = "#hidden_carrier";
    	uploadAjax(url, inputFile, file_name, hidden_name); 
     });
     
     $("#modal_carrier").click(function() {
    	 var file_name = $("#modal_carrier").attr("data-img");
// 		 console.log("file_name: " + file_name);
		 var div = "";
		 div += "<div id='div_img'>";
		 div += "<img src='/file/display?fileName=" + file_name + "' style='width:300px; height: auto;'>";
		 div += "</div>";
		 $("#modal_body").append(div);
     });

     $("#btn_modal_close").click(function() {
    	 $("#div_img").remove();
     });

     function uploadAjax(url, inputFile, file_name, hidden_name) {
    	 
    	 var files = inputFile[0].files;
    	 var formData = new FormData();
//     	 console.log("files[0]: " + files[0]);
    	 formData.append("uploadFile", files[0]);
    	 
   		 $.ajax({
   			 "url" : url,
   			 "contentType" : false,
   			 "processData" : false,
   			 "data" : formData,
   			 "type" : "POST",
   			 success : function(receivedData) {
   				 alert("파일을 업로드 하였습니다.");
//    				 console.log("receivedData: " + receivedData);
   				$(file_name).attr("data-img", receivedData);
   				$(hidden_name).val(receivedData);
   			 },
   			 error : function() {
   				 alert("업로드에 실패하였습니다.");
   			 }
   		 });
     }
     
     $("#upload-file").change(function(e) {
//     	 console.log(this.files[0].name);
    	 var filename = this.files[0].name;
    	 $("#carrier").val(filename);
     });
     
     $("#profile").change(function() {
    	 var filename = this.files[0].name;
//     	 console.log(filename);
    	 $("#img_span").val(filename);
     });	
     
     $("#btnPrev").click(function() {
    	 location.href="/";
     });
     
     $("#btnSubmit").click(function() {
    	 var preEmail = $("#email").val();
    	 var backEmail = $("#email-back").val();
    	 var email = preEmail + backEmail;
    	 $("input[name=email]").val(email);
    	 
    	 $("#formAction").submit();
     });
     
 	var message = "${message}";
 	if (message == "success_input") {
 		alert("직원 입력을 완료 하였습니다.")
 	}
 	
     
});
</script>

<title>인사관리시스템</title>

</head>
<body>
<div>
	<div class="container-fluid">
		<div class="row">
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
	<form action="/insa/input" method="post" id="formAction">
		<div>
			<p style="font-size: 25px;margin: 30px 0 0 10px;">직원 상세 정보</p>
			<div style="float: right;margin-right: 20px; margin-bottom: 10px;">
				<input type="button" value="등록" class="btn btn-default" id="btnSubmit">
				<input type="reset" class="btn btn-default" value="초기화" />
				<input type="button" id="btnPrev" value="이전" class="btn btn-default">
			</div>
		</div>
		<hr style="margin-top: 40px;">
		<div class="col-md-12">
			<div class="col-md-3" style="text-align: center;">
				<img alt="basic-img" src="/resources/images/profileimage.jpg" style="height: 250px;">
				<br>
				<input type="button" value="사진올리기" class="btn btn-default" id="btn-profile" data-img="" >
				<input type="file" id="profile" style="display: none;">
				<input type="hidden" name="profile" id="hidden_profile">
				<div><span id="img_span" style="z-index: 100000;"></span></div>
			</div>
			<div class="col-md-9 form-group">
				<div class="col-md-4">
					<label class="col-md-4" style="text-align: center;margin-top: 5px;"><span style="color: red;">*</span>사번</label>
					<input type="text" id="sabun" name="sabun" class="col-md-8 form-control" readonly="readonly" >
				</div>
				<div class="col-md-4">
					<label class="col-md-4" style="text-align: center;margin-top: 5px;"><span style="color: red;">*</span>한글성명</label>
					<div class="location-top"><span id="name-span" style="z-index: 100000;"></span></div>
					<input type="text" id="name" name="name" class="col-md-8 form-control" placeholder="한글만 입력하세요.">
				</div>
				<div class="col-md-4">
					<label class="col-md-4" style="text-align: center;margin-top: 5px;">영문성명</label>
					<div class="location-top"><span id="eng_name-span" style="z-index: 100000;"></span></div>
					<input type="text" id="eng_name" name="eng_name" class="col-md-8 form-control" placeholder="영어만 입력하세요.">
				</div>
			</div>
			<div class="col-md-9 form-group">
				<div class="col-md-4">
					<label class="col-md-4" style="text-align: center; margin-top: 5px;"><span style="color: red;">*</span>아이디</label>
					<div class="location-top"><span id="id-span" style="z-index: 100000;"></span></div>
					<input type="text" id="id" name="id" class="col-md-8 form-control" placeholder="영어와 숫자만 입력하세요.">
				</div>
				<div class="col-md-4">
					<label class="col-md-4" style="text-align: center; margin-top: 5px;"><span style="color: red;">*</span>패스워드</label>
					<input type="password" id="pwd" name="pwd" class="col-md-8 form-control">
				</div>
				<div class="col-md-4">
					<label class="col-md-4" style="text-align: center; margin-top: 5px;"><span style="color: red;">*</span>패스워드 확인</label>
					<div class="location-top"><span id="pw-span" style="z-index: 100000;" onkeyup="checkPwd();noSpace(this)"></span></div>
					<input type="password" id="ck-pwd" class="col-md-8 form-control" onkeyup="checkPwd();noSpace(this)">
				</div>
			</div>
			<div class="col-md-9 form-group">
				<div class="col-md-4">
					<label class="col-md-4" style="text-align: center;margin-top: 5px;">전화번호</label>
					<div class="location-top"><span id="phone-span" style="z-index: 100000;"></span></div>
					<input type="text" id="phone" name="phone" class="col-md-8 form-control" placeholder="-을(를) 빼고 입력하세요." />
				</div>
				<div class="col-md-4">
					<label class="col-md-4" style="text-align: center;margin-top: 5px;"><span style="color: red;">*</span>핸드폰번호</label>
					<div class="location-top"><span id="hp-span" style="z-index: 100000;"></span></div>
					<input type="text" id="hp" name="hp" class="col-md-8 form-control" placeholder="-을(를) 빼고 입력하세요.">
				</div>
				<div class="col-md-4">
					<label class="col-md-4" style="text-align: center;margin-top: 5px;">주민번호</label>
					<div class="location-top"><span id="reg_no-span" style="z-index: 100000;"></span></div>
					<input type="text" id="reg_no" class="col-md-8 form-control" placeholder="-을(를) 빼고 입력하세요." maxlength="14">
					<input type="hidden" id="reg_no-hidden" name="reg_no" >
				</div>
			</div>
			<div class="col-md-9 form-group">
				<div class="col-md-4">
					<label class="col-md-4" style="text-align: center;margin-top: 5px;">연령</label>
					<input type="text" id="years" name="years" class="col-md-8 form-control">
				</div>
				<div class="col-md-4">
					<div class="col-md-6">
						<label class="col-md-4" style="text-align: center;margin-top: 5px;padding: 0;"><span style="color: red;">*</span>이메일</label>
						<div class="location-top"><span id="email-span" style="z-index: 100000;"></span></div>
						<input type="text" id="email" class="col-md-8 form-control">
					</div>
					<div class="col-md-6">
						<label class="col-md-2" style="text-align: center;margin-top: 5px;padding: 0;"></label>
						<select class="col-md-10 form-control" id="email-back">
							<c:forEach var="insaCom" items="${ getInsaCom }">
								<c:if test="${ insaCom.note eq 'email' }">
								<option value="${ insaCom.name }">${ insaCom.name }</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
					<input type="hidden" name="email">
				</div>
				<div class="col-md-4">
					<div class="col-md-6">
						<label class="col-md-6" style="text-align: center;margin-top: 5px;padding: 0;">직종체크</label>
						<select id="job_type" name="job_type" class="col-md-6 form-control" >
							<c:forEach var="insaCom" items="${ getInsaCom }">
								<c:if test="${ insaCom.note eq 'job_type' }">
								<option value="${ insaCom.name }">${ insaCom.name }</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
					<div class="col-md-6">
						<label class="col-md-4" style="text-align: center;margin-top: 5px;padding: 0;">성별</label>
						<select class="form-control col-md-8" id="sex" name="sex">
							<c:forEach var="insaCom" items="${ getInsaCom }">
								<c:if test="${ insaCom.note eq 'sex' }">
								<option value="${ insaCom.name }">${ insaCom.name }</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			
			<div class="col-md-9 form-group">
				<div class="col-md-4">
					<label class="col-md-4" style="text-align: center;margin-top: 5px;">주소</label>
					<input type="text" class="col-md-5 form-control" placeholder="우편번호"  id="zip" name="zip">
					<input type="button" value="주소검색" id="btn-search" class="btn btn-default col-md-3">
				</div>
				
				<div class="col-md-4">
					<input type="text" id="addr1" name="addr1" placeholder="주소" class="col-md-12 form-control">
				</div>
				
				<div class="col-md-4">
					<input type="text" id="addr2" name="addr2" placeholder="세부주소" class="col-md-12 form-control">
				</div>
			</div>
			
			<div class="col-md-9 form-group">
				<div class="col-md-4">
					<label class="col-md-4" style="text-align: center;margin-top: 5px;">직위</label>
						<select id="pos_gbn_code" name="pos_gbn_code" class="col-md-8 form-control">
							<c:forEach var="insaCom" items="${ getInsaCom }">
								<c:if test="${ insaCom.note eq 'pos_gbn_code' }">
								<option value="${ insaCom.name }">${ insaCom.name }</option>
								</c:if>
							</c:forEach>
						</select>
				</div>
				<div class="col-md-4">
					<label class="col-md-4" style="text-align: center;margin-top: 5px;">부서</label>
						<select id="dept_code" name="dept_code" class="col-md-8 form-control">
							<c:forEach var="insaCom" items="${ getInsaCom }">
								<c:if test="${ insaCom.note eq 'dept_code' }">
								<option value="${ insaCom.name }">${ insaCom.name }</option>
								</c:if>
							</c:forEach>
						</select>
				</div>
				<div class="col-md-4" >
					<label class="col-md-4" style="text-align: center; margin-top: 5px;">연봉(만원)</label>
					<div class="location-top"><span id="salary-span" style="z-index: 100000;"></span></div>
					<input type="text" id="show-salary" class="col-md-8 form-control" placeholder="(만원)" style="text-align: right">
					<input type="hidden" name="salary" id="salary">
				</div>
			</div>
		</div>
		<div class="col-md-12 for-group">
			<div class="col-md-3">
				<label class="col-md-4" style="text-align: center;margin-top: 5px;">입사구분</label>
						<select id="join_gbn_code" name="join_gbn_code" class="col-md-8 form-control">
							<c:forEach var="insaCom" items="${ getInsaCom }">
								<c:if test="${ insaCom.note eq 'join_gbn_code' }">
								<option value="${ insaCom.name }">${ insaCom.name }</option>
								</c:if>
							</c:forEach>
						</select>
			</div>
			<div class="col-md-3">
				<label class="col-md-4" style="text-align: center;margin-top: 5px;">등급</label>
						<select id="gart_level" name="gart_level" class="col-md-8 form-control">
							<c:forEach var="insaCom" items="${ getInsaCom }">
								<c:if test="${ insaCom.note eq 'gart_level' }">
								<option value="${ insaCom.name }">${ insaCom.name }</option>
								</c:if>
							</c:forEach>
						</select>
			</div>
			<div class="col-md-3">
				<label class="col-md-4" style="text-align: center;margin-top: 5px;">투입여부</label>
					<select id="put_yn" name="put_yn" class="col-md-8 form-control">
						<c:forEach var="insaCom" items="${ getInsaCom }">
							<c:if test="${ insaCom.note eq 'put_yn' }">
							<option value="${ insaCom.name }">${ insaCom.name }</option>
							</c:if>
						</c:forEach>
					</select>
			</div>
			<div class="col-md-3">
				<label class="col-md-4" style="text-align: center;margin-top: 5px;">군필여부</label>
				<select id="mil_yn" name="mil_yn" class="col-md-8 form-control">
					<c:forEach var="insaCom" items="${ getInsaCom }">
						<c:if test="${ insaCom.note eq 'mil_yn' }">
						<option value="${ insaCom.name }">${ insaCom.name }</option>
						</c:if>
					</c:forEach>
				</select>
			</div>
		</div>
		
		<div class="col-md-12 for-group" style="margin-bottom: 8px;"></div>
		
		<div class="col-md-12 for-group">
		<div class="mil_test">
			<div class="col-md-3">
				<label class="col-md-4" style="text-align: center;margin-top: 5px;">군별</label>
				<select id="mil_type" name="mil_type" class="col-md-8 form-control">
					<c:forEach var="insaCom" items="${ getInsaCom }">
						<c:if test="${ insaCom.note eq 'mil_type' }">
						<option value="${ insaCom.name }">${ insaCom.name }</option>
						</c:if>
					</c:forEach>
				</select>
			</div>
			<div class="col-md-3">
				<label class="col-md-4" style="text-align: center;margin-top: 5px;">계급</label>
				<select id="mil_level" name=mil_level class="col-md-8 form-control">
					<c:forEach var="insaCom" items="${ getInsaCom }">
						<c:if test="${ insaCom.note eq 'mil_level' }">
						<option value="${ insaCom.name }">${ insaCom.name }</option>
						</c:if>
					</c:forEach>
				</select>
			</div>
			</div>
			
			<div class="col-md-3">
				<label class="col-md-4" style="text-align: center;margin-top: 5px;">입영일자</label>
				<input type="text" id="datepicker1" name="mil_startdate" class="col-md-7 form-control" readonly="readonly">
			</div>
			<div class="col-md-3">
				<label class="col-md-4" style="text-align: center;margin-top: 5px;">전역일자</label>
				<input type="text" id="datepicker2" name="mil_enddate"  class="col-md-7 form-control" readonly="readonly">
			</div>
		</div>
		
		<div class="col-md-12 for-group" style="margin-bottom: 8px;"></div>
		
		<div class="col-md-12 for-group">
			<div class="col-md-3">
				<label class="col-md-4" style="text-align: center;margin-top: 5px;">KOSA등록</label>
				<select id="kosa_reg_yn" name=kosa_reg_yn class="col-md-8 form-control">
					<c:forEach var="insaCom" items="${ getInsaCom }">
						<c:if test="${ insaCom.note eq 'kosa_reg_yn' }">
						<option value="${ insaCom.name }">${ insaCom.name }</option>
						</c:if>
					</c:forEach>
				</select>
			</div>
			<div class="col-md-3">
				<label class="col-md-4" style="text-align: center;margin-top: 5px;">KOSA등급</label>
				<select id="kosa_class_code" name=kosa_class_code class="col-md-8 form-control">
					<c:forEach var="insaCom" items="${ getInsaCom }">
						<c:if test="${ insaCom.note eq 'kosa_class_code' }">
						<option value="${ insaCom.name }">${ insaCom.name }</option>
						</c:if>
					</c:forEach>
				</select>
			</div>
			<div class="col-md-3">
				<label class="col-md-4" style="text-align: center;margin-top: 5px;"><span style="color: red;">*</span>입사일자</label>
				<input type="text" id="datepicker3" class="col-md-7 form-control" readonly="readonly" name="join_day">
			</div>
			<div class="col-md-3">
				<label class="col-md-4" style="text-align: center;margin-top: 5px;">퇴사일자</label>
				<input type="text" id="datepicker4" class="col-md-7 form-control" readonly="readonly" name="retire_day">
			</div>
		</div>
		
		<div class="col-md-12 for-group" style="margin-bottom: 8px;"></div>
		
		<div class="col-md-12 for-group">
			<div class="col-md-3">
				<label class="col-md-4" style="text-align: center;margin-top: 5px;">사업자번호</label>
				<div class="location-top"><span id="cmp_reg_no-span" style="z-index: 100000;"></span></div><input class="col-md-8 form-control" type="text" id="cmp_reg_no" name="cmp_reg_no" maxlength="12">
			</div>
			<div class="col-md-3">
				<label class="col-md-4" style="text-align: center;margin-top: 5px;">업체명</label>
				<input type="text" id="crm_name" name="crm_name" class="col-md-8 form-control">
			</div>
			<div class="col-md-3">
				<label class="col-md-4" style="text-align: center;margin-top: 5px;">사업자등록증</label>
				<input type="text" id="cmp_reg_image" class="col-md-8 form-control" readonly="readonly">
				<input type="hidden" name="cmp_reg_image" id="cmp_hidden_image">
			</div>
			<div class="col-md-3">
				<div class="col-md-12">
					<div class="col-md-6">
						<input type="button" value="미리보기" id="modal-cmp" class="col-md-12 btn btn-default" data-img="">
					</div>
					<div class="col-md-6">
						<input type="button" value="등록" id="btn-upload" class="col-md-12 btn btn-default">
						<input type="file" value="등록" id="upload_cmp"  style="display: none;" multiple="multiple">
					</div>
				</div>
			</div>
		</div>
		
		<div class="col-md-12 for-group" style="margin-bottom: 8px;"></div>
		
		<div class="col-md-12 for-group">
			<div class="col-md-6">
				<label class="col-md-2" style="text-align: center;margin-top: 5px;">자기소개</label>
				<textarea class="col-md-10 form-control" placeholder="100자 내외로 적으시오" cols="10" id="self_intro" name="self_intro"></textarea>
			</div>
			<div class="col-md-3">
				<label class="col-md-4" style="text-align: center;margin-top: 5px;">이력서</label>
				<input type="text" id="carrier" class="col-md-8 form-control" readonly="readonly">
				<input type="hidden" name="carrier" id="hidden_carrier">
			</div>
			<div class="col-md-3">
				<div class="col-md-12">
					<div class="col-md-6">
						<input type="button" value="미리보기" id="modal_carrier" class="col-md-12 btn btn-default"  data-img="">
					</div>
					<div class="col-md-6">
						<input type="button" value="파일업로드" id="btn-upload-file" class="col-md-12 btn btn-default">
						<input type="file" value="파일업로드" id="upload_file" style="display: none;">
					</div>
				</div>
			</div>
		</div>
		
		<button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal"  id="btn_modal" style="display: none;">Open Modal</button>
		  <div class="modal fade" id="myModal" role="dialog">
		    <div class="modal-dialog">
		    
		      Modal content
		      <div class="modal-content">
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		          <h4 class="modal-title">미리보기</h4>
		        </div>
		        <div class="modal-body" id="modal_body" style="text-align: center;">
		        </div>
		        <div class="modal-footer">
		          <button type="button" class="btn btn-default" data-dismiss="modal" id="btn_modal_close">Close</button>
		        </div>
		      </div>
		      
		    </div>
 		 </div>
	</form>
</div>
</body>
</html>