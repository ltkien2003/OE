function filterFu() {
	var currentUrl = window.location.href;
	var startIndex = currentUrl.indexOf("/", currentUrl.indexOf("//") + 2);
	var path = currentUrl.substring(startIndex);
	const videoIdFu = document.getElementById("filter-fu").value;
	const xhr = new XMLHttpRequest();
	xhr.open("POST", path);
	xhr.setRequestHeader("Content-Type",
		"application/x-www-form-urlencoded");
	xhr.onreadystatechange = function() {
		if (this.readyState === 4 && this.status === 200) {
			const responseHTML = this.responseText;
			const parser = new DOMParser();
			const doc = parser.parseFromString(responseHTML, 'text/html');
			const contentDiv = doc.querySelector('#table-fu');
			document.querySelector('#table-fu').innerHTML = contentDiv.innerHTML;
			reloadMainJS();
		}
	};
	const data = "videoIdFu=" + encodeURIComponent(videoIdFu);
	xhr.send(data);
}

function filterFs() {
	var currentUrl = window.location.href;
	var startIndex = currentUrl.indexOf("/", currentUrl.indexOf("//") + 2);
	var path = currentUrl.substring(startIndex);
	const videoIdFs = document.getElementById("filter-fs").value;
	const xhr = new XMLHttpRequest();
	xhr.open("POST", path);
	xhr.setRequestHeader("Content-Type",
		"application/x-www-form-urlencoded");
	xhr.onreadystatechange = function() {
		if (this.readyState === 4 && this.status === 200) {
			const responseHTML = this.responseText;
			const parser = new DOMParser();
			const doc = parser.parseFromString(responseHTML, 'text/html');
			const contentDiv = doc.querySelector('#table-fs');
			document.querySelector('#table-fs').innerHTML = contentDiv.innerHTML;
			reloadMainJS();
		}
	};
	const data = "videoIdFs=" + encodeURIComponent(videoIdFs);
	xhr.send(data);
}
var trs = document.querySelectorAll('#user-table tr');
for (var i = 0; i < trs.length; i++) {
	trs[i].addEventListener('click', function(event) {
		var tr = event.currentTarget;
		var username = tr.querySelector('td:first-of-type').textContent;
		console.log(username);
		var currentUrl = window.location.href;
		var startIndex = currentUrl.indexOf("/", currentUrl.indexOf("//") + 2);
		var path = currentUrl.substring(startIndex);
		const xhr = new XMLHttpRequest();
		xhr.open("POST", path);
		xhr.setRequestHeader("Content-Type",
			"application/x-www-form-urlencoded");
		xhr.onreadystatechange = function() {
			if (this.readyState === 4 && this.status === 200) {
				const responseHTML = this.responseText;
				const parser = new DOMParser();
				const doc = parser.parseFromString(responseHTML, 'text/html');
				const contentDiv = doc.querySelector('.form-user-wrapper');
				document.querySelector('.form-user-wrapper').innerHTML = contentDiv.innerHTML;
				reloadMainJS();
				document.querySelector("#tab5").click();
			}
		};
		const data = "userId=" + encodeURIComponent(username);
		xhr.send(data);
	});
}

document.querySelector("#tab1").addEventListener(
	"click",
	function(event) {
		console.log("Hello")
		// Khởi tạo URLSearchParams
		var searchParams = new URLSearchParams(window.location.search);
		searchParams.set('selected', "tab1");

		// Cập nhật URL mới với tham số đã thêm
		var newUrl = window.location.protocol + "//" +
			window.location.host + window.location.pathname + '?' +
			searchParams.toString();
		window.history.pushState({
			path: newUrl
		}, '', newUrl);
	});

