{**
 * templates/content.tpl
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2003-2018 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display Static Page content
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$title}

<main class="page static_page">
	<div class="container-fluid container-page container-narrow">
		<h2>{$title|escape}</h2>
		{$content}
	</div>
</main>

{include file="frontend/components/footer.tpl"}
