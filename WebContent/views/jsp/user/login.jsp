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
</head>
<body>
	<ul class="notifications"></ul>
	<div class="container">
		<div class="features"></div>
		<form action="/Assignment2/user/sign-in" method="POST">
			<h1>OE</h1>

			<div class="form-group">
				<input type="email" name="email" required />
				<div class="underline"></div>
				<label>Email</label>
			</div>
			<div class="form-group">
				<input type="password" class="password" name="password" required />
				<span class="show-btn"><i class="fas fa-eye"></i></span>
				<div class="underline"></div>
				<label>Mật khẩu</label>
			</div>
			<div class="checkbox-container">
				<input type="checkbox" id="remember" /> <label for="remember">Giữ
					đăng nhập</label> <a href="/Assignment2/user/forgot-password">Quên mật
					khẩu</a>
			</div>

			<button class="btn">Đăng nhập</button>
			<small>Chưa có tài khoản? <a href="/Assignment2/user/sign-up">Đăng
					ký</a></small>
		</form>
	</div>

	<script src="/Assignment2/views/javascript/toast.js"></script>
	<c:if test="${not empty error}">
		<script type="text/javascript">
			createToast('error', "${error}");
		</script>
	</c:if>
	<script type="text/javascript">
const passwordInputs = document.querySelectorAll('.password');
const showButtons = document.querySelectorAll('.show-btn');

// Lặp qua tất cả các input mật khẩu
passwordInputs.forEach((passwordInput, index) => {
  // Lắng nghe sự kiện click trên nút hiển thị
  showButtons[index].addEventListener('click', () => {
    // Nếu input là mật khẩu, chuyển đổi nó thành văn bản
    if (passwordInput.type === 'password') {
      passwordInput.type = 'text';
      showButtons[index].style.color = "#4158d0";
      passwordInput.focus();
    } else {
      // Ngược lại, chuyển đổi nó trở lại mật khẩu
      passwordInput.type = 'password';
      showButtons[index].style.color = "#141c2c";
      passwordInput.focus();
    }
  });
});

</script>
</body>
</html>