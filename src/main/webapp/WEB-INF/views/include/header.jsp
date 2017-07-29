<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Compiled and minified CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.1/css/materialize.min.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel='stylesheet' type='text/css' href='/resources/css/common.css'>
<!-- Compiled and minified JavaScript -->
<script src="http://code.jquery.com/jquery-1.12.4.min.js"
  integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ="
  crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.1/js/materialize.min.js"></script>
</head>
<body>
<header>
	<nav>
	  <div class="nav-wrapper">
	    <a href="#" class="brand-logo">이름도 미정임</a>
	    <ul id="nav-mobile" class="right hide-on-med-and-down">
	      <li><span><b>안녕하세요 ${reqVo.getMember_id()}님</b></span></li>
	      <li><a href="#">이거</a></li>
	      <li><a href="#">저거</a></li>
	      <li><a href="#">그거</a></li>
	      <li><a href="/user/logout.do">로그아웃</a></li>
	    </ul>
	  </div>
	</nav>
</header>