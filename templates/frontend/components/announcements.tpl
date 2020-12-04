{**
 * templates/frontend/components/announcements.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display a list of announcements
 *
 * @uses $announcements array List of announcements
 *}

<div class="cmp_announcements">
	{foreach from=$announcements item=announcement}
		<div class="cmp_announcement">
			{include file="frontend/objects/announcement_summary.tpl"}
		</div>
	{/foreach}
</div>
