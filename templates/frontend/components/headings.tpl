{**
 * templates/frontend/components/headings.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display a heading for the current page.
 *
 * @uses $currentTitle string The title to use for the current page.
 * @uses $currentTitleKey string Translation key for title of current page.
 *}

<header>
	<div class="current_page_title">
		<h1 class="{if $requestedPage|escape === 'issue' && $requestedOp|escape === "view"}text-left issue-header{else}text-center{/if}">
			{if $currentTitleKey}
				{translate key=$currentTitleKey}
			{else}
				{$currentTitle|escape}
			{/if}
		</h1>
	</div>
</header>
