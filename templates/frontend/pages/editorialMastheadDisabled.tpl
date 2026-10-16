{**
 * templates/frontend/pages/editorialMastheadDisabled.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display context's editorial masthead page when the enrollment-based masthead is disabled.
 *
 *}
{include file="frontend/components/header.tpl" pageTitle="common.editorialMasthead"}

<main class="page page_masthead">
	<div class="container-fluid container-page container-narrow">

		{include file="frontend/components/headings.tpl" currentTitleKey="common.editorialMasthead"}

		{include file="frontend/components/editLink.tpl" page="management" op="settings" path="context" anchor="masthead" sectionTitleKey="common.editorialMasthead"}
		{$currentContext->getLocalizedData('editorialHistory')}
	</div>
</main><!-- .page -->

{include file="frontend/components/footer.tpl"}
