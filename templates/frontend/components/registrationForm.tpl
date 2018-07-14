{**
 * templates/frontend/components/registrationForm.tpl
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2003-2018 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the basic registration form fields
 *
 * @uses $locale string Locale key to use in the affiliate field
 * @uses $firstName string First name input entry if available
 * @uses $middleName string Middle name input entry if available
 * @uses $lastName string Last name input entry if available
 * @uses $countries array List of country options
 * @uses $country string The selected country if available
 * @uses $email string Email input entry if available
 * @uses $username string Username input entry if available
 *}

<fieldset class="identity">
	<legend class="register-form-legend">
		{translate key="user.profile"}
	</legend>
	<div class="fields">

		<div class="form-row">
			<div class="form-group col-sm-12">
				<label for="firstName" class="sr-only">
					{translate key="user.firstName"}
				</label>
				<input type="text"  class="form-control" name="firstName" id="firstName" value="{$firstName|escape}" maxlength="40" placeholder="{translate key="user.firstName"}" required>
				<small class="form-text text-muted"><span class="required">*</span>{translate key="common.required"}</small>
			</div>
			<div class="form-group middle-name col-sm-12">
				<label for="middleName" class="sr-only">
					{translate key="user.middleName"}
				</label>
				<input type="text" class="form-control" name="middleName" id="middleName" value="{$middleName|escape}" maxlength="40" placeholder="{translate key="user.middleName"}">
			</div>
			<div class="form-group col-sm-12">
				<label for="lastName" class="sr-only">
					{translate key="user.lastName"}
				</label>
				<input type="text" class="form-control" name="lastName" id="lastName" value="{$lastName|escape}" maxlength="40" placeholder="{translate key="user.lastName"}" required>
				<small class="form-text text-muted"><span class="required">*</span>{translate key="common.required"}</small>
			</div>
		</div>

		<div class="form-row">
			<div class="form-group col-sm-8">
				<label for="affiliation" class="sr-only">
					{translate key="user.affiliation"}
				</label>
				<input type="text" class="form-control" name="affiliation[{$primaryLocale|escape}]" id="affiliation" value="{$affiliation.$primaryLocale|escape}" placeholder="{translate key="user.affiliation"}" required>
				<small class="form-text text-muted"><span class="required">*</span>{translate key="common.required"}</small>
			</div>
			<div class="form-group col-sm-4">
				<label for="country" class="sr-only">
					{translate key="common.country"}
				</label>
				<select class="form-control" name="country" id="country" required>
					<option class="choose-country">{translate key="common.country"}</option>
					{html_options options=$countries selected=$country}
				</select>
				<small class="form-text text-muted"><span class="required">*</span>{translate key="common.required"}</small>
			</div>
		</div>

	</div>
</fieldset>

<fieldset class="login-data">
	<legend class="register-form-legend">
		{translate key="user.login"}
	</legend>
	<div class="fields">
		<div class="form-row">
			<div class="form-group col-sm-12">
				<label for="email" class="sr-only">
					{translate key="user.email"}
				</label>
				<input type="text" class="form-control" name="email" id="email" value="{$email|escape}" maxlength="90" placeholder="{translate key="user.email"}" required>
				<small class="form-text text-muted"><span class="required">*</span>{translate key="common.required"}</small>
			</div>
			<div class="form-group col-sm-12">
				<label for="username" class="sr-only">
					{translate key="user.username"}
				</label>
				<input type="text" class="form-control" name="username" id="username" value="{$username|escape}" maxlength="32" placeholder="{translate key="user.username"}" required>
				<small class="form-text text-muted"><span class="required">*</span>{translate key="common.required"}</small>
			</div>
		</div>
		<div class="form-row">
			<div class="form-group col-sm-6">
				<label for="password" class="sr-only">
					{translate key="user.password"}
				</label>
				<input type="password" class="form-control" name="password" id="password" password="true" maxlength="32" placeholder="{translate key="user.password"}" required>
				<small class="form-text text-muted"><span class="required">*</span>{translate key="common.required"}</small>
			</div>
			<div class="form-group col-sm-6">
				<label for="password2" class="sr-only">
					{translate key="user.repeatPassword"}
				</label>
				<input type="password" class="form-control" name="password2" id="password2" password="true" maxlength="32" placeholder="{translate key="user.repeatPassword"}" required>
				<small class="form-text text-muted"><span class="required">*</span>{translate key="common.required"}</small>
			</div>
		</div>
	</div>
</fieldset>
