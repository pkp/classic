{**
 * templates/frontend/objects/announcement_full.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the full view of an announcement, when the announcement is
 *  the primary element on the page.
 *
 * @uses $announcement Announcement The announcement to display
 *}

<article class="obj_announcement_full">
	<h1 class="announcement-full-title">
		{$announcement->getLocalizedTitle()|escape}
	</h1>
	<div class="announcement-full-wrapper">
		<div class="announcement-full-date">
			<i class="far fa-calendar-alt"></i>
			{$announcement->getDatePosted()|date_format:$dateFormatShort}
		</div>
		<div class="announcement-full-description">
			{if $announcement->getLocalizedDescription()}
				{$announcement->getLocalizedDescription()|strip_unsafe_html}
			{else}
				{$announcement->getLocalizedDescriptionShort()|strip_unsafe_html}
			{/if}
		</div>
	</div>
</article><!-- .obj_announcement_full -->
