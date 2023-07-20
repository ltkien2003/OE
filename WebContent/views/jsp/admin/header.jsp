<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<header>
		<a href="/Assignment2/admin/index" class="logo">Admin</a> <input type="checkbox" id="menu-bar" />
		<label for="menu-bar"> <i class="fa-solid fa-bars"></i>
		</label>
		<nav class="navbar">
			<ul>
				<li><a href="/Assignment2/admin/index">Trang chủ</a></li>
				<li><a href="/Assignment2/admin/about">Giới thiệu</a></li>
				<li><a class="video">Videos</a></li>
				<li><a class="users">Users</a></li>
				<li><a class="reports">Reports</a></li>
				<li><a href="/Assignment2/admin/edit-profile?selected=tab10">Tài khoản</a>
									<ul>
						<li><a href="/Assignment2/admin/edit-profile?selected=tab10" id="info" onclick="switchTab('tab10')">Thông tin cá nhân</a></li>
						<li><a href="/Assignment2/admin/edit-profile?selected=tab11" id="change-password" onclick="switchTab('tab11')">Thay đổi mật khẩu</a></li>
					<li><a href="/Assignment2/admin/sign-out" onclick="deleteCookie('adminId', '/Assignment2/admin');">Đăng xuất</a></li>
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