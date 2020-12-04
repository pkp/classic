{**
 * templates/frontend/objects/issue_summary.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief View of an Issue which displays a summary for use in lists
 *
 * @uses $issue Issue The issue
 *}

{if $issue->getShowTitle()}
{assign var=issueTitle value=$issue->getLocalizedTitle()}
{/if}
{assign var=issueSeries value=$issue->getIssueSeries()}
{assign var=issueCover value=$issue->getLocalizedCoverImageUrl()}

<div class="obj_issue_summary">

	{if $issueCover}
		<a class="cover" href="{url op="view" path=$issue->getBestIssueId()}">
			<img class="archive_issue_cover" src="{$issueCover|escape}" alt="{$issue->getLocalizedCoverImageAltText()|escape|default:''}">
		</a>
	{/if}

	{if $issue->getShowVolume() || $issue->getShowNumber() || $issue->getShowYear()}
		<a class="issue_summary_title" href="{url op="view" path=$issue->getBestIssueId()}">
			{strip}
				{if $issue->getVolume() && $issue->getShowVolume()}
					<span class="current-issue-volume">{translate key="plugins.themes.classic.volume-abbr"} {$issue->getVolume()|escape}</span>
				{/if}
				{if $issue->getNumber() && $issue->getShowNumber()}
					<span class="current-issue-number">{translate key="plugins.themes.classic.number-abbr"} {$issue->getNumber()|escape}</span>
				{/if}
				{if $issue->getYear() && $issue->getShowYear()}
					<span class="current-issue-year">{$issue->getYear()|escape}</span>
				{/if}
			{/strip}
		</a>
	{/if}
	{if $issue->getLocalizedTitle() && $issue->getShowTitle()}
		<a class="issue_title" href="{url op="view" path=$issue->getBestIssueId()}">
			{$issue->getLocalizedTitle()|escape}
		</a>
	{/if}

	<div class="issue_summary_date">
		{$issue->getDatePublished()|date_format:$dateFormatLong}
	</div>
</div><!-- .obj_issue_summary -->
