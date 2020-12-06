# Classic Theme
An official theme for [OJS 3.1.1+](https://pkp.sfu.ca/ojs/)

Current version classic v.1.1.0

This theme was developed and is maintained by the [Public Knowledge Project](https://pkp.sfu.ca/).
## Installation
The theme can be installed through **Plugin Gallery** in you Open Journal Systems website.

Manual installation:
1. Download the [latest release](https://github.com/pkp/classic/releases).
2. Upload through the admin dashboard (**Upload a New Plugin** button on the **Plugins** page) or unpack the archives content inside `plugins/themes` directory starting from OJS web root.
3. Login into the OJS admin dashboard and activate the plugin on the **Plugins** page.
4. Enable the theme in **Website Settings -> Appearence** menu.

Installation from the master branch (should be used only for development):
1. `git clone https://github.com/pkp/classic.git`.
2. Move to the theme's root folder: `cd classic`.
3. Make sure that [npm](https://www.npmjs.com/get-npm) and [Gulp](https://gulpjs.com/) are installed.
4. Resolve dependencies: `npm install`. Gulp config file is inside a theme root folder `gulpfile.js`.
5. To compile external SCSS, concatenate styles and minify: `gulp sass`. The result CSS path is `resources/app.min.css`.
6. To concatenate and minify javascript: `gulp scripts` and `gulp compress`. The result Javascript file path is `resources/app.min.js`. Run `gulp watch` to view javascript changes inside `dev_js` folder in real time.
7. Copy the plugin's folder to `plugins/themes` directory starting from the OJS installation root folder.
8. Login into the OJS admin dashboard, activate the plugin and enable the theme.

Note that the master branch can contain a code that will not be shipped to the stable release.
## Version Compatibility
* Classic theme version 1.0.0 was tested and compatible with OJS 3.1.1-2.
* Classic theme version 1.0.1 is compatible with OJS 3.1.2.
* Classic theme version 1.0.2 is compatible with OJS 3.1.2-1.
* Classic theme version 1.0.3 is compatible with OJS 3.2.0.
* Classic theme version 1.0.4 is compatible with OJS 3.2.0 and 3.2.1.
* Classic theme version 1.1.0 is compatible with OJS 3.3.0.
## Contributors
Classic theme was designed and developed by Sophy Ouch ([@sssoz](https://github.com/sssoz)), Vitalii Bezsheiko ([@Vitaliy-1](https://github.com/Vitaliy-1)), John Willinsky, and Kevin Stranack.
## Troubleshooting
For technical question regarding the theme (bugs, enhancements, etc.), please open an issue on the plugin's GitHub page. For non-technical question or you are uncertain about the question's category please visit the [PKP Forum](https://forum.pkp.sfu.ca/). Before opening and issue or posting a question on forum please make sure that it wasn't solved before.
## Settings
**Theme Colour |** This theme allows the personalisation of the theme’s main colour. The default colour is a sunflower yellow. If you wish to select your own palette (in Settings >  Website), and for best readability, we recommend selecting a tone that provides a good contrast against the black text and borders.

**Navigation Menu |** For the best user experience, we recommend limiting the number of items in your navigation menus. Research shows that users struggle to find what they are looking for in long lists.

**Logo Image |** This is the image that contains the journal title. If you do not have a logo, the theme will display your journal’s name instead. Logo images should be:
- JPG for photographs or PNG for design marks
- Of a larger width than height
- Transparent background

**Home Page Image |** This theme does not accommodate home page images.

**Home Page Additional Content |** Adding content here can often disrupt the clean design of this theme. Ask yourself if this content would be better placed in a custom page with a link from the primary navigation menu instead.

**Page Footer |** We recommend keeping the Page Footer short, limited to your journal identification details, such as journal title and mailing address, as well as any required copyright or affiliation statements.

**Issue Cover Image |** Issue cover images should be:
- JPG for photographs or PNG for illustrations without photographs
- Size: 210x315 pixels
- Of a larger height than width
- Used consistently - either give all issues an image or none

**Article Image |** Article cover images should be:
- JPG for photographs or PNG for illustrations without photographs
- Size: 210x315 pixels
- Used consistently - either give all articles an image or none

**Custom Blocks |** This theme places custom blocks in the footer. We recommend minimizing the use of custom blocks to present a cleaner, more professional look. Wherever possible, consider placing what might have gone into a custom block into a custom page, and link to it from the primary navigation menu.

**Journal Thumbnail |** Journal thumbnail images will only appear on a multi-journal OJS installation, on the list of all journals on the site. The image should be:
- JPG for photographs or PNG for illustrations without photographs
- Of a larger width than height
- 160px x 320px pixels in dimension

**Galleys |** If there isn’t any CSS file attached to the HTML galley, the default theme’s style will be used

## License
This theme is released under the GPL license.

