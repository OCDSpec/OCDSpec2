## Install Xcode Templates

* Run `install_templates.sh` from inside this project's root directory
* Note: this only needs to be done once

## Use SpecKit in an Xcode Project

* Add a new 'iOS -> Application -> Empty Application' target to your project.
* Delete `OTAppDelegate.h`, `OTAppDelegate.m`, and `main.m` from it
* Drag and drop all the files in the `SpecKit` subdirectory into the new target's Supporting Files group in Xcode
  * In the ensuing dialog box, ensure 'Copy items...' is checked
  * Also check the box for the target you just created
  * But don't check the main target
  * Make sure 'Create groups...' is checked too
* Add a new 'Run Script' build phase to the spec target, running this single line:
  * `${SOURCE_ROOT}/${TARGET_NAME}/RunIPhoneUnitTest.sh`

## Adding a spec to the project

* Add a new 'SpecKit -> Spec' file to your project
* Make sure it's only in your spec target, not your main target

## Running specs

* Choose the spec scheme
* Build (Cmd+B)

## Example spec

```objc
#import "SpecKit.h"

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
