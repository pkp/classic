{**
 * templates/frontend/pages/indexSite.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Template for side-wide index page
 *
 *}
{include file="frontend/components/header.tpl"}

<div class="page_index_site">
	<div class="container-fluid container-page container-narrow">

		{if $about}
			<div class="about_site">
				{$about|nl2br}
			</div>
		{/if}

		<div class="index-site-journals">
			<h2>
				{translate key="context.contexts"}
			</h2>
			{if !$journals|@count}
				{translate key="site.noJournals"}
			{else}
				<div>
					{foreach from=$journals item=journal}
						{capture assign="url"}{url journal=$journal->getPath()}{/capture}
						{assign var="thumb" value=$journal->getLocalizedSetting('journalThumbnail')}
						{assign var="description" value=$journal->getLocalizedDescription()}
						<div class="index-site-journal">
							<div class="index-site-journal-header">
								<h3>
									<a href="{$url|escape}" rel="bookmark">
										{$journal->getLocalizedName()}
									</a>
								</h3>
							</div>

							{if $thumb}
								<div class="index-site-journal-thumb">
									<a href="{$url|escape}">
										<img src="{$journalFilesPath}{$journal->getId()}/{$thumb.uploadName|escape:"url"}"{if $thumb.altText} alt="{$thumb.altText|escape|default:''}"{/if}>
									</a>
								</div>
							{/if}

							{if $description}
								<div class="index-site-journal-description{if !$thumb} full-width{/if}">
									{$description|nl2br}
								</div>
							{/if}

							<div class="index-site-journal-links">
								<a class="btn btn-primary view" href="{$url|escape}">
									{translate key="site.journalView"}
								</a>
								<a class="btn btn-secondary view" href="{url|escape journal=$journal->getPath() page="issue" op="current"}">
									{translate key="site.journalCurrent"}
								</a>
							</div>
						</div>
					{/foreach}
				</div>
			{/if}
		</div>
	</div>

</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
