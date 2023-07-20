<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<footer class="footer">
	<div class="footer__addr">
		<h1 class="logo">Admin</h1>

		<h2>Liên hệ</h2>

		<address>
			Số 288, Nguyễn Văn Linh, phường An Khánh, quận Ninh Kiều, Tp. Cần
			Thơ.<br /> <a class="footer__btn" href="mailto:oe@gmail.com">Email</a>
		</address>
	</div>

	<ul class="footer__nav">
		<li class="nav__item">
			<h2 class="nav__title">Liên kết hữu ích</h2>

			<ul class="nav__ul">
				<li><a href="#" class="video">Videos</a></li>
				<li><a href="#" class="users">Users</a></li>
				<li><a href="#" class="reports">Reports</a></li>
			</ul>
		</li>
		<li class="nav__item">
			<h2 class="nav__title">Mạng xã hội</h2>

			<ul class="nav__ul">
				<li><a href="#">Facebook</a></li>

				<li><a href="#">Twitter</a></li>

				<li><a href="#">Instagram</a></li>
			</ul>
		</li>
		<li class="nav__item">
			<h2 class="nav__title">Giới thiệu</h2>

			<ul class="nav__ul">
				<li><a href="/Assignment2/views/jsp/admin/about.jsp">Về OE</a></li>
			</ul>
		</li>
		<li class="nav__item">
			<h2 class="nav__title">Ngôn ngữ</h2>

			<ul class="nav__ul">
				<li><a href="#">Tiếng Việt</a></li>
				<li><a href="#">English</a></li>
			</ul>
		</li>
	</ul>

	<div class="legal">
		<p>Copyright © 2023 OE Inc. All rights reserved.</p>
	</div>
</footer>
<jsp:include page="/views/jsp/admin/popup.jsp"></jsp:include>
<script src="/Assignment2/views/javascript/firebase-app.js"></script>
<script src="/Assignment2/views/javascript/firebase-storage.js"></script>
<script src="/Assignment2/views/javascript/switchtab.js"></script>
<script src="/Assignment2/views/javascript/modal.js"></script>
<script src="/Assignment2/views/javascript/toast.js"></script>



