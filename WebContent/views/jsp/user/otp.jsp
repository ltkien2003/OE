<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Đăng nhập</title>
<link
	href="/Assignment2/views/icon/fontawesome-free-6.2.1-web/css/all.min.css"
	rel="stylesheet" type="text/css" />
<link href="/Assignment2/views/css/login.css" rel="stylesheet"
	type="text/css" />
<link href="/Assignment2/views/css/toast.css" rel="stylesheet"
	type="text/css" />
<link href="/Assignment2/views/css/otp.css" rel="stylesheet"
	type="text/css" />
</head>
<body>
	<ul class="notifications"></ul>
	<div class="container">
		<div class="features"></div>
		<form action="/Assignment2/user/otp" method="POST">
			<h1>OE</h1>

			<div class="form-group">
				<input type="number" name="otp" required />
				<div class="underline"></div>
				<label>Mã OTP</label>
			</div>

			<button class="btn">Xác minh</button>
		</form>
	</div>
	<script src="/Assignment2/views/javascript/toast.js"></script>
	<c:if test="${not empty error}">
		<script type="text/javascript">
			createToast('error', "${error}");
		</script>
	</c:if>
	<c:if test="${not empty success}">
		<script type="text/javascript">
			createToast('success', "${success}");
		</script>
	</c:if>
	<script type="text/javascript">
		if (document.cookie.indexOf('verify=true') !== -1) {
			setTimeout(function() {
				window.location.href = '/Assignment2/user/sign-in';
			}, 5000);
		}
	</script>
</body>
</html>