{**
 * templates/frontend/objects/article_summary.tpl
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2003-2018 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief View of an Article summary which is shown within a list of articles.
 *
 * @uses $article Article The article
 * @uses $hasAccess bool Can this user access galleys for this context? The
 *       context may be an issue or an article
 * @uses $showDatePublished bool Show the date this article was published?
 * @uses $hideGalleys bool Hide the article galleys for this article?
 * @uses $primaryGenreIds array List of file genre ids for primary file types
 *}

{assign var=articlePath value=$article->getBestArticleId()}

{if (!$section.hideAuthor && $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_DEFAULT) || $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_SHOW}
	{assign var="showAuthor" value=true}
{/if}

<div class="article_summary">
	<div class="article_summary_body">
		<div class="summary_title_wrapper">
			<a class="summary_title" {if $journal}href="{url journal=$journal->getPath() page="article" op="view" path=$articlePath}"{else}href="{url page="article" op="view" path=$articlePath}"{/if}>
				{$article->getLocalizedFullTitle()|escape}
			</a>
		</div>

		{if $showAuthor || $article->getPages() || ($article->getDatePublished() && $showDatePublished)}
		<div class="summary_meta">
			{if $showAuthor}
			<div class="authors">
				{$article->getAuthorString()}
			</div>
			{/if}

			{* Page numbers for this article *}
			{if $article->getPages()}
				<div class="pages">
					{$article->getPages()|escape}
				</div>
			{/if}

			{if $showDatePublished && $article->getDatePublished()}
				<div class="published">
					{$article->getDatePublished()|date_format:$dateFormatShort}
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
						{php}continue;{/php}
					{/if}
				{/if}
				{assign var="hasArticleAccess" value=$hasAccess}
				{if ($article->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN)}
					{assign var="hasArticleAccess" value=1}
				{/if}
				{include file="frontend/objects/galley_link.tpl" parent=$article hasAccess=$hasArticleAccess purchaseFee=$currentJournal->getSetting('purchaseArticleFee') purchaseCurrency=$currentJournal->getSetting('currency')}
			{/foreach}
		</div>
	{/if}

	{call_hook name="Templates::Issue::Issue::Article"}
</div>
