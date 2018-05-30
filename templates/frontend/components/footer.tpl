{**
 * templates/frontend/components/footer.tpl
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2003-2018 John Willinsky
 * Copyright (c) 2018 Vitalii Bezsheiko
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Site-wide footer; designed to contain sidebar hook
 *
 *}

<footer class="site-footer">
	<div class="container-fluid container-footer">
		<div class="sidebar_wrapper">
			{call_hook name="Templates::Common::Sidebar"}
		</div>
		<div class="additional-footer-info">
			<div class="col-md-6">
				<p>Published in cooperation with Palgrave Macmillan</p>
			</div>
			<div class="col-md-6 pkpbrand-wrapper">
				<a href="{url page="about" op="aboutThisPublishingSystem"}">
					<img class="footer-brand-image" alt="{translate key="about.aboutThisPublishingSystem"}" src="{$baseUrl}/{$brandImage}">
				</a>
			</div>
		</div>
	</div>
</footer>

{load_script context="frontend"}

{call_hook name="Templates::Common::Footer::PageFooter"}

</body>
</html>