


function showPopup(id) {
    document.getElementById("errorPopup").style.display = "block";
    document.getElementById("overlay").style.display = "block";
    document.getElementById("id").value = id;
}

function hidePopup() {
    document.getElementById("errorPopup").style.display = "none";	
    document.getElementById("overlay").style.display = "none";
}

function hideUpGrade()
{
	document.getElementById("enterGrade").style.display="none";
	document.getElementById("overlay").style.display = "none";
}
function showPopUpGrade(id_student)
{
	document.getElementById("enterGrade").style.display="flex";
	document.getElementById("overlay").style.display = "block";
    document.getElementById("id_student").value = id_student;
  
}

