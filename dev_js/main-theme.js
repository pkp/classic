/**
 * @file /js/main-theme.js
 *
 * Copyright (c) 2014-2019 Simon Fraser University
 * Copyright (c) 2000-2019 John Willinsky
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

$("#tagitInput").each(function() {
	var autocomplete_url = $(this).data("autocomplete-url");
	$(this).tagit({
		fieldName: $(this).data("field-name"),
		allowSpaces: false,
		autocomplete: {
			source: function(request, response) {
				$.ajax({
					url: autocomplete_url,
					data: {term: request.term},
					dataType: "json",
					success: function(jsonData) {
						if (jsonData.status === true) {
							response(jsonData.content);
						}
					}
				});
			}
		}
	});
});

(function () {
	/**
	 * Determine if the user has opted to register as a reviewer
	 *
	 * @see: /templates/frontend/pages/userRegister.tpl
	 */
	function isReviewerSelected() {
		var group = $("#reviewerOptinGroup").find("input");
		var is_checked = false;
		group.each(function() {
			if ($(this).is(":checked")) {
				is_checked = true;
				return false;
			}
		});

		return is_checked;
	}

	/**
	 * Reveal the reviewer interests field on the registration form when a
	 * user has opted to register as a reviewer
	 *
	 * @see: /templates/frontend/pages/userRegister.tpl
	 */
	function reviewerInterestsToggle() {
		var is_checked = isReviewerSelected();
		if (is_checked) {
			$("#reviewerInterests").removeClass("hidden");
		} else {
			$("#reviewerInterests").addClass("hidden");
		}
	}

	// Update interests on page load and when the toggled is toggled
	reviewerInterestsToggle();
	$("#reviewerOptinGroup input").click(reviewerInterestsToggle);
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

// Toggle display of consent checkboxes in site-wide registration
var $contextOptinGroup = $('#contextOptinGroup');
if ($contextOptinGroup.length) {
	var $roles = $contextOptinGroup.find('.roles :checkbox');
	$roles.change(function() {
		var $thisRoles = $(this).closest('.roles');
		if ($thisRoles.find(':checked').length) {
			$thisRoles.siblings('.context_privacy').addClass('context_privacy_visible');
		} else {
			$thisRoles.siblings('.context_privacy').removeClass('context_privacy_visible');
		}
	});
}