document.querySelector("#tab2").addEventListener(
	"click",
	function(event) {
		// Khởi tạo URLSearchParams
		var searchParams = new URLSearchParams(window.location.search);
		searchParams.set('selected', "tab2");

		// Cập nhật URL mới với tham số đã thêm
		var newUrl = window.location.protocol + "//" +
			window.location.host + window.location.pathname + '?' +
			searchParams.toString();
		window.history.pushState({
			path: newUrl
		}, '', newUrl);
	});
document.querySelector("#tab5").addEventListener(
	"click",
	function(event) {
		// Khởi tạo URLSearchParams
		var searchParams = new URLSearchParams(window.location.search);
		searchParams.set('selected', "tab5");

		// Cập nhật URL mới với tham số đã thêm
		var newUrl = window.location.protocol + "//" +
			window.location.host + window.location.pathname + '?' +
			searchParams.toString();
		window.history.pushState({
			path: newUrl
		}, '', newUrl);
	});

document.querySelector("#tab6").addEventListener(
	"click",
	function(event) {
		// Khởi tạo URLSearchParams
		var searchParams = new URLSearchParams(window.location.search);
		searchParams.set('selected', "tab6");

		// Cập nhật URL mới với tham số đã thêm
		var newUrl = window.location.protocol + "//" +
			window.location.host + window.location.pathname + '?' +
			searchParams.toString();
		window.history.pushState({
			path: newUrl
		}, '', newUrl);
	});
document.querySelector("#tab7").addEventListener(
	"click",
	function(event) {
		// Khởi tạo URLSearchParams
		var searchParams = new URLSearchParams(window.location.search);
		searchParams.set('selected', "tab7");

		// Cập nhật URL mới với tham số đã thêm
		var newUrl = window.location.protocol + "//" +
			window.location.host + window.location.pathname + '?' +
			searchParams.toString();
		window.history.pushState({
			path: newUrl
		}, '', newUrl);
	});
document.querySelector("#tab8").addEventListener(
	"click",
	function(event) {
		// Khởi tạo URLSearchParams
		var searchParams = new URLSearchParams(window.location.search);
		searchParams.set('selected', "tab8");

		// Cập nhật URL mới với tham số đã thêm
		var newUrl = window.location.protocol + "//" +
			window.location.host + window.location.pathname + '?' +
			searchParams.toString();
		window.history.pushState({
			path: newUrl
		}, '', newUrl);
	});
document.querySelector("#tab9").addEventListener(
	"click",
	function(event) {
		// Khởi tạo URLSearchParams
		var searchParams = new URLSearchParams(window.location.search);
		searchParams.set('selected', "tab9");

		// Cập nhật URL mới với tham số đã thêm
		var newUrl = window.location.protocol + "//" +
			window.location.host + window.location.pathname + '?' +
			searchParams.toString();
		window.history.pushState({
			path: newUrl
		}, '', newUrl);
	});
var active1 = document.getElementById('active1');
var active2 = document.getElementById('active2');

active1.addEventListener('click', function() {
	if (active1.checked) {
		active2.checked = false;
	}
});

