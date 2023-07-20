<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Đăng ký</title>
<link
	href="/Assignment2/views/icon/fontawesome-free-6.2.1-web/css/all.min.css"
	rel="stylesheet" type="text/css" />
<link href="/Assignment2/views/css/signup.css" rel="stylesheet"
	type="text/css" />
<link href="/Assignment2/views/css/toast.css" rel="stylesheet"
	type="text/css" />
</head>
<body>
	<ul class="notifications"></ul>
	<div class="container">
		<div class="features"></div>
		<form action="/Assignment2/user/sign-up" method="POST">
			<h1>OE</h1>

			<div class="form-group">
				<input type="email" name="email" required />
				<div class="underline"></div>
				<label>Email</label>
			</div>
			<div class="form-group">
				<input type="password" name="password" required />
				<div class="underline"></div>
				<label>Mật khẩu</label>
			</div>
			<div class="form-group">
				<input type="password" name="repassword" required />
				<div class="underline"></div>
				<label>Xác nhận mật khẩu</label>
			</div>

			<button class="btn">Đăng ký</button>
			<small>Đã có tài khoản? <a
				href="/Assignment2/user/sign-in">Đăng nhập</a></small>
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
</body>
</html>