let closeModal = function() {
	document.querySelector(".modal").classList.add("hidden");
	document.querySelector(".overlay").classList.add("hidden");
	// Xóa tham số videoId khỏi URL
	var searchParams = new URLSearchParams(window.location.search);
	searchParams.delete('videoId');
	searchParams.delete('share');
	// Cập nhật URL mới sau khi xóa tham số
	var newUrl = window.location.protocol + "//" + window.location.host + window.location.pathname + searchParams.toString();
	window.history.pushState({path:newUrl},'',newUrl);
};
const closePopup1 = function() {
	document.querySelector(".popup1").classList.add("hidden");
	document.querySelector(".overlay").classList.add("hidden");
var currentUrl = window.location.href;
var newUrl = currentUrl.split("selected")[0];
window.history.pushState(null, null, newUrl);
};
const closePopup2 = function() {
	document.querySelector(".popup2").classList.add("hidden");
	document.querySelector(".overlay").classList.add("hidden");
};
const closePopup3 = function() {
	document.querySelector(".popup3").classList.add("hidden");
	document.querySelector(".overlay").classList.add("hidden");
};
document.querySelector(".btn-close").addEventListener("click", closeModal);
document.querySelector(".overlay").addEventListener("click", closeModal);
document.querySelector(".overlay").addEventListener("click", closePopup1);
document.querySelector(".overlay").addEventListener("click", closePopup2);
document.querySelector(".overlay").addEventListener("click", closePopup3);
document.addEventListener("keydown", function(e) {
	if (e.key === "Escape" && !document.querySelector(".modal").classList.contains("hidden")) {
		closeModal();
	}
});

const t1 = document.getElementById("tab1");
const openModal = function() {
	document.querySelector(".modal").classList.remove("hidden");
	document.querySelector(".overlay").classList.remove("hidden");
	t1.checked = true;
	document.querySelector(".popup1").classList.add("hidden");
	document.querySelector(".popup2").classList.add("hidden");
	document.querySelector(".popup3").classList.add("hidden");
};
const openPopup1 = function() {
	document.querySelector(".popup1").classList.remove("hidden");
	document.querySelector(".overlay").classList.remove("hidden");
	document.querySelector(".modal").classList.add("hidden");
	document.querySelector(".popup2").classList.add("hidden");
	document.querySelector(".popup3").classList.add("hidden");
};
const openPopup2 = function() {
	document.querySelector(".popup2").classList.remove("hidden");
	document.querySelector(".overlay").classList.remove("hidden");
	document.querySelector(".modal").classList.add("hidden");
	document.querySelector(".popup1").classList.add("hidden");
	document.querySelector(".popup3").classList.add("hidden");
};
const openPopup3 = function() {
	document.querySelector(".popup3").classList.remove("hidden");
	document.querySelector(".overlay").classList.remove("hidden");
	document.querySelector(".modal").classList.add("hidden");
	document.querySelector(".popup1").classList.add("hidden");
	document.querySelector(".popup2").classList.add("hidden");
};

