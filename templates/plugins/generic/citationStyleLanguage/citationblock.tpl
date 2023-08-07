{if $citation}
	<div class="item citation">
		<div class="sub_item citation_display">
			<h3>
                {translate key="submission.howToCite"}
			</h3>
			<div class="citation_format_value">
				<div id="citationOutput" role="region" aria-live="polite">
                    {$citation}
				</div>
				<div class="citation_formats dropdown">
					<button class="btn btn-primary" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-haspopup="true"
					        aria-expanded="false">
                        {translate key="submission.howToCite.citationFormats"}
					</button>
					<div class="dropdown-menu" aria-labelledby="dropdownMenuButton" id="dropdown-cit">
                        {foreach from=$citationStyles item="citationStyle"}
							<a
									class="dropdown-cite-link dropdown-item"
									aria-controls="citationOutput"
									href="{url page="citationstylelanguage" op="get" path=$citationStyle.id params=$citationArgs}"
									data-load-citation
									data-json-href="{url page="citationstylelanguage" op="get" path=$citationStyle.id params=$citationArgsJson}"
							>
                                {$citationStyle.title|escape}
							</a>
                        {/foreach}
                        {if count($citationDownloads)}
							<div class="dropdown-divider"></div>
							<h4 class="download-cite">
                                {translate key="submission.howToCite.downloadCitation"}
							</h4>
                            {foreach from=$citationDownloads item="citationDownload"}
								<a class="dropdown-item"
								   href="{url page="citationstylelanguage" op="download" path=$citationDownload.id params=$citationArgs}">
									<span class="fa fa-download"></span>
                                    {$citationDownload.title|escape}
								</a>
                            {/foreach}
                        {/if}
					</div>
				</div>
			</div>
		</div>
	</div>
{/if}