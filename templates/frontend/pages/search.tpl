{**
 * templates/frontend/pages/search.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to search and view search results.
 *
 * @uses $query Value of the primary search query
 * @uses $authors Value of the authors search filter
 * @uses $dateFrom Value of the date from search filter (published after).
 *  Value is a single string: YYYY-MM-DD HH:MM:SS
 * @uses $dateTo Value of the date to search filter (published before).
 *  Value is a single string: YYYY-MM-DD HH:MM:SS
 * @uses $yearStart Earliest year that can be used in from/to filters
 * @uses $yearEnd Latest year that can be used in from/to filters
 *}

{include file="frontend/components/header.tpl" pageTitle="common.search"}

<main class="page page_search">
	<section class="container-fluid container-page">

		{include file="frontend/components/headings.tpl" currentTitleKey="common.search"}

		{capture name="searchFormUrl"}{url op="search" escape=false}{/capture}
		{$smarty.capture.searchFormUrl|parse_url:$smarty.const.PHP_URL_QUERY|parse_str:$formUrlParameters}
		<div class="row">
			<form class="cmp_form col-sm-10 offset-sm-1 col-md-8 offset-md-2" method="get" action="{$smarty.capture.searchFormUrl|strtok:"?"|escape}">
				{foreach from=$formUrlParameters key=paramKey item=paramValue}
					<input type="hidden" name="{$paramKey|escape}" value="{$paramValue|escape}"/>
				{/foreach}

				{* Repeat the label text just so that screen readers have a clear
				   label/input relationship *}
				<div class="form-row">
					<div class="form-group col-sm-12">
						<label class="pkp_screen_reader" for="query">
							{translate key="search.searchFor"}
						</label>
						<input type="search" id="query" name="query" value="{$query|escape}" class="query form-control" placeholder="{translate|escape key="common.search"}">
					</div>
				</div>

				<fieldset class="search_advanced">
					<legend class="search-advanced-legend">
						{translate key="search.advancedFilters"}
					</legend>

					<div class="search-form-label">
						<span>{translate key="search.dateFrom"}</span>
					</div>
					<div id="dateFrom">
						{html_select_date prefix="dateFrom" time=$dateFrom start_year=$yearStart end_year=$yearEnd year_empty="" month_empty="" day_empty="" field_order="YMD"}
					</div>

					<div class="search-form-label">
						<span>{translate key="search.dateTo"}</span>
					</div>
					<div id="dataAfter">
						{html_select_date prefix="dateTo" time=$dateTo start_year=$yearStart end_year=$yearEnd year_empty="" month_empty="" day_empty="" field_order="YMD"}
					</div>

					<div class="filter-authors">
						<input type="text" class="form-control" for="authors" name="authors" value="{$authors|escape}" placeholder="{translate key="search.author"}">
					</div>
				</fieldset>


				<div class="submit buttons">
					<button class="submit btn btn-primary" type="submit">{translate key="common.search"}</button>
				</div>
			</form>
		</div>

		{* Search results, finally! *}
		{if !$results->wasEmpty()}

			<div class="search_results">
				{iterate from=results item=result}
					{include file="frontend/objects/article_summary.tpl" headingLevel="2" article=$result.publishedSubmission journal=$result.journal showDatePublished=true hideGalleys=true}
				{/iterate}
			</div>
		{/if}

		{* No results found *}
		{if $results->wasEmpty()}
			<div class="row">
				<div class="search-notifications col-sm-10 offset-sm-1 col-md-8 offset-md-2">
					{if $error}
						{include file="frontend/components/notification.tpl" type="error" message=$error|escape}
					{else}
						{include file="frontend/components/notification.tpl" type="notice" messageKey="search.noResults"}
					{/if}
				</div>
			</div>

		{* Results pagination *}
		{else}
			<div class="cmp_pagination">
				<div class="search-pagination-results">
					<span>{page_info iterator=$results}</span>
				</div>
				<div class="search-pagination-numbers">
					{page_links anchor="results" iterator=$results name="search" query=$query searchJournal=$searchJournal authors=$authors title=$title abstract=$abstract galleyFullText=$galleyFullText discipline=$discipline subject=$subject type=$type coverage=$coverage indexTerms=$indexTerms dateFromMonth=$dateFromMonth dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateToMonth=$dateToMonth dateToDay=$dateToDay dateToYear=$dateToYear orderBy=$orderBy orderDir=$orderDir}
				</div>
			</div>
		{/if}

	</section>
</main><!-- .page -->

{include file="frontend/components/footer.tpl"}
