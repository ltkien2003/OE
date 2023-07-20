<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet"
	href="/Assignment2/views/icon/fontawesome-free-6.2.1-web/css/all.css">
<link rel="stylesheet" href="/Assignment2/views/css/style.css" />
<link rel="stylesheet" href="/Assignment2/views/css/video.css" />
<link rel="stylesheet" href="/Assignment2/views/css/toast.css" />
<style type="text/css">
i.fa-solid.fa-thumbs-up.active {
	color: rgb(24, 119, 242);
}
</style>
<%@ include file="/views/jsp/user/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<ul class="notifications"></ul>
<main>
	<div class="container play-container">
		<div class="row">
			<c:if test="${not empty v.video.id}">
				<div class="play-video" id="embeb-video">
					<form method="POST">
						<input type="hidden" name="videoId" value="${v.video.id}">
						<input type="hidden" name="like" value=""> <input
							type="hidden" name="share" value=""> <input type="hidden"
							name="movie-detail" value="">
						<h3 class="">${v.video.title}</h3>
						<div class="play-video-info">
							<p>${v.video.views} Lượt Xem</p>
							<div class="movie-emotion">
								<a class="btn-like"> <i class="fa-solid fa-thumbs-up"></i> <span>${v.likeCount}</span>
								</a> <a class="btn-share"> <i class="fa-solid fa-share"></i> <span>${v.shareCount}</span>
								</a>
							</div>
						</div>
						<hr />
						<div class="vid-description">
							<p>${v.video.description}</p>
						</div>
					</form>

					<!-- ------Right Sidebar-------- -->
				</div>
				<div class="right-sidebar">
					<c:forEach var="vd" items="${videos}">
						<form method="POST">
							<input type="hidden" name="videoId" value="${vd.video.id}">
							<input type="hidden" name="like" value=""> <input
								type="hidden" name="share" value=""> <input
								type="hidden" name="movie-detail" value="">
							<div class="side-video-list">
								<a href="" class="small-thumbnail"><img
									src="${vd.video.poster}" /></a>
								<div class="vid-info">
									<a class="movie-title">${vd.video.title}</a>
									<p>${vd.video.views} Lượt Xem</p>
									<div class="movie-emotion">
										<a class="btn-like"> <i class="fa-solid fa-thumbs-up"></i>
											<span>${vd.likeCount}</span>
										</a> <a class="btn-share"> <i class="fa-solid fa-share"></i> <span>${vd.shareCount}</span>
										</a>
									</div>
								</div>
							</div>
						</form>
					</c:forEach>
				</div>
			</c:if>
			<c:if test="${not empty vf.video.id}">
				<div class="play-video" id="embeb-video">
					<form method="POST">
						<input type="hidden" name="videoId" value="${vf.video.id}">
						<input type="hidden" name="unlike" value=""> <input
							type="hidden" name="share" value=""> <input type="hidden"
							name="movie-detail" value="">
						<h3 class="movie-title">${vf.video.title}</h3>
						<div class="play-video-info">
							<p>${vf.video.views} Lượt Xem</p>
							<div class="movie-emotion">
								<a class="btn-like"> <i class="fa-solid fa-thumbs-up active"></i>
									<span>${vf.likeCount}</span>
								</a> <a class="btn-share"> <i class="fa-solid fa-share"></i> <span>${vf.shareCount}</span>
								</a>
							</div>
						</div>
						<hr />
						<div class="vid-description">
							<p>${vf.video.description}</p>
						</div>
					</form>

					<!-- ------Right Sidebar-------- -->
				</div>
				<div class="right-sidebar">
					<c:forEach var="vd" items="${videos}">
						<form method="POST">
							<input type="hidden" name="videoId" value="${vd.video.id}">
							<input type="hidden" name="unlike" value=""> <input
								type="hidden" name="share" value=""> <input
								type="hidden" name="movie-detail" value="">
							<div class="side-video-list">
								<a href="" class="small-thumbnail"><img
									src="${vd.video.poster}" /></a>
								<div class="vid-info">
									<a class="movie-title">${vd.video.title}</a>
									<p>${vd.video.views} Lượt Xem</p>
									<div class="movie-emotion">
										<a class="btn-like"> <i
											class="fa-solid fa-thumbs-up active"></i> <span>${vd.likeCount}</span>
										</a> <a class="btn-share"> <i class="fa-solid fa-share"></i> <span>${vd.shareCount}</span>
										</a>
									</div>
								</div>
							</div>
						</form>
					</c:forEach>
				</div>
			</c:if>
		</div>
	</div>
