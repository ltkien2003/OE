<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Quên mật khẩu</title>
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
		<form action="/Assignment2/user/forgot-password" method="POST">
			<h1>OE</h1>

			<div class="form-group">
				<input type="email" name="email" required />
				<div class="underline"></div>
				<label>Email</label>
			</div>

			<button class="btn">Tiếp tục</button>
		</form>
	</div>

	<script src="/Assignment2/views/javascript/toast.js"></script>
	<c:if test="${not empty error}">
		<script type="text/javascript">
			createToast('error', "${error}");
		</script>
	</c:if>
	<script type="text/javascript">
		var form = document.querySelector("form");
		form.addEventListener("submit", function(event) {
			var formData = new FormData(form);
			var xhr = new XMLHttpRequest();
			xhr.open(form.method, form.action, true);
			history.pushState({}, "", form.action);
			xhr.send(formData);
		});
	</script>
</body>
</html>