{**
 * templates/frontend/pages/userLogin.tpl
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2000-2018 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * User login form.
 *
 *}
{include file="frontend/components/header.tpl" pageTitle="user.login"}

<div class="page page_login">
	<div class="container-fluid container-page">

		{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="user.login"}

		{* A login message may be displayed if the user was redireceted to the
		   login page from another request. Examples include if login is required
		   before dowloading a file. *}
		{if $loginMessage}
			<p>
				{translate key=$loginMessage}
			</p>
		{/if}

		<form class="cmp_form login" id="login" method="post" action="{$loginUrl}">
			{csrf}

			{if $error}
				<div class="pkp_form_error">
					{translate key=$error reason=$reason}
				</div>
			{/if}

			<input type="hidden" name="source" value="{$source|strip_unsafe_html|escape}" />

			<fieldset class="fields">

				<div class="form-row">
					<div class="form-group col-sm-6">
						<input type="text" class="form-control" name="username" id="username" value="{$username|escape}" maxlength="32" placeholder="{translate key="user.username"}" required>
						<small class="form-text text-muted"><span class="required">*</span>{translate key="common.required"}</small>
					</div>
					<div class="form-group col-sm-6">
						<input type="password" class="form-control" name="password" id="password" value="{$password|escape}" password="true" maxlength="32" placeholder="{translate key="user.password"}" required>
						<small class="form-text text-muted"><span class="required">*</span>{translate key="common.required"}</small>
						<a href="{url page="login" op="lostPassword"}">
							{translate key="user.login.forgotPassword"}
						</a>
					</div>
					<div class="form-group form-check col-sm-12">
						<input type="checkbox" class="form-check-input" name="remember" id="remember" value="1" checked>
						<label class="form-check-label" for="remember">{translate key="user.login.rememberUsernameAndPassword"}</label>
					</div>
				</div>

				<div class="buttons">
					<button class="submit btn-primary" type="submit">
						{translate key="user.login"}
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
