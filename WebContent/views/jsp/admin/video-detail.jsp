<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet"
	href="/Assignment2/views/icon/fontawesome-free-6.2.1-web/css/all.css">
<link rel="stylesheet" href="/Assignment2/views/css/style.css" />
<link rel="stylesheet" href="/Assignment2/views/css/video.css" />
<link rel="stylesheet" href="/Assignment2/views/css/toast.css" />
<%@ include file="/views/jsp/admin/header.jsp"%>
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
								<a class="btn-like disabled"> <i class="fa-solid fa-thumbs-up"></i> <span>${v.likeCount}</span>
								</a> <a class="btn-share disabled"> <i class="fa-solid fa-share"></i> <span>${v.shareCount}</span>
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
										<a class="btn-like disabled"> <i class="fa-solid fa-thumbs-up"></i>
											<span>${vd.likeCount}</span>
										</a> <a class="btn-share disabled"> <i class="fa-solid fa-share"></i> <span>${vd.shareCount}</span>
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
<%@ include file="/views/jsp/admin/footer.jsp"%>
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
	var movieDetail = document.getElementsByClassName("movie-title");
	Array.prototype.forEach.call(movieDetail, function(movieDetail) {
		movieDetail.addEventListener("click", function() {
			var form = this.closest("form");
			form.querySelector("input[name='movie-detail']").value = "true";
			var searchParams = new URLSearchParams(window.location.search);
			searchParams.delete('videoId');
			// Cập nhật URL mới sau khi xóa tham số
			var newUrl = window.location.protocol + "//" + window.location.host + window.location.pathname + searchParams.toString();
			window.history.pushState({path:newUrl},'',newUrl);
			form.submit();
		});
	});
</script>