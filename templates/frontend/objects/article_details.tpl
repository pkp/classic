{**
 * templates/frontend/objects/article_details.tpl
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2003-2018 John Willinsky
 * Copyright (c) 2018 Vitalii Bezsheiko
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief View of an Article which displays all details about the article.
 *
 * @uses $article Article This article
 * @uses $issue Issue The issue this article is assigned to
 * @uses $section Section The journal section this article is assigned to
 * @uses $primaryGalleys array List of article galleys that are not supplementary or dependent
 * @uses $supplementaryGalleys array List of article galleys that are supplementary
 * @uses $keywords array List of keywords assigned to this article
 * @uses $pubIdPlugins Array of pubId plugins which this article may be assigned
 * @uses $copyright string Copyright notice. Only assigned if statement should
 *   be included with published articles.
 * @uses $copyrightHolder string Name of copyright holder
 * @uses $copyrightYear string Year of copyright
 * @uses $licenseUrl string URL to license. Only assigned if license should be
 *   included with published articles.
 * @uses $ccLicenseBadge string An image and text with details about the license
 *}
<article class="obj_article_details">
	<div class="article_header_wrapper">
		<div class="article_issue_credentials">
			{$issue->getIssueIdentification()|strip_unsafe_html}
		</div>
		<div class="article_section_title">
			{$section->getLocalizedTitle()}
		</div>
		<div class="row">
			<div class="col-md-8">

				{* article title, subtitle and authors *}
				<h1 class="page_title article-full-title">
					{$article->getLocalizedFullTitle()|escape}
				</h1>


			</div>

			<div class="col-md-4">

				{* Article Galleys *}
				{if $primaryGalleys}
					<div class="item galleys">
						{foreach from=$primaryGalleys item=galley}
							{include file="frontend/objects/galley_link.tpl" parent=$article galley=$galley purchaseFee=$currentJournal->getSetting('purchaseArticleFee') purchaseCurrency=$currentJournal->getSetting('currency')}
						{/foreach}
					</div>
				{/if}
				{if $supplementaryGalleys}
					<div class="item galleys">
						{foreach from=$supplementaryGalleys item=galley}
							{include file="frontend/objects/galley_link.tpl" parent=$article galley=$galley isSupplementary="1"}
						{/foreach}
					</div>
				{/if}

			</div>

			<div class="col-md-12">

				{* authors list *}
				{if $article->getAuthors()}
					<div class="authors_info">
						<ul class="entry_authors_list">
							{strip}
								{foreach from=$article->getAuthors() item=author key=number}
									<li class="entry_author_block">
										{if $author->getOrcid()}
											<a class="orcid-image-url" href="{$author->getOrcid()}"><img src="{$orcidImageUrl}"></a>
										{/if}
										<span class="name_wrapper">
											{$author->getFullName()|escape}
											{if $author->getLocalizedAffiliation()}
												<span class="author-affiliation">
													{$author->getLocalizedAffiliation()|escape}
												</span>
											{/if}
										</span>
									</li>
								{/foreach}
							{/strip}
						</ul>
					</div>
				{/if}
			</div>
		</div>
	</div>

	<div class="row article_main_data">
		<div class="main_entry col-md-4">

			{* Article/Issue cover image *}
			{if $article->getLocalizedCoverImage() || $issue->getLocalizedCoverImage()}
				<div class="article_cover_wrapper">
					{if $article->getLocalizedCoverImage()}
						<img class="img-fluid" src="{$article->getLocalizedCoverImageUrl()|escape}"{if $article->getLocalizedCoverImageAltText()} alt="{$article->getLocalizedCoverImageAltText()|escape}"{/if}>
					{else}
						<a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
							<img class="img-fluid" src="{$issue->getLocalizedCoverImageUrl()|escape}"{if $issue->getLocalizedCoverImageAltText()} alt="{$issue->getLocalizedCoverImageAltText()|escape}"{/if}>
						</a>
					{/if}
				</div>
			{/if}

			{* DOI (requires plugin) *}
			{foreach from=$pubIdPlugins item=pubIdPlugin}
				{if $pubIdPlugin->getPubIdType() != 'doi'}
					{php}continue;{/php}
				{/if}
				{assign var=pubId value=$article->getStoredPubId($pubIdPlugin->getPubIdType())}
				{if $pubId}
					{assign var="doiUrl" value=$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
					<div class="doi">
						<span class="doi_label">
							{capture assign=translatedDOI}{translate key="plugins.pubIds.doi.readerDisplayName"}{/capture}
							{translate key="semicolon" label=$translatedDOI}
						</span>
						<span class="doi_value">
							<a href="{$doiUrl}">
								{* maching DOI's (with new and old format) *}
								{$doiUrl|regex_replace:"/http.*org\//":" "}
							</a>
						</span>
					</div>
				{/if}
			{/foreach}

			{* Published date *}
			{if $article->getDatePublished()}
				<div class="published_date">
					<span class="published_date_label">
						{translate key="submissions.published"}
					</span>
					<span class="published_date_value">
						{$article->getDatePublished()|date_format:$dateFormatLong}
					</span>
				</div>
			{/if}

			{* Keywords *}
			{if !empty($keywords[$currentLocale])}
			<div class="item keywords">
				{strip}
				<div class="keywords_label">
					{translate key="article.subject"}
				</div>
				<ul class="keywords_value">
					{foreach from=$keywords item=keywordArray}
						{foreach from=$keywordArray item=keyword key=k}
							<li class="keyword_item{if $k>4} more-than-five{/if}">
								<span>{$keyword|escape}</span>{if $k+1 < $keywordArray|@count}<span class="keyword-delimeter">,</span>{/if}
							</li>
						{/foreach}
						{if $keywordArray|@count > 5}<span class="ellipsis">...</span>
							<a class="more_button" id="more_keywords">
								{translate key="plugins.themes.humanities.more"}
							</a>
						{/if}
					{/foreach}
				</ul>
				{/strip}
			</div>
			{/if}


			{* How to cite *}
			{if $citation}
				<div class="item citation">
					<div class="sub_item citation_display">
						<div class="citation_format_label">
							{translate key="submission.howToCite"}
						</div>
						<div class="citation_format_value">
							<div id="citationOutput" role="region" aria-live="polite">
								{$citation}
							</div>
							<div class="citation_formats dropdown">
								<a class="btn-sunshine citation_dropdown_button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true"
								        aria-expanded="false">
									{translate key="submission.howToCite.citationFormats"}
								</a>
								<div class="dropdown-menu" aria-labelledby="dropdownMenuButton" id="dropdown-cit">
									{foreach from=$citationStyles item="citationStyle"}
										<a
												class="dropdown-cite-link dropdown-item"
												aria-controls="citationOutput"
												href="{url page="citationstylelanguage" op="get" path=$citationStyle.id params=$citationArgs}"
												data-load-citation
												data-json-href="{url page="citationstylelanguage" op="get" path=$citationStyle.id params=$citationArgsJson}"
										>
											{$citationStyle.title|escape}
										</a>
									{/foreach}
									{if count($citationDownloads)}
										<div class="dropdown-divider"></div>
										<h4 class="download-cite">
											{translate key="submission.howToCite.downloadCitation"}
										</h4>
										{foreach from=$citationDownloads item="citationDownload"}
											<a class="dropdown-item"
											   href="{url page="citationstylelanguage" op="download" path=$citationDownload.id params=$citationArgs}">
												<span class="fa fa-download"></span>
												{$citationDownload.title|escape}
											</a>
										{/foreach}
									{/if}
								</div>
							</div>
						</div>
					</div>
				</div>
			{/if}

			{* Licensing info *}
			{if $copyright || $licenseUrl}
				<div class="item copyright">
					{if $licenseUrl}
						{if $ccLicenseBadge}
							{if $copyrightHolder}
								<p>{translate key="submission.copyrightStatement" copyrightHolder=$copyrightHolder copyrightYear=$copyrightYear}</p>
							{/if}
							{$ccLicenseBadge}
						{else}
							<a href="{$licenseUrl|escape}" class="copyright">
								{if $copyrightHolder}
									{translate key="submission.copyrightStatement" copyrightHolder=$copyrightHolder copyrightYear=$copyrightYear}
								{else}
									{translate key="submission.license"}
								{/if}
							</a>
						{/if}
					{/if}
					{$copyright}
				</div>
			{/if}

			{call_hook name="Templates::Article::Details"}

		</div><!-- .main_entry -->

		<div class="article_abstract_block col-md-8">

			{* Abstract *}
			{if $article->getLocalizedAbstract()}
				<div class="abstract">
					<h3 class="abstract_label">{translate key="article.abstract"}</h3>
					{$article->getLocalizedAbstract()|strip_unsafe_html}
				</div>
			{/if}

			{* Article Galleys only for mobile view *}
			<div class="for-mobile-view">
				{if $primaryGalleys}
					<div class="item galleys">
						{foreach from=$primaryGalleys item=galley}
							{include file="frontend/objects/galley_link.tpl" parent=$article galley=$galley purchaseFee=$currentJournal->getSetting('purchaseArticleFee') purchaseCurrency=$currentJournal->getSetting('currency')}
						{/foreach}
					</div>
				{/if}
				{if $supplementaryGalleys}
					<div class="item galleys">
						{foreach from=$supplementaryGalleys item=galley}
							{include file="frontend/objects/galley_link.tpl" parent=$article galley=$galley isSupplementary="1"}
						{/foreach}
					</div>
				{/if}
			</div>

			{call_hook name="Templates::Article::Main"}

			{* Author biographies *}
			{assign var="hasBiographies" value=0}
			{foreach from=$article->getAuthors() item=author}
				{if $author->getLocalizedBiography()}
					{assign var="hasBiographies" value=$hasBiographies+1}
				{/if}
			{/foreach}
			{if $hasBiographies}
				<div class="item author_bios">
					<h3 class="label">
						{if $hasBiographies > 1}
							{translate key="submission.authorBiographies"}
						{else}
							{translate key="submission.authorBiography"}
						{/if}
					</h3>
					{foreach from=$article->getAuthors() item=author}
						{if $author->getLocalizedBiography()}
							<div class="sub_item">
								<div class="label">
									{if $author->getLocalizedAffiliation()}
										{capture assign="authorName"}{$author->getFullName()|escape}{/capture}
										{capture assign="authorAffiliation"}<span class="affiliation">{$author->getLocalizedAffiliation()|escape}</span>{/capture}
										{translate key="submission.authorWithAffiliation" name=$authorName affiliation=$authorAffiliation}
									{else}
										{$author->getFullName()|escape}
									{/if}
								</div>
								<div class="value">
									{$author->getLocalizedBiography()|strip_unsafe_html}
								</div>
							</div>
						{/if}
					{/foreach}
				</div>
			{/if}

			{* References *}
			{if $parsedCitations->getCount() || $article->getCitations()}
				<div class="item references">
					<h3 class="label">
						{translate key="submission.citations"}
					</h3>
					<div class="value">
						{if $parsedCitations->getCount()}
							{iterate from=parsedCitations item=parsedCitation}
								<p>{$parsedCitation->getCitationWithLinks()|strip_unsafe_html} {call_hook name="Templates::Article::Details::Reference" citation=$parsedCitation}</p>
							{/iterate}
						{elseif $article->getCitations()}
							{$article->getCitations()|nl2br}
						{/if}
					</div>
				</div>
			{/if}

		</div><!-- .article_abstract_block -->
	</div><!-- .row -->

</article>
