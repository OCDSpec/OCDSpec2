# SpecKit 1.0

A testing library for Mac or iOS projects

## Use SpecKit in an iOS project

* Run `install_templates.sh` from inside this project's root directory
    * This installs the Xcode target and file templates you will be using
    * Note: this only needs to be done once
* In the root dir of your project, run:
    * `git submodule add https://github.com/sdegutis/SpecKit.git`
* Add a new target to your project of type 'SpecKit -> iOS Spec Runner'. This is your spec target.
    * Drag the SpecKit project file, found in the submodule you just cloned, into your project in Xcode.
    * Drag the SpecKit subproject's Product `libSpecKit.a` into your spec target's "Link Binary With Libraries" build phase.

## Use SpecKit in a Mac project

* Run `install_templates.sh` from inside this project's root directory
    * This installs the Xcode target and file templates you will be using
    * Note: this only needs to be done once
* In the root dir of your project, run:
    * `git submodule add https://github.com/sdegutis/SpecKit.git`
* Add a new target to your project of type 'SpecKit -> Mac Spec Runner'. This is your spec target.
    * Drag the SpecKit project file, found in the submodule you just cloned, into your project in Xcode.
    * Drag the SpecKit subproject's Product `libSpecKitMac.a` into your spec target's "Link Binary With Libraries" build phase.

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
* `expectStr(NSString*)`
  * `toContain:(NSString*)substring`
  * `toStartWith:(NSString*)substring`
* `expectArray(NSArray*)`
  * `toContain:(id)obj`

## Running code before tests

To run some code once just before the entire test suite, create a class that conforms to the SKPrelude protocol, which just requires a `-(void)run` method. Here's an example:

```objc
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#import <SpecKit/SpecKit.h>

NSString* StubbedNibName(void) {
  return nil;
}

@interface ViewPrelude : NSObject<SKPrelude>
@end

@implementation ViewPrelude

- (void) run {
  method_setImplementation(class_getInstanceMethod([UIViewController self], @selector(nibName)),
                           (IMP)StubbedNibName);
}

@end
```

## Upgrading

To get the latest matchers, upgrade to the latest version:

* Update the SpecKit submodule in your project
    * `cd SpecKit` from your main project directory
    * `git checkout master`
    * `git pull`
    * Be sure to check this into git

## Change log

* 1.0
    * Did all the stuff
    * Wrote all the codes

## Credits

* Inspired by Eric Smith's [OCDSpec](https://github.com/paytonrules/OCDSpec).

## Caveats

* SpecKit is only known to work with Xcode 4.3.3 for now.
