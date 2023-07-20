<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="/Assignment2/views/css/popup.css">
<link rel="stylesheet" href="/Assignment2/views/css/toast.css">
<ul class="notifications">
</ul>

<div class="popup">
	<section class="modal hidden">
		<div class="flex">
			<button class="btn-close">⨉</button>
		</div>
		<div class="modal-content">
			<h3>Chia sẻ Video</h3>
			<p>Nhập email vào ô bên dưới</p>
		</div>

		<input type="email" id="email" placeholder="oe@gmail.com" />
		<button class="btn">Gửi</button>
	</section>
</div>
<div class="overlay hidden"></div>
<div class="popup1 hidden">
	<div class="tab-wrap">
		<input type="radio" id="tab1" name="tabGroup1" class="tab" checked />
		<label for="tab1">Video Edition</label> <input type="radio" id="tab2"
			name="tabGroup1" class="tab" /> <label for="tab2">Video List</label>
		<div class="tab__content">
			<form method="POST" onsubmit="formVideo(event)" id="form-video">
				<div class="wrapper">
					<img id="videoImage" name="videoImage" id="videoImage" src="${video.poster}" alt="Image" />
						<input type="file" id="fileImage" style="display:none;" onchange="loadImage(event);" accept="image/*">
					<div class="form-wrapper">
						<div class="input-field">
							<label>Youtube ID</label> <input type="text"
								placeholder="Nhập youtube id" value="${video.id}" name="videoId" required />
						</div>
						<div class="input-field">
							<label>Video Title</label> <input type="text"
								placeholder="Nhập video title" value="${video.title}" name="videoTitle" required />
						</div>
						<div class="input-field">
							<label>View Count</label> <input type="number"
								placeholder="Số người xem" value="${video.views}" name="videoViews" required />
						</div>
						<c:if test="${not empty video.uploadDate}">
							<fmt:formatDate var="uploadDate"
							   value="${video.uploadDate}" pattern="dd/MM/yyyy" />
						</c:if>
						<div class="input-field">
							<label>Ngày upload</label> <input type="text" disabled
								value="${uploadDate}" id="uploadDate" name="uploadDate" required />
						</div>
						<div class="checkbox-container">
							<label class="checkbox"> <input type="radio"
								${video.active?'checked':''} class="checkbox__input"
								name="active" id="active1" value="true" required checked /> <span
								class="checkbox__box"></span> Active
							</label> <label class="checkbox"> <input type="radio"
								${video.active?'':'checked'} value="false" class="checkbox__input"
								name="active" id="active2" /> <span class="checkbox__box"></span>
								Inactive
							</label>
						</div>
					</div>
					<div class="input-field description">
						<label>Description</label>
						<textarea name="description" cols="30" rows="5">${video.description}</textarea>
					</div>
				</div>
				<div class="button-container">
					<button name="actionVideo" value="createvideo">Create</button>
					<button name="actionVideo" value="updatevideo">Update</button>
					<button name="actionVideo" value="deletevideo">Delete</button>
					<button name="actionVideo" value="resetvideo">Reset</button>
				</div>
			</form>
		</div>
		<div class="tab__content">
			<table class="content-table" id="video-table">
				<thead>
					<tr>
						<th>Youtube Id</th>
						<th>Video Title</th>
						<th>View Count</th>
						<th>Status</th>
						<th></th>
					</tr>
				</thead>
				<tbody>

					<c:if test="${not empty videoAll}">
						<c:forEach var="v" items="${videoAll}">
							<tr>
								<td>${v.id}</td>
								<td>${v.title}</td>
								<td>${v.views}</td>
								<td>${v.active}</td>
								<td><button>Edit</button></td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>
	</div>
