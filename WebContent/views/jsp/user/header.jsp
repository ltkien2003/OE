<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<header>
	<a href="/Assignment2/user/index" class="logo">OE</a> <input type="checkbox" id="menu-bar" />
	<label for="menu-bar"> <i class="fa-solid fa-bars"></i>
	</label>
	<nav class="navbar">
		<ul>
			<li><a href="/Assignment2/user/index">Trang chủ</a></li>
			<li><a href="/Assignment2/user/about">Giới thiệu</a></li>
			<li><a href="/Assignment2/user/favorite">Yêu thích</a></li>
			<li><a href="/Assignment2/user/edit-profile?selected=tab1">Tài khoản</a>
				<ul>
						<li><a href="#" id="info" onclick="switchTab('tab1')">Thông tin cá nhân</a></li>
						<li><a href="#" id="change-password" onclick="switchTab('tab2')">Thay đổi mật khẩu</a></li>
					<li><a href="/Assignment2/user/sign-out" onclick="deleteCookie('userId', '/Assignment2/user');">Đăng xuất</a></li>
				</ul></li>
		</ul>
	</nav>
</header>
<script type="text/javascript">
function deleteCookie(name, path) {
	  var expires = 'expires=Thu, 01 Jan 1970 00:00:00 UTC';
	  var cookiePath = path ? 'path=' + path : '';

	  document.cookie = name + '=;' + expires + ';' + cookiePath;
	}
</script>
