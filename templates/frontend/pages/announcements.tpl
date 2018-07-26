{**
 * templates/frontend/pages/announcements.tpl
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2003-2018 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view the latest announcements
 *
 * @uses $announcements array List of announcements
 *}

{include file="frontend/components/header.tpl" pageTitle="announcement.announcements"}

<main class="page page_announcements">
	<div class="container-fluid container-page container-narrow">
		{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="announcement.announcements"}
		{include file="frontend/components/editLink.tpl" page="management" op="settings" path="website" anchor="announcements" sectionTitleKey="announcement.announcements"}

		<div class="announcements-introduction">
			{$announcementsIntroduction}
		</div>

		{include file="frontend/components/announcements.tpl"}
	</div>
</main><!-- .page -->

{include file="frontend/components/footer.tpl"}
