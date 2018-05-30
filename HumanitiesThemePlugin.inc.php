<?php

/**
 * @file plugins/themes/healthSciences/HealthSciencesThemePlugin.inc.php
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2003-2018 John Willinsky
 * Copyright (c) 2018 Vitalii Bezsheiko
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class HumanitiesThemePlugin
 * @ingroup plugins_themes_humanities
 *
 * @brief Humanities theme
 */

import('lib.pkp.classes.plugins.ThemePlugin');

define('ORCID_IMAGE_URL', 'images/orcid.png');

class HumanitiesThemePlugin extends ThemePlugin
{
	public function init()
	{
		$this->addStyle('bootstrap', 'node_modules/bootstrap/dist/css/bootstrap.css');
		$this->addStyle('tagit', 'node_modules/tag-it/css/jquery.tagit.css');
		$this->addStyle('stylesheet', 'less/import.less');

		$this->addScript('jquery', 'node_modules/jquery/dist/jquery.min.js');
		$this->addScript('popper', 'node_modules/popper.js/dist/umd/popper.min.js');
		$this->addScript('bootstrap-js', 'node_modules/bootstrap/dist/js/bootstrap.min.js');
		$this->addScript('jqueryui', 'node_modules/jquery-ui-dist/jquery-ui.min.js');
		$this->addScript('tagit-js', 'js/tag-it.min.js'); // own instance of tag-it library (modified source code)
		$this->addScript('main-js', 'js/main-theme.js');

		/* Adding navigation menu as in OJS 3.1+ we can have custom */
		$this->addMenuArea(array('primary', 'user'));

		$this->addStyle(
			'roboto',
			'//fonts.googleapis.com/css?family=Ubuntu',
			array('baseUrl' => 'https://fonts.googleapis.com/css?family=Ubuntu" rel="stylesheet'));

		$this->addStyle(
			'cardo',
			'//fonts.googleapis.com/css?family=Cardo',
			array('baseUrl' => 'https://fonts.googleapis.com/css?family=Cardo" rel="stylesheet'));

		$this->addStyle(
			'montserrat',
			'//fonts.googleapis.com/css?family=Montserrat',
			array('baseUrl' => 'https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet'));

		HookRegistry::register('TemplateManager::display', array($this, 'orcidImage'));
	}

	public function getDisplayName() {
		return __('plugins.themes.humanities.name');
	}

	public function getDescription() {
		return __('plugins.themes.humanities.description');
	}

	public function orcidImage($hookName, $args) {
		$smarty = $args[0];
		$orcidImageUrl = "/" . $this->getPluginPath() . "/" . ORCID_IMAGE_URL;
		$smarty->assign("orcidImageUrl", $orcidImageUrl);
	}

}