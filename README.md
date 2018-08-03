# Classic Theme
An official theme for [OJS 3.1.1+](https://pkp.sfu.ca/ojs/)

Current version classic v.1.0.0

This theme was developed and is maintained by the [Public Knowledge Project](https://pkp.sfu.ca/). 
## Installation
The theme can be installed through **Plugin Gallery** in you Open Journal Systems website.

Manual installation: 
1. Download the [latest release](https://github.com/Vitaliy-1/classic/releases).
2. Upload through the admin dashboard (**Upload a New Plugin** button on the **Plugins** page) or unpack the archives content inside `plugins/themes` directory starting from OJS web root.  
3. Login into the OJS admin dashboard and activate the plugin on the **Plugins** page.
4. Enable the theme in **Website Settings -> Appearence** menu.

Installation from the master branch (should be used only for development):
1. `git clone https://github.com/Vitaliy-1/classic.git`.
2. Move to the theme's root folder: `cd classic`. 
3. Make sure that [npm](https://www.npmjs.com/get-npm) and [Gulp](https://gulpjs.com/) are installed.
4. Resolve dependencies: `npm install`. Gulp config file is inside a theme root folder `gulpfile.js`.
5. To compile external SCSS, concatenate styles and minify: `gulp sass`. The result CSS path is `resources/app.min.css`.
6. To concatenate and minify javascript: `gulp scripts` and `gulp compress`. The result Javascript file path is `resources/app.min.js`. Run `gulp watch` to view javascript changes inside `dev_js` folder in real time.
7. Copy the plugin's folder to `plugins/themes` directory starting from the OJS installation root folder.
8. Login into the OJS admin dashboard, activate the plugin and enable the theme. 

Note that the master branch can contain a code that will not be shipped to the stable release.
## Version Compatibility
Classic theme version 1.0.0 was tested and compatible with OJS 3.1.1-2.
## Contributors
Classic theme was designed and developed by Sophy Ouch ([@sssoz](https://github.com/sssoz)), Vitalii Bezsheiko ([@Vitaliy-1](https://github.com/Vitaliy-1)), John Willinsky, and Kevin Stranack. 
## Troubleshooting
For technical question regarding the theme (bugs, enhancements, etc.), please open an issue on the plugin's GitHub page. For non-technical question or you are uncertain about the question's category please visit the [PKP Forum](https://forum.pkp.sfu.ca/). Before opening and issue or posting a question on forum please make sure that it wasn't solved before.  
