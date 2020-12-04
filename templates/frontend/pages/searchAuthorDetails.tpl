{**
 * templates/frontend/pages/searchAuthorDetails.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Index of published articles by author.
 *
 *}
{strip}
	{assign var="pageTitle" value="search.authorDetails"}
	{include file="frontend/components/header.tpl"}
{/strip}

<div class="page page-author-details">
	<div class="container-fluid container-page container-narrow">
		{include file="frontend/components/headings.tpl" currentTitleKey="search.authorDetails"}

		<div class="page-content" id="authorDetails">
			<h3 class="author-details-author text-lg-center">{$authorName|escape}{if $affiliation}, {$affiliation|escape}{/if}{if $country}, {$country|escape}{/if}</h3>
			<ul class="author-details-articles">
				{foreach from=$submissions item=article}
					{assign var=issueId value=$article->getCurrentPublication()->getData('issueId')}
					{assign var=issue value=$issues[$issueId]}
					{assign var=issueUnavailable value=$issuesUnavailable.$issueId}
					{assign var=sectionId value=$article->getCurrentPublication()->getData('sectionId')}
					{assign var=journalId value=$article->getData('contextId')}
					{assign var=journal value=$journals[$journalId]}
					{assign var=section value=$sections[$sectionId]}
					{if $issue->getPublished() && $section && $journal}
						<li class="author-details-item">
							<div class="author-details-block author-details-issue">
								<a href="{url journal=$journal->getPath() page="issue" op="view" path=$issue->getBestIssueId()}">{$journal->getLocalizedName()|escape} {$issue->getIssueIdentification()|strip_unsafe_html|nl2br}</a>
							</div>
							<div class="author-details-block author-details-section">
								<span>{$section->getLocalizedTitle()|escape}</span>
							</div>
							<div class="author-details-block author-details-article">
								<a href="{url journal=$journal->getPath() page="article" op="view" path=$article->getBestId()}">{$article->getCurrentPublication()->getLocalizedTitle()|strip_unsafe_html}</a>
							</div>
							{if (!$issueUnavailable || $article->getCurrentPublication()->getData('accessStatus') == $smarty.const.ARTICLE_ACCESS_OPEN)}
								<div class="author-details-block author-details-galleys">
									{foreach from=$article->getGalleys() item=galley name=galleyList}
										<a href="{url journal=$journal->getPath() page="article" op="view" path=$article->getBestId()|to_array:$galley->getBestGalleyId()}"
										   class="btn btn-primary">{$galley->getGalleyLabel()|escape}</a>
									{/foreach}
								</div>
							{/if}
						</li>
					{/if}
				{/foreach}
			</ul>
		</div>

	</div>
</div>

{include file="frontend/components/footer.tpl"}

