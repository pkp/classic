
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

// more keywords functionality

$(document).ready(function(){
    $("#more_keywords").click(function(){
        $(".keyword_item").removeClass("more-than-five");
        $(this).addClass("hide");
        $("#keywords-ellipsis").addClass("hide");
        $("#less_keywords").removeClass("hide");
        $(".fifth-keyword-delimeter").removeClass("hide");
    });

    $("#less_keywords").click(function () {

        $(".keyword_item").each(function(i) {
            if (i > 4) {
                $(this).addClass("more-than-five");
            }
        });

        $(this).addClass("hide");
        $("#keywords-ellipsis").removeClass("hide");
        $("#more_keywords").removeClass("hide");
        $(".fifth-keyword-delimeter").addClass("hide");
    })
});