{**
 * templates/frontend/pages/orcidAbout.tpl
 *
 * Copyright (c) 2014-2024 Simon Fraser University
 * Copyright (c) 2003-2024 John Willinsky
 * Copyright (c) 2018-2019 University Library Heidelberg
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Page template to display from the OrcidHandler to show information/overview about ORCID functionality for users.
 *}
{include file="frontend/components/header.tpl"}

<main class="page page_message page_orcid-profile">
	<div class="container-fluid container-page container-narrow">
		{include file="frontend/components/headings.tpl" currentTitleKey="orcid.about.title"}
		<h2>
			{translate key="orcid.about.title"}
		</h2>
		<div class="orcid-profile-block">
			{translate key="orcid.about.orcidExplanation"}
		</div>
		<h3>{translate key="orcid.about.howAndWhy.title"}</h3>
		<div class="orcid-profile-block">
			{if $isMemberApi}
				{translate key="orcid.about.howAndWhyMemberAPI"}
			{else}
				{translate key="orcid.about.howAndWhyPublicAPI"}
			{/if}
		</div>
		<h3>{translate key="orcid.about.display.title"}</h3>
		<div class="orcid-profile-block">
			{translate key="orcid.about.display"}
		</div>
	</div>
</main>

{include file="frontend/components/footer.tpl"}
