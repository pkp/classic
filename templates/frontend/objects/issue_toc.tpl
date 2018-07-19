{**
 * templates/frontend/objects/issue_toc.tpl
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2003-2018 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief View of an Issue which displays a full table of contents.
 *
 * @uses $issue Issue The issue
 * @uses $issueTitle string Title of the issue. May be empty
 * @uses $issueSeries string Vol/No/Year string for the issue
 * @uses $issueGalleys array Galleys for the entire issue
 * @uses $hasAccess bool Can this user access galleys for this context?
 * @uses $publishedArticles array Lists of articles published in this issue
 *   sorted by section.
 * @uses $primaryGenreIds array List of file genre ids for primary file types
 *}

<div class="obj_issue_toc">

	{* Published date *}
	{if $issue->getDatePublished()}
		<div class="published">
			<span class="date_label">
				{translate key="submissions.published"}
			</span>
			<span class="date_format">
					{$issue->getDatePublished()|date_format:$dateFormatLong}
			</span>
		</div>
	{/if}

	{* Indicate if this is only a preview *}
	{if !$issue->getPublished()}
		{include file="frontend/components/notification.tpl" type="warning" messageKey="editor.issues.preview"}
	{/if}

	{* Issue introduction area above articles *}
	{if $issue->hasDescription() || $issue->getLocalizedCoverImageUrl()}
		<div class="issue_heading">
			{* Description *}
			<div class="flex_container description_cover">
				{if $issue->hasDescription()}
					<div class="description">
						<h2 class="description_label">{translate key="plugins.themes.classic.issueDescription"}</h2>
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
							     src="{$issueCover|escape}"{if $issue->getLocalizedCoverImageAltText() != ''} alt="{$issue->getLocalizedCoverImageAltText()|escape}"{/if}>
						</a>
					</div>
				{/if}
			</div>
		</div>
	{/if}

	{* Full-issue galleys *}
	{if $issueGalleys}
		<div class="galleys">
			<h2 class="sr-only">
				{translate key="issue.tableOfContents"}
			</h2>
			<ul class="galleys_links">
				{foreach from=$issueGalleys item=galley}
					<li>
						{include file="frontend/objects/galley_link.tpl" parent=$issue purchaseFee=$currentJournal->getSetting('purchaseIssueFee') purchaseCurrency=$currentJournal->getSetting('currency')}
					</li>
				{/foreach}
			</ul>
		</div>
	{/if}

	{* Articles *}
	<div class="sections">
		<h2 class="sr-only">
			{translate key="issue.tableOfContents"}
		</h2>
		{foreach name=sections from=$publishedArticles item=section}
			<div class="section">
				{if $section.articles}
					{if $section.title}
						<h3 class="section_title">
							{$section.title|escape}
						</h3>
					{/if}
					<div class="section_content">
						{foreach from=$section.articles item=article}
							{include file="frontend/objects/article_summary.tpl"}
						{/foreach}
					</div>
				{/if}
			</div>
		{/foreach}
	</div><!-- .sections -->

	<a class="read_more btn btn-secondary" href="{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive"}">
		{translate key="journal.viewAllIssues"}
	</a>
</div>
