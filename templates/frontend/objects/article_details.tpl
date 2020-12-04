 {**
 * templates/frontend/objects/article_details.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief View of an Article which displays all details about the article.
 *
 * @uses $article Article This article
 * @uses $publication Publication The publication being displayed
 * @uses $firstPublication Publication The first published version of this article
 * @uses $currentPublication Publication The most recently published version of this article
 * @uses $issue Issue The issue this article is assigned to
 * @uses $section Section The journal section this article is assigned to
 * @uses $primaryGalleys array List of article galleys that are not supplementary or dependent
 * @uses $supplementaryGalleys array List of article galleys that are supplementary
 * @uses $keywords array List of keywords assigned to this article
 * @uses $pubIdPlugins Array of pubId plugins which this article may be assigned
 * @uses $licenseTerms string License terms.
 * @uses $licenseUrl string URL to license. Only assigned if license should be
 *   included with published articles.
 * @uses $ccLicenseBadge string An image and text with details about the license
 * @uses $boolAuthorInfo bool to check whether at least one author has additional info
 *}

<article class="obj_article_details">
	<div class="article_header_wrapper">
		{* Notification that this is an old version *}
		{if $currentPublication->getId() !== $publication->getId()}
		<div class="cmp_notification notice" role="alert">
			{capture assign="latestVersionUrl"}{url page="article" op="view" path=$article->getBestId()}{/capture}
			{translate key="submission.outdatedVersion"
				datePublished=$publication->getData('datePublished')|date_format:$dateFormatShort
				urlRecentVersion=$latestVersionUrl|escape
			}
		</div>
		{/if}

		<div class="article_issue_credentials">
			<a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">{$issue->getIssueIdentification()|escape}</a>
		</div>
		<div class="article_section_title">
			{$section->getLocalizedTitle()}
		</div>
		<div class="row">
			<div class="col-md-8">

				{* article title, subtitle and authors *}
				<h1 class="page_title article-full-title">
					{$publication->getLocalizedFullTitle()|escape}
				</h1>


			</div>

			<div class="col-md-4">

				{* Article Galleys *}
				{if $primaryGalleys}
					<div class="item galleys">
						{foreach from=$primaryGalleys item=galley}
							{include file="frontend/objects/galley_link.tpl" parent=$article publication=$publication galley=$galley purchaseFee=$currentJournal->getSetting('purchaseArticleFee') purchaseCurrency=$currentJournal->getSetting('currency')}
						{/foreach}
					</div>
				{/if}
				{if $supplementaryGalleys}
					<div class="item galleys">
						{foreach from=$supplementaryGalleys item=galley}
							{include file="frontend/objects/galley_link.tpl" parent=$article publication=$publication galley=$galley isSupplementary="1"}
						{/foreach}
					</div>
				{/if}

			</div>

			<div class="col-md-12">

				{* authors list *}
				{if $publication->getData('authors')}
					<div class="authors_info">
						<ul class="entry_authors_list">
							{strip}
								{foreach from=$publication->getData('authors') item=author key=authorNumber}
									<li class="entry_author_block{if $authorNumber > 4} limit-for-mobiles{elseif $authorNumber === 4} fifth-author{/if}">
										{if $author->getData('rorId')}
											<a class="ror-image-url" href="{$author->getData('rorId')|escape}">{$rorIdIcon}</a>
										{/if}
										{if $author->getOrcid()}
											<a class="orcid-image-url" href="{$author->getOrcid()}">
												{if $orcidIcon}
													{$orcidIcon}
												{else}
													<img src="{$baseUrl}/{$orcidImageUrl}">
												{/if}
											</a>
										{/if}
										<span class="name_wrapper">
											{$author->getFullName()|escape}
										</span>
										{if $authorNumber+1 !== $publication->getData('authors')|@count}
											<span class="author-delimiter">, </span>
										{/if}
									</li>
								{/foreach}
								{if $publication->getData('authors')|@count > 4}
									<span class="collapse-authors" id="show-all-authors"><ion-icon name="add-circle"></ion-icon></span>
									<span class="collapse-authors hide" id="hide-authors"><ion-icon name="remove-circle"></ion-icon></ion-icon></span>
								{/if}
							{/strip}
						</ul>
					</div>
					<div class="additional-authors-info">
						{if $boolAuthorInfo}
							<a class="more-authors-info-button" id="collapseButton" data-toggle="collapse" href="#authorInfoCollapse" role="button" aria-expanded="false" aria-controls="authorInfoCollapse">
								<ion-icon name="add" class="ion_icon" id="more-authors-data-symbol"></ion-icon>
								<ion-icon name="remove" class="ion_icon hide" id="less-authors-data-symbol"></ion-icon>
								<span class="ion-icon-text">{translate key="plugins.themes.classic.more-info"}</span>
							</a>
						{/if}
						<div class="collapse" id="authorInfoCollapse">
							{foreach from=$publication->getData('authors') item=author key=number}
								<div class="additional-author-block">
									{if $author->getLocalizedAffiliation() || $author->getLocalizedBiography()}
										<span class="additional-author-name">{$author->getFullName()|escape}</span>
									{/if}
									{if $author->getLocalizedAffiliation()}
										<br/>
										<span class="additional-author-affiliation">{$author->getLocalizedAffiliation()|escape}</span>
									{/if}
									{if $author->getLocalizedBiography()}
										<br/>
										<a class="more_button" data-toggle="modal" data-target="#modalAuthorBio-{$number}">
											{translate key="plugins.themes.classic.biography"}
										</a>
										{* author's biography *}
										<div class="modal fade" id="modalAuthorBio-{$number}" tabindex="-1" role="dialog" aria-labelledby="modalAuthorBioTitle" aria-hidden="true">
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
			{if $publication->getLocalizedData('coverImage') || ($issue && $issue->getLocalizedCoverImage())}
				<div class="article_cover_wrapper">
					{if $publication->getLocalizedData('coverImage')}
						{assign var="coverImage" value=$publication->getLocalizedData('coverImage')}
						<img
							class="img-fluid"
							src="{$publication->getLocalizedCoverImageUrl($article->getData('contextId'))|escape}"
							alt="{$coverImage.altText|escape|default:''}"
						>
					{else}
						<a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
							<img
								class="img-fluid"
								src="{$issue->getLocalizedCoverImageUrl()|escape}"
								alt="{$issue->getLocalizedCoverImageAltText()|escape|default:''}"
							>
						</a>
					{/if}
				</div>
			{/if}

			{* DOI (requires plugin) *}
			{foreach from=$pubIdPlugins item=pubIdPlugin}
				{if $pubIdPlugin->getPubIdType() != 'doi'}
					{continue}
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
								{$doiUrl}
							</a>
						</span>
					</div>
				{/if}
			{/foreach}

			{if $categories}
				<div class="categories">
					<span class="categories_label">{translate key="category.category"}</span>
					<ul class="categories">
						{foreach from=$categories item=category}
							<li><a href="{url router=$smarty.const.ROUTE_PAGE page="catalog" op="category" path=$category->getPath()|escape}">{$category->getLocalizedTitle()|escape}</a></li>
						{/foreach}
					</ul>
				</div>
			{/if}

			{* Publication & update dates; previous versions *}
			{if $publication->getData('datePublished')}
        		<p>
          			{translate key="submissions.published"}
          			{* If this is the original version *}
          			{if $firstPublication->getID() === $publication->getId()}
            			{$firstPublication->getData('datePublished')|date_format:$dateFormatShort}
					{* If this is an updated version *}
          			{else}
            			{translate key="submission.updatedOn" datePublished=$firstPublication->getData('datePublished')|date_format:$dateFormatShort dateUpdated=$publication->getData('datePublished')|date_format:$dateFormatShort}
          			{/if}
        		</p>

        		{if count($article->getPublishedPublications()) > 1}
          			<h3>{translate key="submission.versions"}</h3>
          			<ul>
						{foreach from=array_reverse($article->getPublishedPublications()) item=iPublication}
							{capture assign="name"}{translate key="submission.versionIdentity" datePublished=$iPublication->getData('datePublished')|date_format:$dateFormatShort version=$iPublication->getData('version')}{/capture}
							<li>
								{if $iPublication->getId() === $publication->getId()}
									{$name}
								{elseif $iPublication->getId() === $currentPublication->getId()}
									<a href="{url page="article" op="view" path=$article->getBestId()}">{$name}</a>
								{else}
									<a href="{url page="article" op="view" path=$article->getBestId()|to_array:"version":$iPublication->getId()}">{$name}</a>
								{/if}
							</li>
						{/foreach}
          			</ul>
        		{/if}
      		{/if}

			{* Keywords *}
			{assign 'keywords' $publication->getLocalizedData('keywords')}
			{if !empty($keywords)}
			<div class="item keywords">
				{strip}
				<h3>
					{translate key="article.subject"}
				</h3>
				<ul class="keywords_value">
					{foreach from=$keywords key=k item=keyword}
						<li class="keyword_item{if $k>4} more-than-five{/if}">
							<span>{$keyword|escape}</span>{if $k+1 < $keywords|@count}<span class="keyword-delimeter{if $k === 4} fifth-keyword-delimeter hide{/if}">,</span>{/if}
						</li>
					{/foreach}
					{if $keywords|@count > 5}<span class="ellipsis" id="keywords-ellipsis">...</span>
						<a class="more_button" id="more_keywords">
							{translate key="plugins.themes.classic.more"}
						</a>
						<br/>
						<a class="more_button hide" id="less_keywords">
							{translate key="plugins.themes.classic.less"}
						</a>
					{/if}
				</ul>
				{/strip}
			</div>
			{/if}


			{* How to cite *}
			{if $citation}
				<div class="item citation">
					<div class="sub_item citation_display">
						<h3>
							{translate key="submission.howToCite"}
						</h3>
						<div class="citation_format_value">
							<div id="citationOutput" role="region" aria-live="polite">
								{$citation}
							</div>
							<div class="citation_formats dropdown">
								<button class="btn btn-primary" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true"
								        aria-expanded="false">
									{translate key="submission.howToCite.citationFormats"}
								</button>
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
			{assign 'licenseTerms' $currentContext->getLocalizedData('licenseTerms')}
			{assign 'copyrightHolder' $publication->getLocalizedData('copyrightHolder')}
			{* overwriting deprecated variables *}
			{assign 'licenseUrl' $publication->getData('licenseUrl')}
			{assign 'copyrightYear' $publication->getData('copyrightYear')}

			{if $licenseTerms || $licenseUrl}
				<div class="item copyright">
					{if $licenseUrl}
						{if $ccLicenseBadge}
							{if $copyrightHolder}
								<p>{translate key="submission.copyrightStatement" copyrightHolder=$copyrightHolder|escape copyrightYear=$copyrightYear|escape}</p>
							{/if}
							{$ccLicenseBadge}
						{else}
							<a href="{$licenseUrl|escape}" class="copyright">
								{if $copyrightHolder}
									{translate key="submission.copyrightStatement" copyrightHolder=$copyrightHolder|escape copyrightYear=$copyrightYear|escape}
								{else}
									{translate key="submission.license"}
								{/if}
							</a>
						{/if}
					{/if}
					{* License terms modal. Show only if license url is absent *}
					{if $licenseTerms && !$licenseUrl}
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
										{$licenseTerms|strip_unsafe_html}
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
			{if $publication->getLocalizedData('abstract')}
				<div class="abstract">
					<h2>{translate key="article.abstract"}</h2>
					{$publication->getLocalizedData('abstract')|strip_unsafe_html}
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
			{if $parsedCitations || $publication->getData('citationsRaw')}
				<div class="item references">
					<h3 class="label">
						{translate key="submission.citations"}
					</h3>
					{if $parsedCitations}
						<ol class="references-list">
							{foreach from=$parsedCitations item=parsedCitation}
								<li>{$parsedCitation->getCitationWithLinks()|strip_unsafe_html} {call_hook name="Templates::Article::Details::Reference" citation=$parsedCitation}</li>
							{/foreach}
						</ol>
					{else}
						<div class="value">
							{$publication->getData('citationsRaw')|escape|nl2br}
						</div>
					{/if}
				</div>
			{/if}

		</div><!-- .article_abstract_block -->
	</div><!-- .row -->

</article>
