{**
 * templates/frontend/pages/indexJournal.tpl
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2003-2018 John Willinsky
 * Copyright (c) 2003-2018 Vitalii Bezsheiko
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
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}

<div class="page_index_journal">
	<div class="container-fluid container-page">

		{call_hook name="Templates::Index::journal"}

		{* Latest issue *}
		{if $issue}
			<div class="current_issue">
				<div class="current_issue_label">
					{translate key="journal.currentIssue"}
				</div>
				<h1 class="current_issue_title">
					<span class="current_issue_year">{$issue->getYear()|strip_unsafe_html}</span>
					<span class="current_issue_volume">{translate key="issue.vol"}. {$issue->getVolume()|strip_unsafe_html}</span>
					<span class="current_issue_number">{translate key="issue.no"} {$issue->getNumber()|strip_unsafe_html}</span>
				</h1>
				{include file="frontend/objects/issue_toc.tpl"}
				<a class="btn-black read_more" href="{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive"}">
					{translate key="journal.viewAllIssues"}
				</a>
			</div>
		{/if}

		{* Additional Homepage Content *}
		{if $additionalHomeContent}
			<div class="additional_content">
				{$additionalHomeContent}
			</div>
		{/if}
	</div>
</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