</div>
<div class="popup2 hidden">
	<div class="tab-wrap">
		<input type="radio" id="tab5" name="tabGroup3" class="tab" checked />
		<label for="tab5">User Edition</label> <input type="radio" id="tab6"
			name="tabGroup3" class="tab" /> <label for="tab6">User List</label>
		<div class="tab__content">
			<div class="wrapper">
				<div class="form-user-wrapper">
					<form method="POST" onsubmit="formUser(event)" id="form-user">
						<div class="input-field">
							<label>Username</label> <input type="text"
								placeholder="Nhập username" value="${user.id}" name="id"
								required />
						</div>
						<div class="input-field">
							<label>Password</label> <input type="password"
								value="${user.password}" placeholder="Nhập password"
								name="password" class="password" required /> <span
								class="show-btn"
								onclick="togglePassword(this.previousElementSibling)"><i
								class="fas fa-eye"></i></span>
						</div>
						<div class="input-field">
							<label>Fullname</label> <input type="text"
								placeholder="Họ và tên" value="${user.fullname}" name="fullname"
								value="user.fullname" required />
						</div>
						<div class="input-field">
							<label>Email</label> <input type="text" placeholder="Nhập email"
								value="${user.email}" name="email" value="user.email" required />
						</div>
						<div class="button-container">
							<button name="actionUser" value="updateuser">Update</button>
							<button name="actionUser" value="deleteuser">Delete</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="tab__content">
			<table class="content-table" id="user-table">
				<thead>
					<tr>
						<th>Username</th>
						<th>Password</th>
						<th>Fullname</th>
						<th>Email</th>
						<th>Role</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="u" items="${userlist}">
						<tr>
							<td id="userId">${u.id}</td>
							<td>${u.password}</td>
							<td>${u.fullname}</td>
							<td>${u.email}</td>
							<td>${u.admin}</td>
							<td><button>Edit</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
<div class="popup3 hidden">
	<div class="tab-wrap">
		<input type="radio" id="tab7" name="tabGroup4" class="tab" checked />
		<label for="tab7">Favorites</label> <input type="radio" id="tab8"
			name="tabGroup4" class="tab" /> <label for="tab8">Favorite
			Users</label> <input type="radio" id="tab9" name="tabGroup4" class="tab" />
		<label for="tab9">Shared Friends</label>
		<div class="tab__content">
			<table class="content-table" id="report-favorite-table">
				<thead>
					<tr>
						<th>Video Title</th>
						<th>Favorite Count</th>
						<th>Latest Date</th>
						<th>Oldest Date</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="fr" items="${reportfr}">
						<tr>
							<td>${fr.group}</td>
							<td>${fr.likes}</td>
							<td>${fr.newest}</td>
							<td>${fr.oldest}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="tab__content">
			<div class="select">
				<label>Video Title</label> <select id="filter-fu"
					onchange="filterFu()" required>
					<option value="" disabled selected>Chọn tiêu đề</option>
					<c:forEach var="fu" items="${videoAll}">
						<option value="${fu.id}">${fu.title}</option>
					</c:forEach>
				</select>
			</div>
			<table class="content-table" id="table-fu">
				<thead>
					<tr>
						<th>Username</th>
						<th>Fullname</th>
						<th>Email</th>
						<th>Favorite Date</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="fu" items="${reportfu}">
						<tr>
							<td>${fu.user.id}</td>
							<td>${fu.user.fullname}</td>
							<td>${fu.user.email}</td>
							<td>${fu.likeDate}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="tab__content">
			<div class="select">
				<label>Video Title</label> <select required id="filter-fs"
					onchange="filterFs()">
					<option disabled selected>Chọn tiêu đề</option>
					<c:forEach var="fs" items="${videoAll}">
						<option value="${fs.id}">${fs.title}</option>
					</c:forEach>
				</select>
			</div>
			<table class="content-table" id="table-fs">
				<thead>
					<tr>
						<th>Sender Name</th>
						<th>Sender Mail</th>
						<th>Receiver Email</th>
						<th>Sent Date</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="fs" items="${reportfs}">
						<tr>
							<td>${fs.user.fullname}</td>
							<td>${fs.user.email}</td>
							<td>${fs.email}</td>
							<td>${fs.shareDate}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
	<c:if test="${not empty error}">
		<script type="text/javascript" id="errorPopup">
			createToast('error', "${error}");
		</script>
	</c:if>
	<c:if test="${not empty success}">
		<script type="text/javascript" id="successPopup">
			createToast('success', "${success}");
		</script>
	</c:if>