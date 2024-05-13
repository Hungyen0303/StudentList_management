


function showPopup(id) {
    document.getElementById("errorPopup").style.display = "block";
    document.getElementById("overlay").style.display = "block";
    document.getElementById("id").value = id;
}

function hidePopup() {
    document.getElementById("errorPopup").style.display = "none";	
    document.getElementById("overlay").style.display = "none";
}

