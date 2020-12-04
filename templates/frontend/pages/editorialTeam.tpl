{**
 * templates/frontend/pages/editorialTeam.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view the editorial team.
 *
 * @uses $currentContext Journal|Press The current journal or press
 *}

{include file="frontend/components/header.tpl" pageTitle="about.editorialTeam"}

<main class="page page_editorial_team">
	<div class="container-fluid container-page container-narrow">
		{include file="frontend/components/headings.tpl" currentTitleKey="about.editorialTeam"}
		{include file="frontend/components/editLink.tpl" page="management" op="settings" path="context" anchor="masthead" sectionTitleKey="about.editorialTeam"}
		{$currentContext->getLocalizedSetting('editorialTeam')}
	</div>
</main><!-- .page -->

{include file="frontend/components/footer.tpl"}
