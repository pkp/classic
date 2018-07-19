{**
 * templates/frontend/pages/information.tpl
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2003-2018 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Information page.
 *
 *}

{if !$contentOnly}
	{include file="frontend/components/header.tpl" pageTitle=$pageTitle}
{/if}

<main class="page page_information">
	<div class="container-fluid container-page container-narrow">
		{include file="frontend/components/breadcrumbs.tpl" currentTitleKey=$pageTitle}
		{include file="frontend/components/editLink.tpl" page="management" op="settings" path="website" anchor="information" sectionTitleKey="manager.website.information"}

		<div class="info-description">
			{$content}
		</div>
	</div>
</main>

{if !$contentOnly}
	{include file="frontend/components/footer.tpl"}
{/if}
