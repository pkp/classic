{**
 * templates/frontend/pages/indexJournal.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
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

	{* Display homepage image if set, and wrap around journal summary if use chooses to display it *}
	{if $homepageImage}
		<div
			class="homepage_image"
			style="background: {if $showJournalSummary}linear-gradient(rgba(0, 0, 0, 0.75), rgba(0, 0, 0, 0.75)), {/if}url('{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}')">
	{/if}

	{if $showJournalSummary && $currentJournal->getLocalizedDescription()}
		<section class="container journal_summary"{if $homepageImage}style="color: #FFF"{/if}>
			<h2>{translate key="navigation.about"}</h2>
			{$currentJournal->getLocalizedDescription()}
		</section>
	{/if}

	{if $homepageImage}
		</div>
	{/if}

	<div class="container-fluid container-page">

		{* Announcements *}
		{if $announcements}
			<section class="announcements">
				<h2>{translate key="announcement.announcements"}</h2>
				<div class="row">
					{foreach from=$announcements item=announcement}
						<article class="col-md-4 announcement">
							<p class="announcement_date">{$announcement->getDatePosted()|date_format:$dateFormatShort|escape}</p>
							<h3 class="announcement_title">
								<a href="{url router=$smarty.const.ROUTE_PAGE page="announcement" op="view" path=$announcement->getId()|escape}">
									{$announcement->getLocalizedTitle()|escape}
								</a>
							</h3>
						</article>
					{/foreach}
				</div>
			</section>
		{/if}

		{call_hook name="Templates::Index::journal"}

		{* Latest issue *}
		{if $issue}
			<section class="current_issue">
				<header>
					{strip}
						<h2 class="current_issue_title">
							<span class="current_issue_label">{translate key="journal.currentIssue"}</span>
							{if $issueIdentificationString}
						 		<span class="current_issue_identification">{$issueIdentificationString|escape}</span>
							{/if}
						</h2>
					{/strip}

					{* Published date *}
					{if $issue->getDatePublished()}
						<p class="published">
							<span class="date_label">
								{translate key="submissions.published"}
							</span>
							<span class="date_format">
									{$issue->getDatePublished()|date_format:$dateFormatLong}
							</span>
						</p>
					{/if}
				</header>
				{include file="frontend/objects/issue_toc.tpl"}
			</section>
		{/if}

		{* Additional Homepage Content *}
		{if $additionalHomeContent}
			<section class="additional_content">
				{$additionalHomeContent}
			</section>
		{/if}
	</div>
</main><!-- .page -->

{include file="frontend/components/footer.tpl"}
