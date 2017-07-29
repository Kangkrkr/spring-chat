<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Compiled and minified CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.1/css/materialize.min.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<!-- Compiled and minified JavaScript -->
<script src="http://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.1/js/materialize.min.js"></script>
<style type="text/css">
body {
  min-height: 100vh;
  width: 100%;
}
</style>
</head>
<body class="valign-wrapper" style="position: relative;">
	<div class="row z-depth-3" style="position:relative; margin-top: 30px; border: 6px solid #ccc; padding: 30px; border-radius: 10px;">
		<div class="row" style="margin-bottom: 100px; margin-left: 70px;">
			<h3 class="col s8 offset-s2">회원가입</h3>
		</div>
	    <form id="joinForm" name="joinForm" style="width: 520px; margin-top: -30px;">
		    <div class="row">
		        <div class="input-field col s9">
		          <input id="member_id" name="member_id" type="text" class="validate">
		          <label for="member_id">아이디*</label>
		        </div>
		        <div class="input-field col s3">
		        	<a class="waves-effect waves-light btn id-confirm" style="margin-top: 7px;">아이디확인</a>
		        </div>
		      </div>
		      <div class="row">
		        <div class="input-field col s12 m12 l12">
		          <input id="member_pw1" name="member_pw" type="password" class="validate">
		          <label for="member_pw1">패스워드*</label>
		        </div>
		      </div>
		      <div class="row">
		        <div class="input-field col s12">
		          <input id="member_pw2" type="password" class="validate">
		          <label for="member_pw2">패스워드 확인*</label>
		        </div>
		      </div>
		      <div class="row">
		        <div class="input-field col s12 m12 l12">
		          <input id="member_addr" name="member_addr" type="text">
		          <label for="member_addr">주소(선택)</label>
		        </div>
		      </div>
		      <div class="row">
		        <div class="input-field col s12 m12 l12">
		          <input id="member_mobile" name="member_mobile" type="text">
		          <label for="member_mobile">연락처*</label>
		        </div>
		      </div>
		      <div class="row">
		        <div class="input-field col s12 m12 l12">
		          <input id="member_name" name="member_name" type="text">
		          <label for="member_name">회원명*</label>
		        </div>
		      </div>
	    </form>
	    <button id="user-save-btn" class="btn waves-effect waves-light col s12 m12 l12" type="button" name="action" style="margin-bottom: 15px;"><b>회원가입</b></button>
	    <button class="btn waves-effect waves-light col s12 m12 l12" type="button" name="action" style="margin-bottom: 15px;" onclick="javascript:moveLoginPage();"><b>로그인페이지</b></button>
  </div>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		$('.id-confirm').click(function(){
			if(isEmpty($('#member_id').val()) == true) {
				alert('아이디를 입력해주세요.');
				return;
			}
			
			idCheckAjax(true);
		});
		
		$('#user-save-btn').click(function(e){
			e.preventDefault();
			
			joinCheck();
		});
	});
	
	function joinCheck() {
		var isJoinOk = true;
		
		if(isEmpty($('#member_id').val()) == true) {
			alert('아이디를 입력하세요.');
			isJoinOk = false;
			return;
		}
		
		if(isEmpty($('#member_pw1').val()) == true) {
			alert('패스워드를 입력하세요.');
			isJoinOk = false;
			return;
		}
		
		if($('#member_pw1').val() != $('#member_pw2').val()) {
			alert('패스워드 확인을 해주세요.');
			isJoinOk = false;
			return;
		}
		
		if(isEmpty($('#member_mobile').val()) == true) {
			alert('연락처를 입력하세요.');
			isJoinOk = false;
			return;
		}
		
		if(isEmpty($('#member_name').val()) == true) {
			alert('이름을 입력하세요.');
			isJoinOk = false;
			return;
		}
		
		if(idCheckAjax(false) == false){
			return;
		}

		if(isJoinOk == true) {
			$.ajax({
				type : 'POST',
				url : '/user/user_save.do',
				data: $("#joinForm").serialize(),
				contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
				dataType: 'json',
				async: false,
				success: function(json, status){
					alert(json.message);
					
					if(json.isjoinOk == 'Y') {
						location.href = '/index.do';
					}
				},
				error: function(data, status){
					alert('회원가입 도중 문제가 발생하였습니다.');
				}
			});
		}
	}
	
	function moveLoginPage() {
		location.href = "/user/user_login.do";
	}
	
	function isEmpty(data) {
		if(data == null || data == '')
			return true;
		else
			return false;
	}
	
	function idCheckAjax(isShowMessage) {
		var isJoinOk = true;
		
		$.ajax({
			type : 'POST',
			url : '/user/id_check.do',
			data: {member_id : $('#member_id').val()},
			contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
			dataType: 'json',
			async: false,
			success: function(json, status){
				if(isShowMessage == true) {
					alert(json.message);
				}
				
				if(json.idCheckOk == 'N') {
					if(!isShowMessage) {
						alert('아이디를 확인해 주세요.');
					}
					
					isJoinOk = false;
				}
			},
			error: function(data, status){
				alert('아이디확인 도중 문제가 발생하였습니다.');
				isJoinOk = false;
			}
		});
		
		return isJoinOk;
	}
</script>
</html>