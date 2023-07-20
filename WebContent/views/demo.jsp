<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form id="myForm" action="/Assignment2/user/demo" method="POST">
		<input type="text" name="demo" required>
		<button>Hello</button>
	</form>
	<script type="text/javascript">
	function submitForm(event) {
	    event.preventDefault();
	    var xhr = new XMLHttpRequest();
	    var formData = new FormData();
	    formData.append('demo', document.querySelector('input[name="demo"]').value);
	    xhr.open(this.method, this.action, true);
	    xhr.setRequestHeader('Content-Type', 'application/json');
	    xhr.onreadystatechange = function() {
	        if (xhr.readyState === 4 && xhr.status === 200) {
	            console.log(xhr.responseText);
	        }
	    };
	    xhr.send(
	        demo: document.querySelector('input[name="demo"]').value);
	}

	var form = document.getElementById('myForm');
	form.addEventListener('submit', submitForm);
	</script>
</body>
</html>