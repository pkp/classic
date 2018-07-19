{**
 * templates/frontend/pages/indexJournal.tpl
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2003-2018 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the index page for a journal
 *
 * @uses $currentJournal Journal This journal
 * @uses $journalDescription string Journal description from HTML text editor
 * @uses $homepageImage object Image to be displayed on the homepage
 * @uses $additionalHomeContent string Arbitrary input from HTML text editor
 * @uses $announcements array List of announcements
 * @uses $numAnnouncementsHomepage int Number of announcements to display on the
 *       homepage
 * @uses $issue Issue Current issue
 * @uses $issueIdentificationString string issue identification that relies on user's settings
 *}

{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}

<main class="page_index_journal">
	<div class="container-fluid container-page">

		{call_hook name="Templates::Index::journal"}

		{* Latest issue *}
		{if $issue}
			<div class="current_issue">
				{strip}
					<span class="current_issue_label">{translate key="journal.currentIssue"}</span>
					{if $issueIdentificationString}
						<h1 class="current_issue_title">{$issueIdentificationString|escape}</h1>
					{/if}
				{/strip}
				{include file="frontend/objects/issue_toc.tpl"}
			</div>
		{/if}

		{* Additional Homepage Content *}
		{if $additionalHomeContent}
			<div class="additional_content">
				{$additionalHomeContent}
			</div>
		{/if}
	</div>
</main><!-- .page -->

{include file="frontend/components/footer.tpl"}
