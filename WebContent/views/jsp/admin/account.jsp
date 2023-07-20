
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet"
	href="/Assignment2/views/icon/fontawesome-free-6.2.1-web/css/all.min.css" />
<link
	href="/Assignment2/views/icon/fontawesome-free-6.2.1-web/css/all.min.css"
	rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/Assignment2/views/css/style.css" />
<link rel="stylesheet" href="/Assignment2/views/css/info.css">
<link rel="stylesheet" href="/Assignment2/views/css/toast.css" />
<%@ include file="/views/jsp/admin/header.jsp"%>
<main>
	<ul class="notifications"></ul>
	<div class="tab-wrap account">
		<input type="radio" id="tab10" name="tabGroup" class="tab" checked />
		<label for="tab10">Thông tin cá nhân</label> <input type="radio"
			id="tab11" name="tabGroup" class="tab" /> <label for="tab11">Đổi
			mật khẩu</label>
		<div class="tab__content">
			<section>
				<div class="container">
					<div class="profile">Thông tin cá nhân</div>
					<form method="POST">
						<div class="form">
							<div class="details personal">
								<div class="fields">
									<div class="input-field">
										<label>usereditname</label> <input type="text" disabled
											placeholder="Nhập họ tên" value="${useredit.id}" name="id"
											required autofocus />
									</div>
									<div class="input-field">
										<label>Họ tên</label> <input type="text"
											placeholder="Nhập họ tên" value="${useredit.fullname}"
											name="fullname" required />
									</div>

									<c:if test="${not empty useredit.birthday}">
										<fmt:formatDate var="usereditBirthday"
											value="${useredit.birthday}" pattern="yyyy-MM-dd" />
									</c:if>
									<div class="input-field">
										<label>Ngày sinh</label> <input type="date" min='1899-01-01'
											max='2012-01-01' placeholder="Chọn ngày sinh" name="birthday"
											value="${usereditBirthday}" required />
									</div>
									<div class="input-field">
										<label>Email</label> <input type="text" disabled
											placeholder="Nhập email" value="${useredit.email}"
											name="email" required />
									</div>
									<div class="input-field">
										<label for="gender">Giới tính</label> <select id="gender"
											name="gender" required>
											<option value="" disabled selected>Chọn giới tính</option>
											<c:if test="${useredit.gender == true}">
												<option value="male" selected>Nam</option>
												<option value="female">Nữ</option>
											</c:if>
											<c:if test="${useredit.gender == false}">
												<option value="male">Nam</option>
												<option value="female" selected>Nữ</option>
											</c:if>
											<c:if test="${useredit.gender == null}">
												<option value="male">Nam</option>
												<option value="female">Nữ</option>
											</c:if>
										</select>
									</div>
									<c:if test="${not empty useredit.registeredDate}">
										<fmt:formatDate var="registeredDate"
											value="${useredit.registeredDate}" pattern="dd/MM/yyyy" />
									</c:if>
									<div class="input-field">
										<label>Ngày đăng ký</label> <input type="text"
											name="registeredDate" required value="${registeredDate}"
											disabled />
									</div>
								</div>
							</div>
							<div class="save">
								<button class="btnSave">
									<span class="btnText">Lưu thông tin</span>
								</button>
							</div>
						</div>
					</form>
				</div>
			</section>
		</div>
		<div class="tab__content">
			<section>
				<div class="container">
					<div class="profile">Thay đổi mật khẩu</div>

					<form method="POST">
						<div class="form">
							<div class="details personal">
								<div class="fields">
									<div class="input-full input-field">
										<label>Mật khẩu hiện tại</label> <input type="password"
											class="password" id="password" name="password"
											placeholder="Nhập mật khẩu hiện tại" required /> <span
											class="show-btn"><i class="fas fa-eye"></i></span>
									</div>
									<div class="input-full input-field">
										<label>Mật khẩu mới</label> <input type="password"
											class="password" id="newpassword" name="newpassword"
											placeholder="Nhập mật khẩu mới" required /> <span
											class="show-btn"><i class="fas fa-eye"></i></span>
									</div>
									<div class="input-full input-field">
										<label>Xác nhận mật khẩu mới</label> <input type="password"
											class="password" id="rePassword" name="repassword"
											placeholder="Xác nhận mật khẩu mới" required /> <span
											class="show-btn"><i class="fas fa-eye"></i></span>
									</div>
								</div>
							</div>
							<div class="savePassword">
								<button class="btnSavePassword">
									<span class="btnText">Lưu thông tin</span>
								</button>
							</div>
						</div>
					</form>
				</div>
				<ul class="notifications"></ul>
			</section>
		</div>
	</div>
</main>
<script src="/Assignment2/views/javascript/toast.js"></script>
<c:if test="${not empty success}">
	<script type="text/javascript">
	if (window.location.href.includes('/Assignment2/admin/edit-profile?selected=tab10')) {
	    setTimeout(function() {
	        window.location.replace('/Assignment2/admin/edit-profile?selected=tab10');
	    }, 5000);
	} else if (window.location.href.includes('/Assignment2/admin/edit-profile?selected=tab11')) {
	    setTimeout(function() {
	        window.location.replace('/Assignment2/admin/edit-profile?selected=tab11');
	    }, 5000);
	}
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
      showButtons[index].style.color = "#4070f4";
      passwordInput.focus();
    } else {
      // Ngược lại, chuyển đổi nó trở lại mật khẩu
      passwordInput.type = 'password';
      showButtons[index].style.color = "#141c2c";
      passwordInput.focus();
    }
  });
});
document.querySelector("#tab10").addEventListener("change", function(event) {
    // Khởi tạo URLSearchParams
    var searchParams = new URLSearchParams(window.location.search);
    searchParams.set('selected', "tab10");

    // Cập nhật URL mới với tham số đã thêm
    var newUrl = window.location.protocol + "//" + window.location.host + window.location.pathname + '?' + searchParams.toString();
    window.history.pushState({path:newUrl},'',newUrl);
});

document.querySelector("#tab11").addEventListener("change", function(event) {
    // Khởi tạo URLSearchParams
    var searchParams = new URLSearchParams(window.location.search);
    searchParams.set('selected', "tab11");

    // Cập nhật URL mới với tham số đã thêm
    var newUrl = window.location.protocol + "//" + window.location.host + window.location.pathname + '?' + searchParams.toString();
    window.history.pushState({path:newUrl},'',newUrl);
});
</script>
<%@ include file="/views/jsp/admin/footer.jsp"%>
