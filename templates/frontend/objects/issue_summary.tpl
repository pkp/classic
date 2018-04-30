{**
 * templates/frontend/objects/issue_summary.tpl
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2003-2018 John Willinsky
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
			<img class="archive_issue_cover" src="{$issueCover|escape}"{if $issue->getLocalizedCoverImageAltText() != ''} alt="{$issue->getLocalizedCoverImageAltText()|escape}"{/if}>
		</a>
	{/if}

	<a class="issue_summary_title" href="{url op="view" path=$issue->getBestIssueId()}">
		<span class="current_issue_year">{$issue->getYear()|strip_unsafe_html}</span>
		<span class="current_issue_volume">{translate key="issue.vol"}. {$issue->getVolume()|strip_unsafe_html}</span>
		<span class="current_issue_number">{translate key="issue.no"} {$issue->getNumber()|strip_unsafe_html}</span>
	</a>
	{if $issueTitle && $issueSeries}
		<div class="series">
			{$issueSeries|escape}
		</div>
	{/if}

	<div class="issue_summary_date">
		{$issue->getDatePublished()|date_format:$dateFormatLong}
	</div>

	<div class="issue_summary_description">
		{assign var=issueDescription value=$issue->getLocalizedDescription()|strip_unsafe_html}
		{if $issueDescription|strlen < 200}
			<div class="issue_summary_description_text">
				{$issueDescription}
			</div>
		{else}
			<div class="issue_summary_description_text">
				{$issueDescription|substr:0:200|mb_convert_encoding:'UTF-8'|replace:'?':''}<span
						class="three_dots">...</span>
			</div>
		{/if}
	</div>
</div><!-- .obj_issue_summary -->
