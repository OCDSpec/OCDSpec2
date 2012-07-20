## Install Xcode Templates

* Run `install_templates.sh` from inside this project's root directory
* Note: this only needs to be done once

## Use SpecKit in an Xcode Project

* Add a new 'iOS -> Application -> Empty Application' target to your project.
* Delete OTAppDelegate.h, OTAppDelegate.m, and main.m from it
* Drag and drop all the files in SpecKit/SpecKit into the new target's Supporting Files group in Xcode
  * In the ensuing dialog box, ensure 'Copy items...' is checked
  * Also check the box for the target you just created
  * But don't check the main target
  * Make sure 'Create groups...' is checked too
* Add a new 'Run Script' build phase to the spec target, running this single line:
  * `${SOURCE_ROOT}/${TARGET_NAME}/RunIPhoneUnitTest.sh`

## Adding a spec to the project

* Add a new 'SpecKit -> Spec' file to your project
* Make sure it's only in your spec target, not your main target
