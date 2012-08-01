# SpecKit 1.4

A testing library for Mac or iOS projects

## One-time setup before using SpecKit in any project

Inside the SpecKit directory, run:

```bash
install_templates.sh    # installs the Xcode target and file templates you will be using
install_codesnippets.sh # installs the Xcode code snippets (for autocompletion) that make life so nice
```

## Use SpecKit in an iOS project

* In the root dir of your project, run:
    * `git submodule add https://github.com/sdegutis/SpecKit.git`
* Add a new target to your project of type 'SpecKit -> iOS Spec Runner'. This is your spec target.
    * Drag the SpecKit project file, found in the submodule you just cloned, into your project in Xcode.
    * Drag the SpecKit subproject's Product `libSpecKit.a` into your spec target's "Link Binary With Libraries" build phase.

## Use SpecKit in a Mac project

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

## Features

* Describe and example blocks
    * Describe blocks can be nested
    * Any describe block can have a before-each and after-each block
    * A context created with SpecKitContext is a top-level describe block
* Xcode integration
    * Auto-completion, just type "Desc", "It", "ExpectObj", "ExpectInt", etc.
    * Templates for easy creation of testing targets and spec files
    * Highlights any lines with failed expectations
* Catches exceptions
    * This means it's probably compatible with OCMock now
* Pending

## Example spec

```objc
#import <SpecKit/SpecKit.h>

#import "Widget.h"

SpecKitContext(WidgetSpec) {

  __block Widget* widget;

  BeforeEach(^{
    widget = [[[Widget alloc] init] autorelease];
  });

  Describe(@"-gadgets", ^{

    It(@"is a non-empty array", ^{
      [ExpectObj(widget.gadgets) toExist];
      [ExpectInt([widget.gadgets count]) toBe: 3];
    });

    It(@"contains gadget instances", ^{
      [ExpectObj([widget.gadgets objectAtIndex:0]) toBeKindOfClass: [Gadget self]];
    });

    It(@"makes lots of money", ^{
      Pending();
    });

  });

}
```

## Assertion/expectation methods

* `ExpectObj(id)`
  * `toBe:(id)other`
  * `toBeEqualTo:(id)other`
  * `toExist`
  * `toBeNil`
  * `toBeMemberOfClass:(Class)cls`
  * `toBeKindOfClass:(Class)cls`
* `ExpectInt(long long)`
  * `toBe:(long long)other`
  * `toBeTrue`
  * `toBeFalse`
  * `toNotBeFalse`
* `ExpectFloat(double)`
  * `toBe:(double)other withPrecision:(double)precision`
* `ExpectStr(NSString*)`
  * `toContain:(NSString*)substring`
  * `toStartWith:(NSString*)substring`
* `ExpectArray(NSArray*)`
  * `toContain:(id)obj`
* `ExpectBlock(void(^)(void))`
  * `toNotRaiseException`
* `Pending()`
* `PendingStr(NSString*)`

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
    * Make sure you actually understand how git submodules work, or you will totally mess things up and get very confused

## Change log

* 1.4
    * Added Pending() and PendingStr() which produce warnings instead of errors
* 1.3
    * Added block expectations for noticing exceptions
    * Examples now catch exceptions and report them automatically
    * Changed syntax so it wouldn't clash with OCMock, but it's not backwards compatible
* 1.2
    * BeforeEach, AfterEach, and example blocks (it) are now allowed at the top level of a Context without a describe
    * Describe blocks can be nested now
    * BeforeEach and AfterEach are executed intuitively when nested (in order of depth)
* 1.1.1
    * Added boolean code snippet too
* 1.1
    * Added code snippets
* 1.0
    * Did all the stuff
    * Wrote all the codez

## To Do

* Figure out how to version a library
* Start versioning SpecKit properly
* Tell people about SpecKit
    * Or maybe not?
        * Secret lib! Yeah, this sounds exciting! Some James Bond stuff goin on here.

## Credits

* Inspired by Eric Smith's [OCDSpec](https://github.com/paytonrules/OCDSpec).

## Caveats

* SpecKit is only known to work with Xcode 4.3.3 for now.
