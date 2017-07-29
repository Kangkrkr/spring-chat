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
	<div class="row z-depth-3" style="position:relative; margin-top: -20px; border: 6px solid #ccc; padding: 30px; border-radius: 10px;">
		<div class="row" style="margin-bottom: 100px; margin-left: 25px;">
			<h3 class="col s8 offset-s2">개발중입니다</h3>
		</div>
	    <form id="loginForm" name="loginForm" style="width: 520px; margin-top: -30px;">
		    <div class="row">
		        <div class="input-field col s12 m12 l12">
		          <input id="member_id" name="member_id" type="text" class="validate">
		          <label for="member_id">아이디</label>
		        </div>
		      </div>
		      <div class="row">
		        <div class="input-field col s12 m12 l12">
		          <input id="member_pw" name="member_pw" type="password" class="validate">
		          <label for="member_pw">패스워드</label>
		        </div>
		      </div>
	    </form>
	    <button class="btn waves-effect waves-light col s12 m12 l12" type="submit" name="action" style="margin-bottom: 15px;" onclick="javascript:loginCheck();"><b>로그인</b></button>
	    <button class="btn waves-effect waves-light col s12 m12 l12" type="submit" name="action" style="margin-bottom: 15px;" onclick="javascript:moveJoinPage();"><b>회원가입</b></button>
  </div>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		/*
		var position_x = $('#login-form').width();
		var position_y = $('#login-form').height();
		
		var body_position_x = $('body').width();
		var body_position_y = $('body').height();
		
		$('#login-form').animate({
	        left: (body_position_x - position_x)/2 - position_x
	    });
		*/
		
		$('#member_pw').keydown(function(e) {
		    if (e.keyCode == 13) {
		    	loginCheck();
		    }
		});
	});
	
	function loginCheck() {
		var member_id = $('#member_id').val();
		var member_pw = $('#member_pw').val()
		
		if(member_id == '' || member_id == null) {
			alert('아이디를 입력하세요.');
			return;
		}
		
		if(member_pw == '' || member_pw == null) {
			alert('패스워드를 입력하세요.');
			return;
		}
		
		$.ajax({
			type : 'POST',
			url : '/user/login.do',
			data: $("#loginForm").serialize(),
			contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
			dataType: 'json',
			success: function(json, status){
				alert(json.message);
				
				if(json.isLoginOk == 'Y') {
					location.href = '/index.do';
				}
			},
			error: function(data, status){
				alert('로그아웃 도중 문제가 발생하였습니다.');
			}
		});
	}

	function moveJoinPage() {
		location.href = "/user/user_join.do";
	}
</script>
</html>