active2.addEventListener('click', function() {
	if (active2.checked) {
		active1.checked = false;
	}
});
function formUser(event) {
	event.preventDefault();
	const buttonValue = event.submitter.value; // Lấy giá trị của nút được nhấn
	const id = event.target.querySelector('input[name="id"]').value;
	const password = event.target.querySelector('input[name="password"]').value;
	const fullname = event.target.querySelector('input[name="fullname"]').value;
	const email = event.target.querySelector('input[name="email"]').value;
	var currentUrl = window.location.href;
	var startIndex = currentUrl.indexOf("/", currentUrl.indexOf("//") + 2);
	var path = currentUrl.substring(startIndex);
	const xhr = new XMLHttpRequest();
	xhr.open("POST", path);
	xhr.setRequestHeader("Content-Type",
		"application/x-www-form-urlencoded");
	xhr.onreadystatechange = function() {
		if (this.readyState === 4 && this.status === 200) {
			const responseHTML = this.responseText;
			const parser = new DOMParser();
			const doc = parser.parseFromString(responseHTML, 'text/html');
			const contentDiv = doc.querySelector('#user-table');
			document.querySelector('#user-table').innerHTML = contentDiv.innerHTML;
			reloadMainJS();
			const error = doc.querySelector('#errorPopup');
			const success = doc.querySelector('#successPopup');
			if (error != null) {
				eval(error.innerHTML);
			}
			else if (success != null) {
				eval(success.innerHTML);
				const contentEmpty = doc.querySelector('#form-user');
				document.querySelector('#form-user').innerHTML = contentEmpty.innerHTML;
				document.querySelector("#tab6").click();
			}
		}
	};
	const data = 'id=' + encodeURIComponent(id) + '&password=' + encodeURIComponent(password) + '&fullname=' + encodeURIComponent(fullname) + '&email=' + encodeURIComponent(email) + '&actionUser=' + encodeURIComponent(buttonValue);
	xhr.send(data);
}
var trVideos = document.querySelectorAll('#video-table tr');
for (var i = 0; i < trVideos.length; i++) {
	trVideos[i].addEventListener('click', function(event) {
		var tr = event.currentTarget;
		var videoId = tr.querySelector('td:first-of-type').textContent;
		console.log(videoId);
		var currentUrl = window.location.href;
		var startIndex = currentUrl.indexOf("/", currentUrl.indexOf("//") + 2);
		var path = currentUrl.substring(startIndex);
		const xhr = new XMLHttpRequest();
		xhr.open("POST", path);
		xhr.setRequestHeader("Content-Type",
			"application/x-www-form-urlencoded");
		xhr.onreadystatechange = function() {
			if (this.readyState === 4 && this.status === 200) {
				const responseHTML = this.responseText;
				const parser = new DOMParser();
				const doc = parser.parseFromString(responseHTML, 'text/html');
				const contentDiv = doc.querySelector('#form-video');
				document.querySelector('#form-video').innerHTML = contentDiv.innerHTML;
				reloadMainJS();
				document.querySelector("#tab1").click();
			}
		};
		const data = "videoId=" + encodeURIComponent(videoId);
		xhr.send(data);
	});
}
function formVideo(event) {
	event.preventDefault();
	const buttonValue = event.submitter.value; // Lấy giá trị của nút được nhấn
	const videoImage = event.target.querySelector('img[name="videoImage"]').src;
	const videoId = event.target.querySelector('input[name="videoId"]').value;
	const videoTitle = event.target.querySelector('input[name="videoTitle"]').value;
	const videoViews = event.target.querySelector('input[name="videoViews"]').value;
	const active = event.target.querySelector('input[name="active"]:checked').value;
	const description = event.target.querySelector('textarea[name="description"]').value;
	var currentUrl = window.location.href;
	var startIndex = currentUrl.indexOf("/", currentUrl.indexOf("//") + 2);
	var path = currentUrl.substring(startIndex);
	const xhr = new XMLHttpRequest();
	xhr.open("POST", path);
	xhr.setRequestHeader("Content-Type",
		"application/x-www-form-urlencoded");
	xhr.onreadystatechange = function() {
		if (this.readyState === 4 && this.status === 200) {
			const responseHTML = this.responseText;
			const parser = new DOMParser();
			const doc = parser.parseFromString(responseHTML, 'text/html');
			const contentDiv = doc.querySelector('#video-table');
			document.querySelector('#video-table').innerHTML = contentDiv.innerHTML;
			reloadMainJS();
			const error = doc.querySelector('#errorPopup');
			const success = doc.querySelector('#successPopup');
			if (error != null) {
				eval(error.innerHTML);
			}
			else if (success != null) {
				eval(success.innerHTML);
				const contentEmpty = doc.querySelector('#form-video');
				document.querySelector('#form-video').innerHTML = contentEmpty.innerHTML;
				document.querySelector("#tab2").click();
			}
			else {
				const contentEmpty = doc.querySelector('#form-video');
				document.querySelector('#form-video').innerHTML = contentEmpty.innerHTML;
			}
		}
	};
	const data = 'videoId=' + encodeURIComponent(videoId) + '&videoImage=' + encodeURIComponent(videoImage) + '&videoTitle=' + encodeURIComponent(videoTitle) + '&videoViews=' + encodeURIComponent(videoViews) + '&active=' + encodeURIComponent(active) + '&description=' + encodeURIComponent(description) + '&actionVideo=' + encodeURIComponent(buttonValue);
	xhr.send(data);
}
function togglePassword(input) {
	if (input.type === "password") {
		input.type = "text";
		input.focus();
	} else {
		input.type = "password";
		input.focus();
	}
}
function switchTab() {
	// Khởi tạo URLSearchParams
	var searchParams = new URLSearchParams(window.location.search);
	var selectedTab = searchParams.get('selected');
	console.log(selectedTab);
	// Chuyển đổi giữa các tab tương ứng
	switch (selectedTab) {
		case 'tab1':
			document.querySelector("#tab1").click();
			openPopup1();
			break;
		case 'tab2':
			document.querySelector("#tab2").click();
			openPopup1();
			break;
		case 'tab5':
			document.querySelector("#tab5").click();
			openPopup2();
			break;
		case 'tab6':
			document.querySelector("#tab6").click();
			openPopup2();
			break;
		case 'tab7':
			document.querySelector("#tab7").click();
			openPopup3();
			break;
		case 'tab8':
			document.querySelector("#tab8").click();
			openPopup3();
			break;
		case 'tab9':
			document.querySelector("#tab9").click();
			openPopup3();
			break;
	}
}
switchTab();
document.getElementById("videoImage").onclick = function() {
	document.getElementById("fileImage").click();
};
function loadImage(event) {
	var img = document.getElementById("videoImage");
	var file = event.target.files[0];
	uploadFileToFirebase(file)
		.then(url => {
			img.src = url;
		})
		.catch(error => console.error('Error uploading file:', error));
}

