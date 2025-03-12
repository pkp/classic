{**
 * plugins/blocks/languageToggle/block.tpl
 *
 * Copyright (c) 2014-2025 Simon Fraser University
 * Copyright (c) 2003-2025 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Common site sidebar menu -- language toggle.
 *}

{if $enableLanguageToggle}
	<div class="pkp_block block_language">
	<span class="title">
		{translate key="common.language"}
	</span>

		<div class="content">
			<ul>
				{foreach from=$languageToggleLocales item=localeName key=localeKey}
					<li class="locale_{$localeKey|escape}{if $localeKey == $currentLocale} current{/if}" lang="{$localeKey|replace:"_":"-"}">
						<a href="{url router=$smarty.const.ROUTE_PAGE page="user" op="setLocale" path=$localeKey}">
							{$localeName}
						</a>
					</li>
				{/foreach}
			</ul>
		</div>
	</div><!-- .block_language -->
{/if}
