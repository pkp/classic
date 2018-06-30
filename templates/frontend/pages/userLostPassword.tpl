{**
 * templates/frontend/pages/userLostPassword.tpl
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2000-2018 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Password reset form.
 *
 *}
{include file="frontend/components/header.tpl" pageTitle="user.login.resetPassword"}

<div class="page page_lost_password">
	<div class="container-fluid container-page">

		{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="user.login.resetPassword"}

		<p>{translate key="user.login.resetPasswordInstructions"}</p>

		<form class="cmp_form lost_password" id="lostPasswordForm" action="{url page="login" op="requestResetPassword"}" method="post">
			{csrf}
			{if $error}
				<div class="pkp_form_error">
					{translate key=$error}
				</div>
			{/if}


			<fieldset class="fields">

				<div class="form-row">
					<div class="form-group col-sm-12">
						<input type="text" class="form-control" name="email" id="email" value="{$email|escape}" placeholder="{translate key="user.login.registeredEmail"}" required>
						<small class="form-text text-muted"><span class="required">*</span>{translate key="common.required"}</small>
					</div>
				</div>

				<div class="buttons">
					<button class="submit btn-primary" type="submit">
						{translate key="user.login.resetPassword"}
					</button>

					{if !$disableUserReg}
						{url|assign:registerUrl page="user" op="register" source=$source}
						<a href="{$registerUrl}" class="register btn-primary">
							{translate key="user.login.registerNewAccount"}
						</a>
					{/if}
				</div>
			</fieldset>

		</form>

	</div>
</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
