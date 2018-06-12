
/* This self-invoking function provides primary menu rendering for small screens
 * We want to treat it like a typical modal
 */
(function () {
    var modal = document.getElementById('modal-on-small');
    var btn = document.getElementById("show-modal");
    var span = document.getElementById("close-small-modal");

    btn.onclick = function() {
        modal.classList.remove('hide');
    };

    span.onclick = function() {
        modal.classList.add('hide');
    };

    // Close the menu when user clicks outside it
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.classList.add('hide');
        }
    }
})();

// initiating tag-it
$(document).ready(function() {
    $("#tagitInput").tagit();
});

(function () {
    var checkbox = document.getElementById("checkbox-reviewer-interests");
    if (checkbox != null) {
        checkbox.onclick = function () {
            var tagitInput = document.getElementById("reviewerInterests");
            if (checkbox.checked == true) {
                tagitInput.classList.remove("hidden");
            } else {
                tagitInput.classList.add("hidden");
            }
        }
    }
})();

