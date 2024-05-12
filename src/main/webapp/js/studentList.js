


function showPopup(id) {
    document.getElementById("errorPopup").style.display = "block";
    document.getElementById("overlay").style.display = "block";
    document.getElementById("studentId").value = id;
}

function hidePopup() {
    document.getElementById("errorPopup").style.display = "none";	
    document.getElementById("overlay").style.display = "none";
}

function delete_student(id) {
	showPopup(id); 
}
