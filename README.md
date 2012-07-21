## Install Xcode Templates

* Run `install_templates.sh` from inside this project's root directory
* Note: this only needs to be done once

## Use SpecKit in an Xcode Project

* In the root dir of your project, run:
    * `git submodule add https://github.com/sdegutis/SpecKit.git SpecKit`
* Add a new 'iOS -> Application -> Empty Application' target to your project. This will be your spec target.
    * Delete `OTAppDelegate.h`, `OTAppDelegate.m`, and `main.m` from the spec target
    * Drag the file 'unitTestMain.m' into the spec target's group
        * Make sure 'Copy items...' is unchecked
        * Make sure it's only added to the spec target, not your main target
    * Drag the SpecKit Xcode project into your project
        * Drag the SpecKit subproject's Product `libSpecKit.a` into your spec target's "Link Binary With Libraries" build phase
        * In your spec target's Build Settings, find "header search paths" and in the column for your spec target, add `SpecKit`
    * Add a new 'Run Script' build phase to your spec target, running this single line:
        * `${SOURCE_ROOT}/SpecKit/RunIPhoneUnitTest.sh`

## Adding a spec to the project

* Add a new 'SpecKit -> Spec' file to your project
* Make sure it's only in your spec target, not your main target

## Running specs

* Choose the spec scheme
* Build (Cmd+B)

## Example spec

```objc
#import <SpecKit/SpecKit.h>

#import "Widget.h"

SpecKitContext(WidgetSpec) {

  __block Widget* widget;

  beforeEach(^{
    widget = [[[Widget alloc] init] autorelease];
  });

  describe(@"-gadgets", ^{

    it(@"is a non-empty array", ^{
      [expect(widget.gadgets) toExist];
      [expectInt([widget.gadgets count]) toBe: 3];
    });

    it(@"contains gadget instances", ^{
      [expect([widget.gadgets objectAtIndex:0]) toBeKindOfClass: [Gadget self]];
    });

  });

}
```

## Matchers

* `expect(id)`
  * `toBe:(id)other`
  * `toBeEqualTo:(id)other`
  * `toExist`
  * `toBeNil`
  * `toBeMemberOfClass:(Class)cls`
  * `toBeKindOfClass:(Class)cls`
* `expectInt(long long)`
  * `toBe:(long long)other`
  * `toBeTrue`
  * `toBeFalse`
  * `toNotBeFalse`
* `expectFloat(double)`
  * `toBe:(double)other withPrecision:(double)precision`

## Credits

* Inspired by Eric Smith's [OCDSpec](https://github.com/paytonrules/OCDSpec).

## Caveats

* SpecKit is only known to work with Xcode 4.3.3 for now.
