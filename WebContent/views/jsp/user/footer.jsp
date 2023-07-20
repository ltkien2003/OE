<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<form method="post">
	<div class="popup">
	<section class="modal hidden">
		<div class="flex">
			<button class="btn-close">⨉</button>
		</div>
		<div class="modal-content">
			<h3>Chia sẻ Video</h3>
			<p>Nhập email vào ô bên dưới</p>
		</div>

		<input type="email" style="text-transform: none;" name="shareToEmail" id="email" placeholder="oe@gmail.com" required/>
		<button class="btn">Gửi</button>
	</section>
</div>
</form>
<div class="overlay hidden"></div>
<footer class="footer">
	<div class="footer__addr">
		<h1 class="logo">OE</h1>

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
				<li><a
					href="/Assignment2/views/jsp/user/index.jsp">Trang
						chủ</a></li>
				<li><a
					href="/Assignment2/views/jsp/user/account.jsp">Tài
						khoản</a></li>
				<li><a
					href="/Assignment2/views/jsp/user/login.jsp">Đăng
						nhập</a></li>
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
				<li><a
					href="/Assignment2/views/jsp/user/about.jsp">Về
						OE</a></li>
			</ul>
		</li>
	</ul>

	<div class="legal">
		<p>Copyright © 2023 OE Inc. All rights reserved.</p>
	</div>
</footer>
<script src="/Assignment2/views/javascript/switchtab.js"></script>
<script src="/Assignment2/views/javascript/modal.js"></script>