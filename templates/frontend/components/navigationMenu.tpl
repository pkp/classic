{**
 * templates/frontend/components/header.tpl
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2003-2018 John Willinsky
 * Copyright (c) 2018 Vitalii Bezsheiko
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Site-wide header; includes journal logo, user menu, and primary menu
 *
 *}


{if $navigationMenu}
    <ul id="{$id|escape}" class="{$ulClass|escape} nav nav-tabs">
        {foreach key=field item=navigationMenuItemAssignment from=$navigationMenu->menuTree}
            {if !$navigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
                {php}continue;{/php}
            {/if}
            {if !empty($navigationMenuItemAssignment->children)}
                <li class="{$liClass|escape} nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        {$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
                    </a>
                    <div class="navigation-dropdown dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
                        {foreach key=childField item=childNavigationMenuItemAssignment from=$navigationMenuItemAssignment->children}
                            {if $childNavigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
                                <a class="{$liClass|escape} dropdown-item" href="{$childNavigationMenuItemAssignment->navigationMenuItem->getUrl()}">
                                    {$childNavigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
                                </a>
                            {/if}
                        {/foreach}
                    </div>
                </li>
            {else}
                <li class="{$liClass|escape} nav-item">
                    <a class="nav-link" href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}">{$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}</a>
                </li>
            {/if}
        {/foreach}
    </ul>
{/if}