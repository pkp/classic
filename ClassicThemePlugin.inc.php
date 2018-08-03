<?php

/**
 * @file plugins/themes/traditional/ClassicThemePlugin.inc.php
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2003-2018 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class ClassicThemePlugin
 * @ingroup plugins_themes_classic
 *
 * @brief Classic theme
 */

import('lib.pkp.classes.plugins.ThemePlugin');

define('ORCID_IMAGE_URL', 'templates/images/orcid.png');

class ClassicThemePlugin extends ThemePlugin
{
	public function init()
	{
		/* Additional theme options */
		// Changing theme primary color
		$this->addOption('primaryColor', 'colour', array(
			'label' => 'plugins.themes.classic.option.primaryColor.label',
			'description' => 'plugins.themes.classic.option.primaryColor.description',
			'default' => '#ffd120',
		));
		
		
		$additionalLessVariables = [];
		if ($this->getOption('primaryColor') !== '#ffd120') {
			$additionalLessVariables[] = '@primary-colour:' . $this->getOption('primaryColor') . ';';
		}
		
		// Importing Bootstrap's and tag-it CSS
		$this->addStyle('app_css', 'resources/app.min.css');
		
		$this->addStyle('stylesheet', 'less/import.less');
		$this->modifyStyle('stylesheet', array('addLessVariables' => join($additionalLessVariables)));
		
		// Importing JQuery, Popper, Bootstrap, JQuery-ui, tag-it (own instance), and custom theme's javascript
		$this->addScript('app_js', 'resources/app.min.js');
		
		// Load icon font Ionicons
		if (Config::getVar('general', 'enable_cdn')) {
			$url = 'https://unpkg.com/ionicons@4.2.4/dist/ionicons.js';
		} else {
			$url = $this->getRequest()->getBaseUrl() . '/plugins/themes/classic/resources/ionicons.js';
		}
		
		$this->addScript('ionicons',
			$url,
			array('baseUrl' => ''));

		// Adding navigation menu as in OJS 3.1+ we can have custom
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
		return __('plugins.themes.classic.name');
	}

	public function getDescription() {
		return __('plugins.themes.classic.description');
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

			$orcidImageUrl = $this->getPluginPath() . '/' . ORCID_IMAGE_URL;

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
		
		if (empty($issue)) return false;

		$issueIdentificationString = null;
		
		if ($issue->getVolume() && $issue->getShowVolume()) {
			$issueIdentificationString .= $templateMgr->smartyTranslate(array('key' =>'plugins.themes.classic.volume-abbr'), $templateMgr) . " " . $issue->getVolume();
		}
		if ($issue->getNumber() && $issue->getShowNumber()) {
			$issueIdentificationString .= ", " . $templateMgr->smartyTranslate(array('key' =>'plugins.themes.classic.number-abbr'), $templateMgr) . " " . $issue->getNumber();
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
