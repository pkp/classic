{**
 * templates/frontend/objects/announcement_summary.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display a summary view of an announcement
 *
 * @uses $announcement Announcement The announcement to display
 * @uses $heading string HTML heading element, default: h2
 *}

{if !$heading}
	{assign var="heading" value="h2"}
{/if}

<article class="obj_announcement_summary">
	<{$heading} class="announcement-summary-heading">
		<a href="{url router=$smarty.const.ROUTE_PAGE page="announcement" op="view" path=$announcement->id}">
			{$announcement->getLocalizedData('title')|escape}
		</a>
	</{$heading}>

	<div class="summary">
		<p>{$announcement->getLocalizedData('descriptionShort')|strip_unsafe_html}</p>
	</div>

	<div class="date summary_meta">
		{$announcement->datePosted|date_format:$dateFormatShort}
	</div>

	<div class="buttons">
		<a class="btn btn-secondary" href="{url router=$smarty.const.ROUTE_PAGE page="announcement" op="view" path=$announcement->id}">
			<span aria-hidden="true" role="presentation">
				{translate key="common.readMore"}
			</span>
			<span class="pkp_screen_reader">
				{translate key="common.readMoreWithTitle" title=$announcement->getLocalizedData('title')|escape}
			</span>
		</a>
	</div>
</article><!-- .obj_announcement_summary -->
