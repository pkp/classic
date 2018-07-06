<?php

/**
 * @file plugins/themes/traditional/TraditionalThemePlugin.inc.php
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2003-2018 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class TraditionalThemePlugin
 * @ingroup plugins_themes_traditional
 *
 * @brief Traditional theme
 */

import('lib.pkp.classes.plugins.ThemePlugin');

define('ORCID_IMAGE_URL', 'images/orcid.png');

class TraditionalThemePlugin extends ThemePlugin
{
	public function init()
	{
		/* Additional theme options */
		// Changing theme primary color
		$this->addOption('primaryColor', 'colour', array(
			'label' => 'plugins.themes.traditional.option.primaryColor.label',
			'description' => 'plugins.themes.traditional.option.primaryColor.description',
			'default' => '#ffd120',
		));
		
		
		$additionalLessVariables = [];
		if ($this->getOption('primaryColor') !== '#ffd120') {
			$additionalLessVariables[] = '@sun-yellow:' . $this->getOption('primaryColor') . ';';
		}
		
		//
		$this->addStyle('bootstrap', 'node_modules/bootstrap/dist/css/bootstrap.css');
		$this->addStyle('tagit', 'node_modules/tag-it/css/jquery.tagit.css');
		$this->addStyle('stylesheet', 'less/import.less');
		$this->modifyStyle('stylesheet', array('addLessVariables' => join($additionalLessVariables)));

		$this->addScript('jquery', 'node_modules/jquery/dist/jquery.min.js');
		$this->addScript('popper', 'node_modules/popper.js/dist/umd/popper.min.js');
		$this->addScript('bootstrap-js', 'node_modules/bootstrap/dist/js/bootstrap.min.js');
		$this->addScript('jqueryui', 'node_modules/jquery-ui-dist/jquery-ui.min.js');
		$this->addScript('tagit-js', 'js/tag-it.min.js'); // own instance of tag-it library (modified source code)
		$this->addScript('ionicons', 'node_modules/ionicons/dist/ionicons.js');
		$this->addScript('main-js', 'js/main-theme.js');

		/* Adding navigation menu as in OJS 3.1+ we can have custom */
		$this->addMenuArea(array('primary', 'user'));

		$this->addStyle(
			'fonts',
			'https://fonts.googleapis.com/css?family=Cardo:400,400i,700|Montserrat:400,400i,700,700i,900,900i',
			array('baseUrl' => ''));

		HookRegistry::register('TemplateManager::display', array($this, 'loadAdditionalData'));
		// Check if CSS embedded to the HTML galley
		HookRegistry::register('TemplateManager::display', array($this, 'hasEmbeddedCSS'));
		// Get additional issue data to the issue page
		HookRegistry::register('TemplateManager::display', array($this, 'loadIssueData'));
	}

	public function getDisplayName() {
		return __('plugins.themes.traditional.name');
	}

	public function getDescription() {
		return __('plugins.themes.traditional.description');
	}

	public function loadAdditionalData($hookName, $args) {
		$smarty = $args[0];

		$request = Application::getRequest();
		$context = $request->getContext();

		if (!defined('SESSION_DISABLE_INIT')) {

			// Get possible locales
			if ($context) {
				$locales = $context->getSupportedLocaleNames();
			} else {
				$locales = $request->getSite()->getSupportedLocaleNames();
			}

			$orcidImageUrl = "/" . $this->getPluginPath() . "/" . ORCID_IMAGE_URL;

			$smarty->assign(array(
				'languageToggleLocales' => $locales,
				'orcidImageUrl' =>  $orcidImageUrl,
			));
		}
	}

	public function hasEmbeddedCSS($hookName, $args) {
		$templateMgr = $args[0];
		$template = $args[1];
		$request = $this->getRequest();

		// Retun false if not a galley page
		if ($template !== 'plugins/plugins/generic/htmlArticleGalley/generic/htmlArticleGalley:display.tpl') return false;

		$articleArrays = $templateMgr->get_template_vars('article');

		$boolEmbeddedCss = false;

		foreach ($articleArrays->getGalleys() as $galley) {
			if ($galley->getFileType() === 'text/html') {
				$submissionFile = $galley->getFile();

				$submissionFileDao = DAORegistry::getDAO('SubmissionFileDAO');
				import('lib.pkp.classes.submission.SubmissionFile'); // Constants
				$embeddableFiles = array_merge(
					$submissionFileDao->getLatestRevisions($submissionFile->getSubmissionId(), SUBMISSION_FILE_PROOF),
					$submissionFileDao->getLatestRevisionsByAssocId(ASSOC_TYPE_SUBMISSION_FILE, $submissionFile->getFileId(), $submissionFile->getSubmissionId(), SUBMISSION_FILE_DEPENDENT)
				);

				foreach ($embeddableFiles as $embeddableFile) {
					if ($embeddableFile->getFileType() == 'text/css') {
						$boolEmbeddedCss = true;
					}
				}
			}

		}

		$templateMgr->assign(array(
			'boolEmbeddedCss' => $boolEmbeddedCss,
			'themePath' => $request->getBaseUrl() . "/" . $this->getPluginPath(),
		));
	}

	public function loadIssueData($hookName, $args) {
		$templateMgr = $args[0];
		$template = $args[1];

		// Return false if not an issue or journal landing page
		if ($template !== 'frontend/pages/issue.tpl' && $template !== 'frontend/pages/indexJournal.tpl') return false;

		$issue = $templateMgr->get_template_vars('issue');

		$issueIdentificationString = null;

		if ($issue->getVolume() && $issue->getShowVolume()) {
			$issueIdentificationString .= $templateMgr->smartyTranslate(array('key' =>'plugins.themes.traditional.volume-abbr'), $templateMgr) . " " . $issue->getVolume();
		}
		if ($issue->getNumber() && $issue->getShowNumber()) {
			$issueIdentificationString .= ", " . $templateMgr->smartyTranslate(array('key' =>'plugins.themes.traditional.number-abbr'), $templateMgr) . " " . $issue->getNumber();
		}
		if ($issue->getYear() && $issue->getShowYear()) {
			if ($issueIdentificationString !== null) {
				$issueIdentificationString .= " (" . $issue->getYear() . ")";
			} else {
				$issueIdentificationString .= $issue->getYear();
			}
		}
		if ($issue->getLocalizedTitle() && $issue->getShowTitle()) {
			if ($issueIdentificationString !== null) {
				$issueIdentificationString .= ": " . $issue->getLocalizedTitle();
			} else {
				$issueIdentificationString .= $issue->getLocalizedTitle();
			}
		}

		$templateMgr->assign('issueIdentificationString', $issueIdentificationString);
	}

}
