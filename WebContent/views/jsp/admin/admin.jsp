<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<main>
	<div class="movie-list">
		<div class="movie-container">
			<c:forEach var="video" items="${videos}">
				<form action="/Assignment2/admin/index" method="POST">
					<input type="hidden" name="videoId" value="${video.video.id}">
					<input type="hidden" name="movie-detail" value="">
					<div class="movie-box">
						<div class="movie-img">
							<img src="${video.video.poster}" />
						</div>
						<div class="movie-text">
							<a class="movie-title">${video.video.title}</a>
							<p>${video.video.views} Lượt Xem</p>
							<div class="movie-emotion">
								<a class="btn-like disabled"> <i class="fa-solid fa-thumbs-up"></i> <span>${video.likeCount}</span>
								</a> <a class="btn-share disabled"> <i class="fa-solid fa-share"></i> <span>${video.shareCount}</span>
								</a>
							</div>
						</div>
					</div>
				</form>

			</c:forEach>
		</div>
	</div>
</main>