</main>
<%@ include file="/views/jsp/user/footer.jsp"%>
<script src="/Assignment2/views/javascript/modal.js"></script>
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
<c:if test="${not empty v.video.id}">
	<script type="text/javascript">
		var videoContainer = document.getElementById('embeb-video');
		var iframe = document.createElement('iframe');
		iframe.src = "https://www.youtube.com/embed/${v.video.id}";
		iframe.width = "1046";
		iframe.height = "436";
		iframe.allowFullscreen = true;
		iframe.allow = "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share";
		iframe.frameBorder = "0";
		videoContainer.insertBefore(iframe, videoContainer.firstChild);
	</script>
</c:if>
<c:if test="${not empty vf.video.id}">
	<script type="text/javascript">
		var videoContainer = document.getElementById('embeb-video');
		var iframe = document.createElement('iframe');
		iframe.src = "https://www.youtube.com/embed/${vf.video.id}";
		iframe.width = "1046";
		iframe.height = "436";
		iframe.allowFullscreen = true;
		iframe.allow = "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share";
		iframe.frameBorder = "0";
		videoContainer.insertBefore(iframe, videoContainer.firstChild);
	</script>
</c:if>
<script type="text/javascript">
	var likeButtons = document.getElementsByClassName("btn-like");
	var unlikeButtons = document.getElementsByClassName("btn-unlike");
	var likeButtons = document.getElementsByClassName("btn-like");
	var shareButtons = document.getElementsByClassName("btn-share");
	var movieDetail = document.getElementsByClassName("movie-title");
	Array.prototype.forEach.call(likeButtons, function(likeButton) {
		likeButton.addEventListener("click", function() {
			var form = this.closest("form");
			var unlikeInput = form.querySelector("input[name='unlike']");
			if (unlikeInput) {
				unlikeInput.value = "true";
			} else {
				form.querySelector("input[name='like']").value = "true";
			}
			form.querySelector("input[name='share']").value = "";
			form.submit();
		});
	});
	Array.prototype.forEach.call(shareButtons, function(shareButton) {
		shareButton.addEventListener("click", function() {
			// Lấy giá trị videoId từ form
			var videoId = this.closest('form').querySelector(
					'input[name="videoId"]').value;

			// Khởi tạo URLSearchParams
			var searchParams = new URLSearchParams(window.location.search);
			// Thêm giá trị share vào tham số mới
			searchParams.set('share', "true");
			// Thêm giá trị videoId vào tham số mới
			searchParams.set('videoId', videoId);

			// Cập nhật URL mới với tham số đã thêm
			var newUrl = window.location.protocol + "//" + window.location.host
					+ window.location.pathname + '?' + searchParams.toString();
			window.history.pushState({
				path : newUrl
			}, '', newUrl);
		});
	});
	Array.prototype.forEach.call(movieDetail, function(movieDetail) {
		movieDetail.addEventListener("click", function() {
			var form = this.closest("form");
			form.querySelector("input[name='movie-detail']").value = "true";
			var unlikeInput = form.querySelector("input[name='unlike']");
			if (unlikeInput) {
				unlikeInput.value = "";
			} else {
				form.querySelector("input[name='like']").value = "";
			}
			form.querySelector("input[name='share']").value = "";
			// Xóa tham số videoId khỏi URL
			var searchParams = new URLSearchParams(window.location.search);
			searchParams.delete('videoId');
			// Cập nhật URL mới sau khi xóa tham số
			var newUrl = window.location.protocol + "//" + window.location.host + window.location.pathname + searchParams.toString();
			window.history.pushState({path:newUrl},'',newUrl);
			form.submit();
		});
	});
</script>