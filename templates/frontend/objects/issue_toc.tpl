{**
 * templates/frontend/objects/issue_toc.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief View of an Issue which displays a full table of contents.
 *
 * @uses $issue Issue The issue
 * @uses $issueTitle string Title of the issue. May be empty
 * @uses $issueSeries string Vol/No/Year string for the issue
 * @uses $issueGalleys array Galleys for the entire issue
 * @uses $hasAccess bool Can this user access galleys for this context?
 * @uses $publishedSubmissions array Lists of articles published in this issue
 *   sorted by section.
 * @uses $primaryGenreIds array List of file genre ids for primary file types
 *}

{* Indicate if this is only a preview *}
{if !$issue->getPublished()}
	{include file="frontend/components/notification.tpl" type="warning" messageKey="editor.issues.preview"}
{/if}

{* Issue introduction area above articles *}
{if $issue->hasDescription() || $issue->getLocalizedCoverImageUrl()}
	{* Description *}
	<section class="flex_container description_cover">
		{if $issue->hasDescription()}
			<div class="description">
				<h3 class="description_label">{translate key="plugins.themes.classic.issueDescription"}</h3>
				{assign var=issueDescription value=$issue->getLocalizedDescription()|strip_unsafe_html}
				{if $issueDescription|strlen < 800}
					<div class="description_text">
						{$issueDescription}
					</div>
				{elseif $requestedPage|escape !== "issue"}
					<div class="description_text">
						{$issueDescription|substr:0:800|mb_convert_encoding:'UTF-8'|replace:'?':''}<span
								class="three_dots">...</span>
						<a class="more_button"
						   href="{url op="view" page="issue" path=$issue->getBestIssueId()}">
							{translate key="plugins.themes.classic.more"}
						</a>
					</div>
				{else}
					<div class="description_text">
						{$issueDescription}
					</div>
				{/if}
			</div>
		{/if}

		{* Issue cover image *}
		{assign var=issueCover value=$issue->getLocalizedCoverImageUrl()}
		{if $issueCover}
			<div class="issue_cover_block{if !$issue->hasDescription()} align-left{/if}">
				<a href="{url op="view" page="issue" path=$issue->getBestIssueId()}">
					<img class="cover_image"
					     src="{$issueCover|escape}" {if $issue->getLocalizedCoverImageAltText() != ''}alt="{$issue->getLocalizedCoverImageAltText()|escape}"{else}alt=""{/if}>
				</a>
			</div>
		{/if}
	</section>
{/if}

{* Full-issue galleys *}
{if $issueGalleys}
	<section class="galleys">
		<h4 class="sr-only">
			{translate key="issue.tableOfContents"}
		</h4>
		<ul class="galleys_links">
			{foreach from=$issueGalleys item=galley}
				<li>
					{include file="frontend/objects/galley_link.tpl" parent=$issue purchaseFee=$currentJournal->getSetting('purchaseIssueFee') purchaseCurrency=$currentJournal->getSetting('currency')}
				</li>
			{/foreach}
		</ul>
	</section>
{/if}

{* Articles *}
<section class="sections">
	<h3 class="sr-only">
		{translate key="issue.toc"}
	</h3>
	{foreach name=sections from=$publishedSubmissions item=section}
		<section class="section">
			{if $section.articles}
				{if $section.title}
					<h4 class="section_title">
						{$section.title|escape}
					</h4>
				{/if}
				<div class="section_content">
					{foreach from=$section.articles item=article}
						{include file="frontend/objects/article_summary.tpl" headingLevel="5"}
					{/foreach}
				</div>
			{/if}
		</section>
	{/foreach}
</section><!-- .sections -->

<a class="read_more btn btn-secondary" href="{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive"}">
	{translate key="journal.viewAllIssues"}
</a>
