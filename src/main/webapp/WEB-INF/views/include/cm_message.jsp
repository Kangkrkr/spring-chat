<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<script type="text/javascript">
	var message = "${message}";
	var returnUrl = "${returnUrl}";
	
	if(message != '' && message != null) {
		alert(message);
	}
	
	if(returnUrl != '' && returnUrl != null) {
		location.href = returnUrl;
	}
</script>
</body>
</html>