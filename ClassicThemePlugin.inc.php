<?php

/**
 * @file plugins/themes/traditional/ClassicThemePlugin.inc.php
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class ClassicThemePlugin
 * @ingroup plugins_themes_classic
 *
 * @brief Classic theme
 */

use PKP\plugins\ThemePlugin;
use PKP\submissionFile\SubmissionFile;
use PKP\core\PKPApplication;
use APP\facades\Repo;

class ClassicThemePlugin extends ThemePlugin
{

    const ORCID_IMAGE_URL = 'templates/images/orcid.png';

    public function init()
    {
        /* Additional theme options */
        // Changing theme primary color
        $this->addOption('primaryColor', 'colour', array(
            'label' => 'plugins.themes.classic.option.primaryColor.label',
            'description' => 'plugins.themes.classic.option.primaryColor.description',
            'default' => '#ffd120',
        ));

        // Option to show journal summary
        $this->addOption('journalSummary', 'radio', array(
            'label' => 'manager.setup.contextSummary',
            'options' => array(
                0 => 'plugins.themes.classic.options.journalSummary.disable',
                1 => 'plugins.themes.classic.options.journalSummary.enable'
            )
        ));

        // Add usage stats display options
        $this->addOption('displayStats', 'FieldOptions', [
            'type' => 'radio',
            'label' => __('plugins.themes.classic.option.displayStats.label'),
            'options' => [
                [
                    'value' => 'none',
                    'label' => __('plugins.themes.classic.option.displayStats.none'),
                ],
                [
                    'value' => 'bar',
                    'label' => __('plugins.themes.classic.option.displayStats.bar'),
                ],
                [
                    'value' => 'line',
                    'label' => __('plugins.themes.classic.option.displayStats.line'),
                ],
            ],
            'default' => 'none',
        ]);

        // Calculate secondary colour based on user’s primary colour choice
        $additionalLessVariables = [];
        if ($this->getOption('primaryColor') !== '#ffd120') {
            $additionalLessVariables[] = '
				@primary-colour:' . $this->getOption('primaryColor') . ';
				@secondary-colour: darken(@primary-colour, 45%);
			';
        }

        // Update contrast colour based on primary colour
        if ($this->isColourDark($this->getOption('primaryColor'))) {
            $additionalLessVariables[] = '
				@contrast-colour: #FFF;
				@secondary-colour: lighten(@primary-colour, 45%);
			';
        }

        // Importing Bootstrap's and tag-it CSS
        $this->addStyle('app_css', 'resources/app.min.css');

        // Styles for HTML galleys
        $this->addStyle('htmlGalley', 'templates/plugins/generic/htmlArticleGalley/css/default.less', array('contexts' => 'htmlGalley'));
        $this->addStyle('htmlFont', 'less/fonts.less', ['contexts' => 'htmlGalley']);

        $this->addStyle('stylesheet', 'less/import.less');
        $this->modifyStyle('stylesheet', array('addLessVariables' => join("\n", $additionalLessVariables)));

        // Importing JQuery, Popper, Bootstrap, JQuery-ui, tag-it (own instance), and custom theme's javascript
        $this->addScript('app_js', 'resources/app.min.js');

        // Load icon font Ionicons
        $this->addScript(
            'ionicons',
            $this->getRequest()->getBaseUrl() . '/plugins/themes/classic/resources/ionicons.js',
            array('baseUrl' => '')
        );

        // Adding navigation menu as in OJS 3.1+ we can have custom
        $this->addMenuArea(array('primary', 'user'));

        HookRegistry::register('TemplateManager::display', array($this, 'loadAdditionalData'));
        // Get additional issue data to the issue page
        HookRegistry::register('TemplateManager::display', array($this, 'loadIssueData'));
        // Check whether authors have additional info
        HookRegistry::register('TemplateManager::display', array($this, 'hasAuthorsInfo'));
        // Display journal summary on the homepage
        HookRegistry::register('TemplateManager::display', array($this, 'homepageJournalSummary'));
    }

    public function getDisplayName()
    {
        return __('plugins.themes.classic.name');
    }

    public function getDescription()
    {
        return __('plugins.themes.classic.description');
    }

    public function loadAdditionalData($hookName, $args)
    {
        $smarty = $args[0];

        $request = $this->getRequest();
        $context = $request->getContext();

        if (!defined('SESSION_DISABLE_INIT')) {

            // Get possible locales
            if ($context) {
                $locales = $context->getSupportedLocaleNames();
            } else {
                $locales = $request->getSite()->getSupportedLocaleNames();
            }

            $orcidImageUrl = $this->getPluginPath() . '/' . self::ORCID_IMAGE_URL;

            $smarty->assign(array(
                'languageToggleLocales' => $locales,
                'orcidImageUrl' => $orcidImageUrl,
            ));
        }
    }

    public function loadIssueData($hookName, $args)
    {
        $templateMgr = $args[0];
        $template = $args[1];

        // Return false if not an issue or journal landing page
        if ($template !== 'frontend/pages/issue.tpl' && $template !== 'frontend/pages/indexJournal.tpl') return false;

        $issue = $templateMgr->getTemplateVars('issue');

        if (empty($issue)) return false;

        $issueIdentificationString = null;

        if ($issue->getVolume() && $issue->getShowVolume()) {
            $issueIdentificationString .= __('plugins.themes.classic.volume-abbr') . " " . $issue->getVolume();
        }
        if ($issue->getNumber() && $issue->getShowNumber()) {
            if ($issue->getVolume() && $issue->getShowVolume()) $issueIdentificationString .= ", ";
            $issueIdentificationString .= __('plugins.themes.classic.number-abbr') . " " . $issue->getNumber();
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

    public function hasAuthorsInfo($hookName, $args)
    {
        $templateMgr = $args[0];
        $template = $args[1];

        // Retun false if not an article page
        if ($template !== 'frontend/pages/article.tpl') return false;

        $publication = $templateMgr->getTemplateVars('publication'); /** @var $publication \APP\publication\Publication */

        // Check if there is additional info on any of authors
        $boolAuthorInfo = false;
        foreach ($publication->getData('authors') as $author) {
            if ($author->getLocalizedData('affiliation') || $author->getLocalizedData('biography')) {
                $boolAuthorInfo = true;
                break;
            }
        }

        $templateMgr->assign('boolAuthorInfo', $boolAuthorInfo);
    }

    public function homepageJournalSummary($hookName, $args)
    {
        $templateMgr = $args[0];
        $template = $args[1];

        if ($template !== "frontend/pages/indexJournal.tpl") return false;

        $templateMgr->assign(array(
            'showJournalSummary' => $this->getOption('journalSummary'),
        ));
    }

}
