 {**
 * templates/frontend/objects/article_details.tpl
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2003-2018 John Willinsky
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
								{foreach from=$article->getAuthors() item=author key=authorNumber}
									<li class="entry_author_block{if $authorNumber > 4} limit-for-mobiles{elseif $authorNumber === 4} fifth-author{/if}">
										{if $author->getOrcid()}
											<a class="orcid-image-url" href="{$author->getOrcid()}"><img src="{$baseUrl}/{$orcidImageUrl}"></a>
										{/if}
										<span class="name_wrapper">
											{$author->getFullName()|escape}
										</span>
										{if $authorNumber+1 !== $article->getAuthors()|@count}
											<span class="author-delimiter">, </span>
										{/if}
									</li>
								{/foreach}
								{if $article->getAuthors()|@count > 4}
									<span class="collapse-authors" id="show-all-authors"><ion-icon name="add-circle"></ion-icon></span>
									<span class="collapse-authors hide" id="hide-authors"><ion-icon name="remove-circle"></ion-icon></ion-icon></span>
								{/if}
							{/strip}
						</ul>
					</div>
					<div class="additional-authors-info">
						<a class="more-authors-info-button" id="collapseButton" data-toggle="collapse" href="#authorInfoCollapse" role="button" aria-expanded="false" aria-controls="authorInfoCollapse">
							<ion-icon name="add" class="ion_icon" id="more-authors-data-symbol"></ion-icon>
							<ion-icon name="remove" class="ion_icon hide" id="less-authors-data-symbol"></ion-icon>
							<span class="ion-icon-text">{translate key="plugins.themes.classic.more-info"}</span>
						</a>
						<div class="collapse" id="authorInfoCollapse">
							{foreach from=$article->getAuthors() item=author}
								<div class="additional-author-block">
									<span class="additional-author-name">{$author->getFullName()|escape}</span>
									{if $author->getLocalizedAffiliation()}
										<br/>
										<span class="additional-author-affiliation">{$author->getLocalizedAffiliation()|escape}</span>
									{/if}
									{if $author->getLocalizedBiography()}
										<br/>
										<a class="more_button" data-toggle="modal" data-target="#modalAuthorBio">
											{translate key="plugins.themes.classic.biography"}
										</a>
										{* author's biography *}
										<div class="modal fade" id="modalAuthorBio" tabindex="-1" role="dialog" aria-labelledby="modalAuthorBioTitle" aria-hidden="true">
											<div class="modal-dialog" role="document">
												<div class="modal-content">
													<div class="modal-header">
														<h5 class="modal-title" id="modalAuthorBioTitle">{translate key="submission.authorBiography"}</h5>
														<button type="button" class="close" data-dismiss="modal" aria-label="Close">
															<span aria-hidden="true">&times;</span>
														</button>
													</div>
													<div class="modal-body">
														{$author->getLocalizedBiography()|strip_unsafe_html}
													</div>
													<div class="modal-footer">
														<button type="button" class="btn btn-primary" data-dismiss="modal">{translate key="plugins.themes.classic.close"}</button>
													</div>
												</div>
											</div>
										</div>
									{/if}
								</div>
							{/foreach}
						</div>
					</div>
				{/if}
			</div>
		</div>
	</div>

	<div class="row article_main_data" id="articleMainData">
		<div class="main_entry col-md-4" id="mainEntry" >

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
								{$doiUrl|escape}
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
								<span>{$keyword|escape}</span>{if $k+1 < $keywordArray|@count}<span class="keyword-delimeter{if $k === 4} fifth-keyword-delimeter hide"{/if}">,</span>{/if}
							</li>
						{/foreach}
						{if $keywordArray|@count > 5}<span class="ellipsis" id="keywords-ellipsis">...</span>
							<a class="more_button" id="more_keywords">
								{translate key="plugins.themes.classic.more"}
							</a>
							<br/>
							<a class="more_button hide" id="less_keywords">
								{translate key="plugins.themes.classic.less"}
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
								<a class="btn btn-primary citation_dropdown_button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true"
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
					{* Copyright modal. Show only if license is absent *}
					{if $copyright && !$licenseUrl}
						<a class="more_button" data-toggle="modal" data-target="#copyrightModal">
							{translate key="about.copyrightNotice"}
						</a>
						<div class="modal fade" id="copyrightModal" tabindex="-1" role="dialog" aria-labelledby="copyrightModalTitle" aria-hidden="true">
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="copyrightModalTitle">{translate key="about.copyrightNotice"}</h5>
										<button type="button" class="close" data-dismiss="modal" aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
									</div>
									<div class="modal-body">
										{$copyright|strip_unsafe_html}
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-primary" data-dismiss="modal">{translate key="plugins.themes.classic.close"}</button>
									</div>
								</div>
							</div>
						</div>
					{/if}
				</div>
			{/if}

			{call_hook name="Templates::Article::Details"}

		</div><!-- .main_entry -->

		<div class="article_abstract_block col-md-8" id="articleAbstractBlock">

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

			{* References *}
			{if $parsedCitations->getCount() || $article->getCitations()}
				<div class="item references">
					<h3 class="label">
						{translate key="submission.citations"}
					</h3>
					{if $parsedCitations->getCount()}
						<ol class="references-list">
							{iterate from=parsedCitations item=parsedCitation}
								<li>{$parsedCitation->getCitationWithLinks()|strip_unsafe_html} {call_hook name="Templates::Article::Details::Reference" citation=$parsedCitation}</li>
							{/iterate}
						</ol>
					{elseif $article->getCitations()}
						<div class="value">
							{$article->getCitations()|nl2br}
						</div>
					{/if}
				</div>
			{/if}

		</div><!-- .article_abstract_block -->
	</div><!-- .row -->

</article>
