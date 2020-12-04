{**
 * templates/frontend/components/navigationMenu.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Template for primary and user menus
 *
 *}

{if $navigationMenu}
	<ul id="{$id|escape}" class="{$ulClass|escape} nav nav-tabs">
		{foreach key=field item=navigationMenuItemAssignment from=$navigationMenu->menuTree}
			{if !$navigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
				{continue}
			{/if}
			{if !empty($navigationMenuItemAssignment->children)}
				{assign var=navItemType value=$navigationMenuItemAssignment->navigationMenuItem->getType()|escape}
				<li class="{$liClass|escape} nav-item dropdown">
					<a{if $navItemType === "NMI_TYPE_USER_DASHBOARD"} id="user-dashboard-link"{/if}
							class="nav-link dropdown-toggle{if !($languageToggleLocales && $languageToggleLocales|@count > 1)} locales-toogle-off{/if}"
							href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}" role="button"
							data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						{$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
					</a>
					<div class="navigation-dropdown dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
						{foreach key=childField item=childNavigationMenuItemAssignment from=$navigationMenuItemAssignment->children}
							{if $childNavigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
								<a class="{$liClass|escape} dropdown-item"
								   href="{$childNavigationMenuItemAssignment->navigationMenuItem->getUrl()}">
									{$childNavigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
								</a>
							{/if}
						{/foreach}
					</div>
				</li>
			{else}
				<li class="{$liClass|escape} nav-item">
					<a class="nav-link"
					   href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}">{$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}</a>
				</li>
			{/if}
		{/foreach}
	</ul>
{/if}
