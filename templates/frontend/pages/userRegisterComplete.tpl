{**
 * templates/frontend/pages/userRegisterComplete.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief A landing page displayed to users upon successful registration
 *}

{include file="frontend/components/header.tpl"}

<main class="page page_register_complete">
	<div class="container-fluid container-page">
		{include file="frontend/components/headings.tpl" currentTitleKey=$pageTitle}
		<p class="registration-complete-instructions">
			{translate key="user.login.registrationComplete.instructions"}
		</p>
		<ul class="registration_complete_actions">
			{if array_intersect(array(ROLE_ID_MANAGER, ROLE_ID_SUB_EDITOR, ROLE_ID_ASSISTANT, ROLE_ID_REVIEWER), (array)$userRoles)}
				<li class="view_submissions">
					<i class="far fa-hand-point-right fa-lg"></i>
					<a href="{url page="submissions"}">
						{translate key="user.login.registrationComplete.manageSubmissions"}
					</a>
				</li>
			{/if}
			{if $currentContext}
				<li class="new_submission">
					<i class="far fa-hand-point-right fa-lg"></i>
					<a href="{url page="submission" op="wizard"}">
						{translate key="user.login.registrationComplete.newSubmission"}
					</a>
				</li>
			{/if}
			<li class="edit_profile">
				<i class="far fa-hand-point-right fa-lg"></i>
				<a href="{url router=$smarty.const.ROUTE_PAGE page="user" op="profile"}">
					{translate key="user.editMyProfile"}
				</a>
			</li>
			<li class="browse">
				<i class="far fa-hand-point-right fa-lg"></i>
				<a href="{url page="index"}">
					{translate key="user.login.registrationComplete.continueBrowsing"}
				</a>
			</li>
		</ul>
	</div>
</main>

{include file="frontend/components/footer.tpl"}
