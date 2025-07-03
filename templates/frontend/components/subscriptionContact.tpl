{**
 * templates/frontend/components/subscriptionContact.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the contact details for a journal's subscriptions
 *
 * @uses $subscriptionAdditionalInformation string HTML text description
 *       subcription information
 * @uses $subscriptionMailingAddress string Contact address for subscriptions
 * @uses $subscriptionName string Contact name for subscriptions
 * @uses $subscriptionPhone string Contact phone number for subscriptions
 * @uses $subscriptionEmail string Contact email address for subscriptions
 *}

 <div class="cmp_subscription_contact">
	 {if $subscriptionAdditionalInformation}
		<div class="cmp_subscription-description">
			{$subscriptionAdditionalInformation|strip_unsafe_html}
		</div>
	{/if}

	{if $subscriptionName || $subscriptionPhone || $subscriptionEmail}
		<div class="contact">
			<h3 class="subscriptions-heading"><span>{translate key="about.subscriptionsContact"}</span></h3>

			{if $subscriptionName}
				<div class="name">
					{$subscriptionName|escape}
				</div>
			{/if}

			{if $subscriptionMailingAddress}
				<div class="address">
					{$subscriptionMailingAddress|nl2br|strip_unsafe_html}
				</div>
			{/if}

			{if $subscriptionPhone}
				<div class="phone">
					<span class="label">
						{translate key="about.contact.phone"}
					</span>
					<span class="value">
						{$subscriptionPhone|escape}
					</span>
				</div>
			{/if}

			{if $subscriptionEmail}
				<div class="email">
					<a href="mailto:{$subscriptionEmail|escape}">
						{$subscriptionEmail|escape}
					</a>
				</div>
			{/if}
		</div>
	{/if}
 </div>