function uploadFileToFirebase(file) {
	const firebaseConfig = {
		apiKey: "AIzaSyAV3irYIqhJsELBVFh0730Dv2IVBSTx17Y",
		authDomain: "fir-e2be5.firebaseapp.com",
		databaseURL: "https://fir-e2be5-default-rtdb.firebaseio.com",
		projectId: "fir-e2be5",
		storageBucket: "fir-e2be5.appspot.com",
		messagingSenderId: "879347188649",
		appId: "1:879347188649:web:dd0d3726342fdded48bab8",
		measurementId: "G-40P7X77MD4"
	};
	function generateUUID() {
		let uuid = '';
		const hexDigits = '0123456789abcdef';
		for (let i = 0; i < 32; i++) {
			const randomDigit = Math.floor(Math.random() * 16);
			uuid += hexDigits[randomDigit];
		}
		return uuid;
	}
	firebase.initializeApp(firebaseConfig);
	const storageRef = firebase.storage().ref();
	const filename = generateUUID() + Date.now().toString() + "-" + file.name;
	const fileRef = storageRef.child(`${filename}`);
	return fileRef.put(file)
		.then(snapshot => snapshot.ref.getDownloadURL())
		.catch(error => console.error('Error uploading file: ', error));
}
var uploadDate = document.getElementById("uploadDate").value;

if (uploadDate == "") {
	var currentDate = new Date();
	var formattedDate = ("0" + currentDate.getDate()).slice(-2) + "/" + ("0" + (currentDate.getMonth() + 1)).slice(-2) + "/" + currentDate.getFullYear();
	document.getElementById("uploadDate").value = formattedDate;
}
var videoImage = document.getElementById("videoImage");
if (videoImage.getAttribute("src") === "") {
	document.getElementById("videoImage").src = "/Assignment2/views/image/upload.jpg";
}