document.querySelectorAll(".btn-share").forEach((btn) => btn.addEventListener("click", openModal));
document.querySelectorAll(".video").forEach((btn) => {
  btn.addEventListener("click", function() {
      // Khởi tạo URLSearchParams
    var searchParams = new URLSearchParams(window.location.search);
    if (document.querySelector("#tab1").checked) {
        searchParams.set('selected', "tab1");
    } else if (document.querySelector("#tab2").checked) {
        searchParams.set('selected', "tab2");
    } else{
        searchParams.set('selected', "tab1");
    }	
    // Cập nhật URL mới với tham số đã thêm
    var newUrl = window.location.protocol + "//" + window.location.host + window.location.pathname + '?' + searchParams.toString();
    window.history.pushState({path:newUrl},'',newUrl);
    var currentUrl = window.location.href;
    var startIndex = currentUrl.indexOf("/", currentUrl.indexOf("//") + 2);
    var path = currentUrl.substring(startIndex);
	const xhr = new XMLHttpRequest();
xhr.open("GET", path);
xhr.onreadystatechange = function() {
  if (this.readyState === 4 && this.status === 200) {
    const responseHTML = this.responseText;
    const parser = new DOMParser();
    const doc = parser.parseFromString(responseHTML, 'text/html');
    const contentDiv = doc.querySelector('#video-table');
    document.querySelector('#video-table').innerHTML = contentDiv.innerHTML;
        reloadMainJS();
    // Xử lý dữ liệu ở đây
  } else if (this.readyState === 4 && this.status !== 200) {
    // Xử lý lỗi ở đây
    console.log("Yêu cầu GET thất bại. Mã trạng thái: " + this.status);
  }
};
xhr.send();
openPopup1();

  });
});
document.querySelectorAll(".users").forEach((btn) => {
  btn.addEventListener("click", function() {
      // Khởi tạo URLSearchParams
    var searchParams = new URLSearchParams(window.location.search);
    if (document.querySelector("#tab5").checked) {
        searchParams.set('selected', "tab5");
    } else if (document.querySelector("#tab6").checked) {
        searchParams.set('selected', "tab6");
    } else{
        searchParams.set('selected', "tab5");
    }	
    // Cập nhật URL mới với tham số đã thêm
    var newUrl = window.location.protocol + "//" + window.location.host + window.location.pathname + '?' + searchParams.toString();
    window.history.pushState({path:newUrl},'',newUrl);
    var currentUrl = window.location.href;
    var startIndex = currentUrl.indexOf("/", currentUrl.indexOf("//") + 2);
    var path = currentUrl.substring(startIndex);
	const xhr = new XMLHttpRequest();
xhr.open("GET", path);
xhr.onreadystatechange = function() {
  if (this.readyState === 4 && this.status === 200) {
    const responseHTML = this.responseText;
    const parser = new DOMParser();
    const doc = parser.parseFromString(responseHTML, 'text/html');
    const contentDiv = doc.querySelector('#user-table');
    document.querySelector('#user-table').innerHTML = contentDiv.innerHTML;
        reloadMainJS();
    // Xử lý dữ liệu ở đây
  } else if (this.readyState === 4 && this.status !== 200) {
    // Xử lý lỗi ở đây
    console.log("Yêu cầu GET thất bại. Mã trạng thái: " + this.status);
  }
};
xhr.send();
openPopup2();

  });
});
document.querySelectorAll(".reports").forEach((btn) => {
  btn.addEventListener("click", function() {
      // Khởi tạo URLSearchParams
    var searchParams = new URLSearchParams(window.location.search);
    if (document.querySelector("#tab7").checked) {
        searchParams.set('selected', "tab7");
    } else if (document.querySelector("#tab8").checked) {
        searchParams.set('selected', "tab8");
    } else if (document.querySelector("#tab9").checked) {
        searchParams.set('selected', "tab9");
    } else{
        searchParams.set('selected', "tab7");
    }
    // Cập nhật URL mới với tham số đã thêm
    var newUrl = window.location.protocol + "//" + window.location.host + window.location.pathname + '?' + searchParams.toString();
    window.history.pushState({path:newUrl},'',newUrl);
    var currentUrl = window.location.href;
    var startIndex = currentUrl.indexOf("/", currentUrl.indexOf("//") + 2);
    var path = currentUrl.substring(startIndex);
	const xhr = new XMLHttpRequest();
xhr.open("GET", path);
xhr.onreadystatechange = function() {
  if (this.readyState === 4 && this.status === 200) {
    const responseHTML = this.responseText;
    const parser = new DOMParser();
    const doc = parser.parseFromString(responseHTML, 'text/html');
    const contentDiv = doc.querySelector('.popup3');
    document.querySelector('.popup3').innerHTML = contentDiv.innerHTML;
    reloadMainJS();
    // Xử lý dữ liệu ở đây
  } else if (this.readyState === 4 && this.status !== 200) {
    // Xử lý lỗi ở đây
    console.log("Yêu cầu GET thất bại. Mã trạng thái: " + this.status);
  }
};
xhr.send();
openPopup3();

  });
});
let reloadCount = 0;

function reloadMainJS() {
  // Xóa file script cũ chỉ khi load lại lần đầu tiên
  if (reloadCount > 0) {
    // Tìm tất cả các phần tử script trong body
    const oldScripts = document.querySelectorAll('body script[src="/Assignment2/views/javascript/main.js"]');

    // Xóa các phần tử script cũ
    oldScripts.forEach(script => {
      script.remove();
    });
  }

  // Tạo một phần tử script mới với thuộc tính src để tải script mới
  const script = document.createElement("script");
  script.setAttribute("src", "/Assignment2/views/javascript/main.js");
  document.body.appendChild(script);

  // Tăng biến đếm lên 1
  reloadCount++;
}
const like = document.querySelectorAll(".btn-like");

like.forEach((likeBtn) => {
	const btnLike = likeBtn.querySelector("i");
	btnLike.dataset.liked = "false";

	likeBtn.addEventListener("click", function() {
		if (btnLike.dataset.liked === "false") {
			btnLike.style.color = "#1877f2";

			btnLike.dataset.liked = "true";

			const countSpan = likeBtn.querySelector("span");
			const count = parseInt(countSpan.innerHTML);
			countSpan.innerHTML = count + 1;
		} else {
			btnLike.style.color = "#333";

			const countSpan = likeBtn.querySelector("span");
			const count = parseInt(countSpan.innerHTML);
			countSpan.innerHTML = count - 1;

			btnLike.dataset.liked = "false";
		}
	});
});

