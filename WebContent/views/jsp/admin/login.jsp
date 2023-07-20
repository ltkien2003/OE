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
<link href="/Assignment2/views/css/toast.css"
	rel="stylesheet" type="text/css" />
</head>
<body>
	<ul class="notifications"></ul>
	<div class="container">
		<div class="features"></div>
		<form action="/Assignment2/admin/sign-in" method="post">
			<h1>Admin</h1>

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

			<div class="checkbox-container">
				<input type="checkbox" id="remember" /> <label for="remember">Giữ
					đăng nhập</label> <a href="/Assignment2/admin/forgot-password">Quên mật khẩu</a>
			</div>

			<button class="btn">Đăng nhập</button>
		</form>
	</div>
	<script src="/Assignment2/views/javascript/toast.js"></script>
	<c:if test="${not empty error}">
		<script type="text/javascript">
			createToast('error', "${error}");
		</script>
	</c:if>
</body>
</html>