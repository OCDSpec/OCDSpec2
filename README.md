# OCDSpec2 1.4

A testing library for Mac or iOS projects

## One-time setup before using OCDSpec2 in any project

Inside the OCDSpec2 directory, run:

```bash
./install_templates.sh       # installs the Xcode target and file templates you will be using
./install_autocompletions.sh # installs the Xcode autocompletion files that make life so nice
```

## Use OCDSpec2 in an iOS project

* In the root dir of your project, run:
    * `git submodule add https://github.com/ericmeyer/OCDSpec2.git`
* Add a new target to your project of type 'OCDSpec2 -> iOS Spec Runner'. This is your spec target.
    * Drag the OCDSpec2 project file, found in the submodule you just cloned, into your project in Xcode.
    * Drag the OCDSpec2 subproject's Product `libOCDSpec2.a` into your spec target's "Link Binary With Libraries" build phase.
* Note: you can choose "Manage Schemes..." from the scheme dropdown and from there toggle the OCDSpec2 scheme to not be shown

## Use OCDSpec2 in a Mac project

* In the root dir of your project, run:
    * `git submodule add https://github.com/ericmeyer/OCDSpec2.git`
* Add a new target to your project of type 'OCDSpec2 -> Mac Spec Runner'. This is your spec target.
    * Drag the OCDSpec2 project file, found in the submodule you just cloned, into your project in Xcode.
    * Drag the OCDSpec2 subproject's Product `libOCDSpec2Mac.a` into your spec target's "Link Binary With Libraries" build phase.
* Note: you can choose "Manage Schemes..." from the scheme dropdown and from there toggle the OCDSpec2 scheme to not be shown

## Adding a spec to the project

* Add a new 'OCDSpec2 -> Spec' file to your project
* Make sure it's only in your spec target, not your main target

## Running specs

* Choose the spec scheme
* Build (Cmd+B)

## Features

* Describe and example blocks
    * Describe blocks can be nested
    * Any describe block can have a before-each and after-each block
    * A context created with OCDSpec2Context is a top-level describe block
* Xcode integration
    * Auto-completion, just type "Desc", "It", "ExpectObj", "ExpectInt", etc.
    * Templates for easy creation of testing targets and spec files
    * Highlights any lines with failed expectations
* Catches exceptions
    * This means it's probably compatible with OCMock now
* Pending

## Example spec

```objc
#import <OCDSpec2/OCDSpec2.h>

#import "Widget.h"

OCDSpec2Context(WidgetSpec) {

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

To run some code once just before the entire test suite, create a class that conforms to the OCDSPrelude protocol, which just requires a `-(void)run` method. Here's an example:

```objc
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#import <OCDSpec2/OCDSpec2.h>

NSString* StubbedNibName(void) {
  return nil;
}

@interface ViewPrelude : NSObject<OCDSPrelude>
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

* Update the OCDSpec2 submodule in your project
    * `cd OCDSpec2` from your main project directory
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

* Add ExpectUInt and ExpectUFloat matchers
    * Maybe rename ExpectInt and ExpectFloat to ExpectSInt and ExpectSFloat
        * Or not, cuz that's way ugly
* Start versioning OCDSpec2 properly
    * Figure out how to version a library first
* Tell people about OCDSpec2
    * Or maybe not?
        * Secret lib! Yeah, this sounds exciting! Some James Bond stuff goin on here.

## Working on OCDSpec2 itself

* Building the OCDSpec2 scheme will run all the unit and acceptance tests
* Make sure you test everything you add
* Make your tests better than my tests

## Credits

* Inspired by Eric Smith's [OCDSpec](https://github.com/paytonrules/OCDSpec).

## Caveats

* OCDSpec2 is only known to work with Xcode 4.3.3 for now.

## License

Copyright (c) 2012 Eric Meyer

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
