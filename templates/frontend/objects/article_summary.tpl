{**
 * templates/frontend/objects/article_summary.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief View of an Article summary which is shown within a list of articles.
 *
 * @uses $article Article The article
 * @uses $authorUserGroups Traversible The set of author user groups
 * @uses $hasAccess bool Can this user access galleys for this context? The
 *       context may be an issue or an article
 * @uses $showDatePublished bool Show the date this article was published?
 * @uses $hideGalleys bool Hide the article galleys for this article?
 * @uses $primaryGenreIds array List of file genre ids for primary file types
 *}

{assign var="articlePath" value=$article->getBestId()}
{assign var="publication" value=$article->getCurrentPublication()}
{if $headingLevel}
	{assign var="heading" value="h{$headingLevel}"}
{else}
	{assign var="heading" value="div"}
{/if}

{if (!$section.hideAuthor && $publication->getData('hideAuthor') == \APP\submission\Submission::AUTHOR_TOC_DEFAULT) || $publication->getData('hideAuthor') == \APP\submission\Submission::AUTHOR_TOC_SHOW}
	{assign var="showAuthor" value=true}
{/if}

<article class="article_summary">
	<div class="article_summary_body">
		<{$heading} class="summary_title_wrapper">
			<a class="summary_title" {if $journal}href="{url journal=$journal->getPath() page="article" op="view" path=$articlePath}"{else}href="{url page="article" op="view" path=$articlePath}"{/if}>
				{$publication->getLocalizedFullTitle(null, 'html')|strip_unsafe_html}
			</a>
		</{$heading}>

		{assign var=submissionPages value=$publication->getData('pages')}
		{assign var=submissionDatePublished value=$publication->getData('datePublished')}
		{if $showAuthor || $submissionPages || ($submissionDatePublished && $showDatePublished)}
		<div class="summary_meta">
			{if $showAuthor}
			<div class="authors">
				{$publication->getAuthorString($authorUserGroups)|escape}
			</div>
			{/if}

			{* Page numbers for this article *}
			{if $submissionPages}
				<div class="pages">
					{$submissionPages}
				</div>
			{/if}

			{if $showDatePublished && $submissionDatePublished}
				<div class="published">
					{$submissionDatePublished|date_format:$dateFormatShort}
				</div>
			{/if}

		</div>
		{/if}
	</div>

	{if !$hideGalleys}
		<div class="galleys_links">
			{foreach from=$article->getGalleys() item=galley}
				{if $primaryGenreIds}
					{assign var="file" value=$galley->getFile()}
					{if !$galley->getRemoteUrl() && !($file && in_array($file->getGenreId(), $primaryGenreIds))}
						{continue}
					{/if}
				{/if}
				{assign var="hasArticleAccess" value=$hasAccess}
				{if $currentContext->getSetting('publishingMode') == \APP\journal\Journal::PUBLISHING_MODE_OPEN || $publication->getData('accessStatus') == \APP\submission\Submission::ARTICLE_ACCESS_OPEN}
					{assign var="hasArticleAccess" value=1}
				{/if}
				{include file="frontend/objects/galley_link.tpl" parent=$article publication=$publication hasAccess=$hasArticleAccess purchaseFee=$currentJournal->getData('purchaseArticleFee') purchaseCurrency=$currentJournal->getData('currency')}
			{/foreach}
		</div>
	{/if}

	{call_hook name="Templates::Issue::Issue::Article"}
</article>
