/**
 * @file /js/main-theme.js
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2000-2018 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Custom javascript functionality for Traditional OJS 3 theme plugin
 */


/* This self-invoking function provides primary menu rendering for small screens
 * We want to treat it like a typical modal
 */
(function () {
    var modal = document.getElementById('modal-on-small');
    var btn = document.getElementById("show-modal");
    var span = document.getElementById("close-small-modal");
    
    if ((btn && span && modal) !== null) {
	    btn.onclick = function () {
		    modal.classList.remove('hide');
	    };
	
	    span.onclick = function () {
		    modal.classList.add('hide');
	    };
	
	    // Close the menu when user clicks outside it
	    window.onclick = function (event) {
		    if (event.target == modal) {
			    modal.classList.add('hide');
		    }
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
    });
});

// more authors data functionality

$(document).ready(function () {
    $("#collapseButton").click(function () {
        if ($("#authorInfoCollapse").hasClass("show")) {
            $("#more-authors-data-symbol").removeClass("hide");
            $("#less-authors-data-symbol").addClass("hide");
        } else {
            $("#more-authors-data-symbol").addClass("hide");
            $("#less-authors-data-symbol").removeClass("hide");
        }
    });
});

// change article's blocks logic for small screens

(function () {
	var articleMainData = $("#articleMainData");
	var mainEntry = $("#mainEntry");
	var mainEntryChildren = mainEntry.children();
	var articleAbstractBlock = $("#articleAbstractBlock");
	var articleAbstractBlockChildren = articleAbstractBlock.children();
	var dataForMobilesMark = "data-for-mobiles";
	
	// article's blocks in one column for mobiles and two for big screens
	function reorganizeArticleBlocks() {
		if (articleMainData !== null && !articleMainData.hasClass(dataForMobilesMark) && window.innerWidth < 768) {
			mainEntryChildren.unwrap();
			articleAbstractBlockChildren.unwrap();
			articleMainData.addClass(dataForMobilesMark);
		} else if (articleMainData !== null && articleMainData.hasClass(dataForMobilesMark) && window.innerWidth >= 768) {
			mainEntryChildren.wrapAll("<div class='main_entry col-md-4' id='mainEntry'></div>");
			articleAbstractBlockChildren.wrapAll("<div class='article_abstract_block col-md-8' id='articleAbstractBlock'></div>");
			articleMainData.removeClass(dataForMobilesMark);
		}
	}
	
	reorganizeArticleBlocks();
	
	window.addEventListener("resize", function () {
		reorganizeArticleBlocks();
	});
})();

// hide authors for mobiles

$(document).ready(function () {
	var authorViewLimit = $('.limit-for-mobiles');
	$('#show-all-authors').click(function () {
		authorViewLimit.removeClass("limit-for-mobiles");
		$(this).addClass("hide");
		$('#hide-authors').removeClass("hide");
		$('.fifth-author .author-delimiter').addClass("show");
	});
	
	$('#hide-authors').click(function () {
		authorViewLimit.addClass("limit-for-mobiles");
		$('.limit-for-mobiles').removeClass("show-authors");
		$(this).addClass("hide");
		$('#show-all-authors').removeClass("hide");
		$('.fifth-author .author-delimiter').removeClass("show");
	})
});