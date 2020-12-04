{**
 * templates/frontend/pages/purchaseIndividualSubscription.tpl
 *
 * Copyright (c) 2013-2019 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * User purchase individual subscription form
 *
 *}
{include file="frontend/components/header.tpl" pageTitle="user.subscriptions.purchaseIndividualSubscription"}

<div class="pkp_page_content pkp_page_purchaseIndividualSubscription">
	<div class="container-fluid container-page container-narrow">
		<form class="cmp_form purchase_subscription" method="post" id="subscriptionForm" action="{url op="payPurchaseSubscription" path="individual"|to_array:$subscriptionId}">
			{csrf}

			<fieldset>
				<div class="fields">
					<div class="subscription_type form-group row">
						<label for="typeId" class="col-sm-4 col-form-label">
							{translate key="user.subscriptions.form.typeId"}
						</label>
						<div class="col-sm-8">
							<select class="form-control" name="typeId" id="typeId">
								{foreach name=types from=$subscriptionTypes key=thisTypeId item=subscriptionType}
									<option class="choose-subscription" value="{$thisTypeId|escape}"{if $typeId == $thisTypeId} selected{/if}>{$subscriptionType|escape}</option>
								{/foreach}
							</select>
						</div>
					</div>
					<div class="subscription_membership form-group row">
						<label for="membership" class="col-sm-4 col-form-label">
							{translate key="user.subscriptions.form.membership"}
						</label>
						<div class="col-sm-8">
							<input class="form-control" type="text" name="membership" id="membership" value="{$membership|escape}">
						</div>
					</div>
				</div>
			</fieldset>

			<div class="buttons">
				<button class="submit btn btn-primary" type="submit">
					{translate key="common.save"}
				</button>
			</div>
		</form>
	</div>
</div>

{include file="frontend/components/footer.tpl"}
