<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<title>OE</title>
<link rel="stylesheet"
	href="/Assignment2/views/icon/fontawesome-free-6.2.1-web/css/all.min.css" />
<link
	href="/Assignment2/views/icon/fontawesome-free-6.2.1-web/css/all.min.css"
	rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/Assignment2/views/css/style.css" />
<link rel="stylesheet" href="/Assignment2/views/css/popup.css" />
<link rel="stylesheet" href="/Assignment2/views/css/toast.css" />
</head>
<body>
	<%@ include file="/views/jsp/user/header.jsp"%>
	<ul class="notifications"></ul>
	<jsp:include page="/views/jsp/user/user.jsp"></jsp:include>
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
	<script type="text/javascript">
		var likeButtons = document.getElementsByClassName("btn-like");
		var shareButtons = document.getElementsByClassName("btn-share");
		var movieDetail = document.getElementsByClassName("movie-title");
		Array.prototype.forEach.call(likeButtons, function(likeButton) {
			likeButton.addEventListener("click", function() {
				var form = this.closest("form");
				form.querySelector("input[name='like']").value = "true";
				form.querySelector("input[name='share']").value = "";
				form.querySelector("input[name='movie-detail']").value = "";
				form.submit();
			});
		});
		Array.prototype.forEach.call(shareButtons, function(shareButton) {
		    shareButton.addEventListener("click", function() {
		        // Lấy giá trị videoId từ form
		        var videoId = this.closest('form').querySelector('input[name="videoId"]').value;

		        // Khởi tạo URLSearchParams
		        var searchParams = new URLSearchParams(window.location.search);
		        // Thêm giá trị share vào tham số mới
		        searchParams.set('share', "true");
		        // Thêm giá trị videoId vào tham số mới
		        searchParams.set('videoId', videoId);

		        // Cập nhật URL mới với tham số đã thêm
		        var newUrl = window.location.protocol + "//" + window.location.host + window.location.pathname + '?' + searchParams.toString();
		        window.history.pushState({path:newUrl},'',newUrl);
		    });
		});
		Array.prototype.forEach.call(movieDetail, function(movieDetail) {
			movieDetail.addEventListener("click", function() {
				var form = this.closest("form");
				form.querySelector("input[name='movie-detail']").value = "true";
				form.querySelector("input[name='like']").value = "";
				form.querySelector("input[name='share']").value = "";
				form.submit();
		    });
		});
	</script>
	
</body>
</html>
