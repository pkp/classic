{**
 * templates/frontend/pages/subscriptions.tpl
 *
 * Copyright (c) 2013-2019 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * About the Journal Subscriptions.
 *
 *}

{include file="frontend/components/header.tpl" pageTitle="about.subscriptions"}

<main class="page page_subscriptions">
	<div class="container-fluid container-page container_subscriptions container-narrow">
		{include file="frontend/components/headings.tpl" currentTitleKey="about.subscriptions"}
		{include file="frontend/components/subscriptionContact.tpl"}

		<a name="subscriptionTypes"></a>
		{if $individualSubscriptionTypes|@count}
			<div class="subscriptions_individual">
				<h3 class="subscriptions-heading"><span>{translate key="about.subscriptions.individual"}</span></h3>
				<p>{translate key="subscriptions.individualDescription"}</p>
				<div class="table-wrapper">
					<table class="table">
						<thead>
							<tr>
								<th>{translate key="about.subscriptionTypes.name"}</th>
								<th>{translate key="about.subscriptionTypes.format"}</th>
								<th>{translate key="about.subscriptionTypes.duration"}</th>
								<th>{translate key="about.subscriptionTypes.cost"}</th>
							</tr>
						</thead>
						<tbody>
							{foreach from=$individualSubscriptionTypes item=subscriptionType}
								<tr>
									<td>
										<div class="subscription_name">
											{$subscriptionType->getLocalizedName()|escape}
										</div>
										<div class="subscription_description">
											{$subscriptionType->getLocalizedDescription()|strip_unsafe_html}
										</div>
									</td>
									<td>{translate key=$subscriptionType->getFormatString()}</td>
									<td>{$subscriptionType->getDurationYearsMonths()|escape}</td>
									<td>{$subscriptionType->getCost()|string_format:"%.2f"}&nbsp;({$subscriptionType->getCurrencyStringShort()|escape})</td>
								</tr>
							{/foreach}
						</tbody>
					</table>
				</div>

				{if $isUserLoggedIn}
					<div class="subscriptions_individual_purchase">
						<a class="action btn btn-primary" href="{url page="user" op="purchaseSubscription" path="individual"}">
							{translate key="user.subscriptions.purchaseNewSubscription"}
						</a>
					</div>
				{/if}
			</div>
		{/if}

		{if $institutionalSubscriptionTypes|@count}
			<div class="subscriptions-institutional">
				<h3 class="subscriptions-heading"><span>{translate key="about.subscriptions.institutional"}</span></h3>
				<p>{translate key="subscriptions.institutionalDescription"}</p>
				<table class="table">
					<tr>
						<th>{translate key="about.subscriptionTypes.name"}</th>
						<th>{translate key="about.subscriptionTypes.format"}</th>
						<th>{translate key="about.subscriptionTypes.duration"}</th>
						<th>{translate key="about.subscriptionTypes.cost"}</th>
					</tr>
					{foreach from=$institutionalSubscriptionTypes item=subscriptionType}
						<tr>
							<td>
								<div class="subscription_name">
									{$subscriptionType->getLocalizedName()|escape}
								</div>
								<div class="subscription_description">
									{$subscriptionType->getLocalizedDescription()|strip_unsafe_html}
								</div>
							</td>
							<td>{translate key=$subscriptionType->getFormatString()}</td>
							<td>{$subscriptionType->getDurationYearsMonths()|escape}</td>
							<td>{$subscriptionType->getCost()|string_format:"%.2f"}&nbsp;({$subscriptionType->getCurrencyStringShort()|escape})</td>
						</tr>
					{/foreach}
				</table>
				{if $isUserLoggedIn}
					<div class="subscriptions_institutional_purchase">
						<a class="action btn btn-primary" href="{url page="user" op="purchaseSubscription" path="institutional"}">
							{translate key="user.subscriptions.purchaseNewSubscription"}
						</a>
					</div>
				{/if}
			</div>
		{/if}
	</div>
</main>

{include file="frontend/components/footer.tpl"}
