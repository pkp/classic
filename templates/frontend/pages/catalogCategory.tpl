{**
 * templates/frontend/pages/catalogCategory.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view a category of the catalog.
 *
 * @uses $category Category Current category being viewed
 * @uses $publishedSubmissions array List of published submissions in this category
 * @uses $parentCategory Category Parent category if one exists
 * @uses $subcategories array List of subcategories if they exist
 * @uses $prevPage int The previous page number
 * @uses $nextPage int The next page number
 * @uses $showingStart int The number of the first item on this page
 * @uses $showingEnd int The number of the last item on this page
 * @uses $total int Count of all published submissions in this category
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$category->getLocalizedTitle()}

<main class="page page_catalog_category">
	<div class="container-fluid container-page container-narrow">
		<h1>
			{$category->getLocalizedTitle()|escape}
		</h1>

		{* Count of articles in this category *}
		<div class="article_count">
			{translate key="catalog.browseTitles" numTitles=$total}
		</div>

		{* Image and description *}
		{assign var="image" value=$category->getImage()}
		{assign var="description" value=$category->getLocalizedDescription()|strip_unsafe_html}
		<div class="about_section{if $image} has_image{/if}{if $description} has_description{/if}">
			{if $image}
				<div class="cover" href="{url router=$smarty.const.ROUTE_PAGE page="catalog" op="fullSize" type="category" id=$category->getId()}">
					<img src="{url router=$smarty.const.ROUTE_PAGE page="catalog" op="thumbnail" type="category" id=$category->getId()}" alt="null" />
				</div>
			{/if}
			<div class="catalog-category-description">
				{$description|strip_unsafe_html}
			</div>
		</div>

		{if $subcategories|@count}
		<nav class="subcategories" role="navigation">
			<h2>
				{translate key="catalog.category.subcategories"}
			</h2>
			<ul>
				{foreach from=$subcategories item=subcategory}
					<li>
						<a href="{url op="category" path=$subcategory->getPath()}">
							{$subcategory->getLocalizedTitle()|escape}
						</a>
					</li>
				{/foreach}
			</ul>
		</nav>
		{/if}

		<h2 class="title">
			{translate key="catalog.category.heading"}
		</h2>

		{* No published titles in this category *}
		{if empty($publishedSubmissions)}
			<p>{translate key="catalog.category.noItems"}</p>
		{else}
			<ul class="cmp_article_list articles">
				{foreach from=$publishedSubmissions item=article}
					<li>
						{include file="frontend/objects/article_summary.tpl" article=$article hideGalleys=true}
					</li>
				{/foreach}
			</ul>

			{* Pagination *}
			{if $prevPage > 1}
				{capture assign=prevUrl}{url router=$smarty.const.ROUTE_PAGE page="catalog" op="category" path=$category->getPath()|to_array:$prevPage}{/capture}
			{elseif $prevPage === 1}
				{capture assign=prevUrl}{url router=$smarty.const.ROUTE_PAGE page="catalog" op="category" path=$category->getPath()}{/capture}
			{/if}
			{if $nextPage}
				{capture assign=nextUrl}{url router=$smarty.const.ROUTE_PAGE page="catalog" op="category" path=$category->getPath()|to_array:$nextPage}{/capture}
			{/if}
			{include
				file="frontend/components/pagination.tpl"
				prevUrl=$prevUrl
				nextUrl=$nextUrl
				showingStart=$showingStart
				showingEnd=$showingEnd
				total=$total
			}
		{/if}
	</div>
</main><!-- .page -->

{include file="frontend/components/footer.tpl"}
