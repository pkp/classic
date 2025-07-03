{**
 * templates/frontend/objects/announcement_full.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the full view of an announcement, when the announcement is
 *  the primary element on the page.
 *
 * @uses $announcement Announcement The announcement to display
 *}

<article class="obj_announcement_full">
	<h1 class="announcement-full-title">
		{$announcement->getLocalizedData('title')|escape}
	</h1>
	<div class="announcement-full-wrapper">
		<div class="announcement-full-date">
			<i class="far fa-calendar-alt"></i>
			{$announcement->datePosted|date_format:$dateFormatShort}
		</div>
		<div class="announcement-full-description">
			{if $announcement->getLocalizedData('description')}
				{$announcement->getLocalizedData('description')|strip_unsafe_html}
			{else}
				{$announcement->getLocalizedData('descriptionShort')|strip_unsafe_html}
			{/if}
		</div>
	</div>
</article><!-- .obj_announcement_full -->
