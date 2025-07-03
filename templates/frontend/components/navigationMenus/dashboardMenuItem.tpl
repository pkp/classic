{**
 * templates/frontend/components/navigationMenus/dashboardMenuItem.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Dashboard menuItem Template
 *
 *}

{$navigationMenuItem->getLocalizedTitle()|escape}
{if $unreadNotificationCount}
	<span class="task_count">
		{$unreadNotificationCount}
	</span>
{/if}
