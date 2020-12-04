{**
 * templates/frontend/pages/privacy.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view the privacy policy.
 *
 * @uses $currentContext Journal|Press The current journal or press
 *}

{include file="frontend/components/header.tpl" pageTitle="manager.setup.privacyStatement"}

<main class="page page_privacy">
	<div class="container-fluid container-page container-narrow">
		{include file="frontend/components/headings.tpl" currentTitleKey="manager.setup.privacyStatement"}
		{$privacyStatement}
	</div>
</main><!-- .page -->

{include file="frontend/components/footer.tpl"}
