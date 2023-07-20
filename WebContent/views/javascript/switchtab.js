function switchTab(tab) {
  if (tab === "tab10") {
    window.location.href =
      "/Assignment2/admin/edit-profile?selected=tab10";
  } else if (tab === "tab11") {
    window.location.href =
      "/Assignment2/admin/edit-profile?selected=tab11";
  } else if (tab === "tab1") {
    window.location.href =
      "/Assignment2/user/edit-profile?selected=tab1";
  } else if (tab === "tab2") {
    window.location.href =
      "/Assignment2/user/edit-profile?selected=tab2";
  }
}
const urlParams = new URLSearchParams(window.location.search);
const selectedValue = urlParams.get("selected");

if (selectedValue) {
  document.getElementById(selectedValue).click();
} else {
  console.log("Không tìm thấy giá trị 'selected' trong URL");
}