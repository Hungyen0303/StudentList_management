

 function validateForm() {
        document.getElementById("alearID").style.display= "block" 
}

/* this function for checking and making sure that 
id must contains 8 letters  */

  function validateForm() {
        var idInput = document.getElementById("id");
        var submitBtn = document.getElementById("submitBtn");
        
        if (idInput.value.trim().length == 8  && checkAllInputsFilled()) {
            submitBtn.disabled = false;
        } else {
            submitBtn.disabled = true;
        }
    }

    function checkAllInputsFilled() {
        var inputs = document.querySelectorAll('input');
        for (var i = 0; i < inputs.length; i++) {
            if (!inputs[i].value) {
                return false;
            }
        }
        return true;
    }