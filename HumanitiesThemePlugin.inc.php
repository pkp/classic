<?php

import('lib.pkp.classes.plugins.ThemePlugin');

class HumanitiesThemePlugin extends ThemePlugin
{
	public function init()
	{
		$this->addStyle('bootstrap', 'node_modules/bootstrap/dist/css/bootstrap.css');
		$this->addStyle('stylesheet', 'less/import.less');

		$this->addScript('jquery', 'node_modules/jquery/dist/jquery.min.js');
		$this->addScript('popper', 'node_modules/popper.js/dist/umd/popper.min.js');
		$this->addScript('bootstrap-js', 'node_modules/bootstrap/dist/js/bootstrap.min.js');
		$this->addScript('header', 'js/header.js');

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
	}

	public function getDisplayName()
	{
		return __('plugins.themes.humanities.name');
	}

	public function getDescription()
	{
		return __('plugins.themes.humanities.description');
	}
}