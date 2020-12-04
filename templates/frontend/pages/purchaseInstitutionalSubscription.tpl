{**
 * templates/payments/userInstitutionalSubscriptionForm.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * User purchase institutional subscription form
 *
 *}
{include file="frontend/components/header.tpl" pageTitle="user.subscriptions.purchaseInstitutionalSubscription"}

<div class="pkp_page_content pkp_page_purchaseInstitutionalSubscription">
	<div class="container-fluid container-page container-narrow">
		<h1 class="page_title">
			{translate key="user.subscriptions.purchaseInstitutionalSubscription"}
		</h1>

		{assign var="formPath" value="institutional"}
		{if $subscriptionId}
			{assign var="formPath" value="institutional"|to_array:$subscriptionId}
		{/if}
		<form class="cmp_form purchase_subscription" method="post" id="subscriptionForm" action="{url op="payPurchaseSubscription" path=$formPath}">
			{csrf}

			{include file="common/formErrors.tpl"}

			<fieldset>
				<div class="fields">
					<div class="subscription_type form-group subscription-form-item row">
						<label for="typeId" class="col-sm-4 col-form-label">
							{translate key="user.subscriptions.form.typeId"}
							<span class="sr-only">
								{translate key="common.required"}
							</span>
						</label>
						<div class="col-sm-8">
							<select class="form-control" name="typeId" id="typeId" required>
								{foreach name=types from=$subscriptionTypes item=subscriptionType}
									<option class="choose-subscription" value="{$subscriptionType->getId()}"{if $typeId == $subscriptionType->getId()} selected{/if}>{$subscriptionType->getLocalizedName()|escape}</option>
								{/foreach}
							</select>
							<small class="form-text text-muted"><span class="required">*</span>{translate key="common.required"}</small>
						</div>
					</div>
					<div class="subscription_membership subscription-form-item form-group row">
						<label for="membership" class="col-sm-4 col-form-label">
							{translate key="user.subscriptions.form.membership"}
						</label>
						<div class="col-sm-8">
							<input class="form-control" type="text" name="membership" id="membership" value="{$membership|escape}" aria-describedby="subscriptionMembershipDescription">
							<small class="form-text text-muted" id="subscriptionMembershipDescription">{translate key="user.subscriptions.form.membershipInstructions"}</small>
						</div>
					</div>
					<div class="subscription_institution subscription-form-item form-group row">
						<label for="institutionName" class="col-sm-4 col-form-label">
							{translate key="user.subscriptions.form.institutionName"}
						</label>
						<div class="col-sm-8">
							<input class="form-control" type="text" name="institutionName" id="institutionName" value="{$institutionName|escape}">
						</div>
					</div>
					<div class="subscription_address subscription-form-item form-group row">
						<label for="institutionMailingAddress" class="col-sm-4 col-form-label">
							{translate key="user.subscriptions.form.institutionMailingAddress"}
						</label>
						<div class="col-sm-8">
							<textarea name="institutionMailingAddress" id="institutionMailingAddress">{$institutionMailingAddress|escape}</textarea>
						</div>
					</div>
				</div>
			</fieldset>

			<fieldset>
				<div class="fields">
					<div class="subscription_domain subscription-form-item form-group row">
						<label for="domain" class="col-sm-4 col-form-label">
							{translate key="user.subscriptions.form.domain"}
						</label>
						<div class="col-sm-8">
							<input class="form-control" type="text" name="domain" id="domain" value="{$domain|escape}" aria-describedby="subscriptionDomainDescription">
							<small class="form-text text-muted" id="subscriptionDomainDescription">{translate key="user.subscriptions.form.domainInstructions"}</small>
						</div>
					</div>
					<div class="subscription_ips subscription-form-item form-group row">
						<label for="ipRanges" class="col-sm-4 col-form-label">
							{translate key="user.subscriptions.form.ipRange"}
						</label>
						<div class="col-sm-8">
							<input class="form-control" type="text" name="ipRanges" id="ipRanges" value="{$ipRanges|escape}" aria-describedby="subscriptionIPDescription">
							<small class="form-text text-muted" id="subscriptionIPDescription">{translate key="user.subscriptions.form.ipRangeInstructions"}</small>
						</div>
					</div>
				</div>
			</fieldset>

			<div class="buttons">
				<button class="submit btn btn-primary" type="submit">
					{translate key="common.continue"}
				</button>
				<a class="cmp_button_link" href="{url page="user" op="subscriptions"}">
					{translate key="common.cancel"}
				</a>
			</div>

		</form>
	</div> {* end of container *}
</div>

{include file="frontend/components/footer.tpl"}
