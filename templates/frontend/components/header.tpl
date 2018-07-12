{**
 * templates/frontend/components/header.tpl
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2003-2018 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Site-wide header; includes journal logo, user menu, and primary menu
 *
 *}

{strip}
	{assign var="showingLogo" value=true}
	{if $displayPageHeaderTitle && !$displayPageHeaderLogo && is_string($displayPageHeaderTitle)}
		{assign var="showingLogo" value=false}
	{/if}

	{if $currentContext && $multipleContexts}
		{url|assign:"homeUrl" page="index" router=$smarty.const.ROUTE_PAGE}
	{else}
		{url|assign:"homeUrl" context="index" router=$smarty.const.ROUTE_PAGE}
	{/if}
{/strip}

{capture assign="journalLogo"}
	{if $displayPageHeaderLogo && is_array($displayPageHeaderLogo)}
		<img class="journal-logo" src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}"
		     {if $displayPageHeaderLogo.altText != ''}alt="{$displayPageHeaderLogo.altText|escape}"
		     {else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if}>
	{elseif $displayPageHeaderTitle && !$displayPageHeaderLogo && is_string($displayPageHeaderTitle)}
		<div class="journal-logo-text">{$displayPageHeaderTitle}</div>
	{elseif $displayPageHeaderTitle && !$displayPageHeaderLogo && is_array($displayPageHeaderTitle)}
		<img class="journal-logo" src="{$publicFilesDir}/{$displayPageHeaderTitle.uploadName|escape:"url"}"
		     alt="{$displayPageHeaderTitle.altText|escape}">
	{else}
		<img class="journal-logo" src="{$baseUrl}/templates/images/structure/logo.png" alt="{$applicationName|escape}">
	{/if}
{/capture}

<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
{if !$pageTitleTranslated}{translate|assign:"pageTitleTranslated" key=$pageTitle}{/if}
{include file="frontend/components/headerHead.tpl"}
<body>
<header>
	<div class="header container-fluid">
		<div class="upper-header row">
			<div class="logo-wraper col-md-7">
				<a href="{$homeUrl}" class="home-link">
					{$journalLogo}
				</a>
			</div>
			<div id="user-nav-wraper" class="col-md-5">
				{* user navigation manu *}
				{load_menu name="user" id="navigationUser" ulClass="pkp_navigation_user"}
				{* language toggle block *}
				{include file="frontend/components/languageSwitcher.tpl" id="languageNav"}
			</div>
		</div>

		{capture assign="primaryMenu"}
			{load_menu name="primary" id="navigationPrimary" ulClass="pkp_navigation_primary"}
		{/capture}

		{* Show the primary menu only if it is set *}
		{if !empty(trim($primaryMenu)) || $currentContext}
			<div class="lower-header">
				<ul id="nav-small" class="nav nav-tabs">
					<li class="nav-item">
						<a id="show-modal" class="nav-link">
							<ion-icon name="menu"></ion-icon>
							<span class="ion-icon-text">{translate key="plugins.themes.classic.menu"}</span>
						</a>
					</li>
				</ul>
				{* modal div is added for menu adaptation for small screens *}
				<div id="modal-on-small" class="nav-modal hide">
					<div id="primary-nav-wraper">
		                    <span id="close-small-modal">
		                        <ion-icon name="close"></ion-icon>
		                    </span>
						{$primaryMenu}
					</div>
				</div>
			</div>
		{/if}
	</div>
</header>



