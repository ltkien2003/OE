<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<title>Trang chủ Admin</title>
<link rel="stylesheet"
	href="/Assignment2/views/icon/fontawesome-free-6.2.1-web/css/all.min.css" />
<link href="/Assignment2/views/font/font.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/Assignment2/views/css/style.css" />
<link rel="stylesheet" href="/Assignment2/views/css/popup.css" />
</head>
<body>
<%@ include file="/views/jsp/admin/header.jsp" %>
	<jsp:include page="/views/jsp/admin/admin.jsp"></jsp:include>
<%@ include file="/views/jsp/admin/footer.jsp" %>
	<script type="text/javascript">
		var movieDetail = document.getElementsByClassName("movie-title");
		Array.prototype.forEach.call(movieDetail, function(movieDetail) {
			movieDetail.addEventListener("click", function() {
				var form = this.closest("form");
				form.querySelector("input[name='movie-detail']").value = "true";
				form.submit();
		    });
		});
	</script>
</body>
</html>