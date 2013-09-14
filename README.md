# OCDSpec2 1.5.1

A testing library for Mac or iOS projects, for the obsessive compulsive, like me!

## Installation

OCDSpec is now on CocoaPods! This is makes it far simpler to get started.

### Install The Project Templates (one time installation)

The simplest way to get started is to use the provided templates to create a seperate specs target. This requires a one-time install script.  Just run:

```bash
\curl https://raw.github.com/ericmeyer/OCDSpec2/master/install_templates.sh
```

This script does not require administrative permissions.  Optionally if you want autocompletion on XCode you can run:

```bash
\curl https://raw.github.com/ericmeyer/OCDSpec2/master/install_autocompletions.sh
```

### Create the spec target
OCDSpec has project templates for iOS and Mac files so you can add a target to your project using the appropriate test runner for your platform.  Finally add this to your podfile:

```ruby
target :test do
  link_with '<Your Spec Target Name>'
  
  pod 'OCDSpec2', :git => 'https://github.com/ericmeyer/OCDSpec2.git'
end
```

Now when you build your spec target it will automatically run the tests and fail the build if any tests fail. I like to make my test target a dependency of my main applications target, so my tests fail the build. 

## Adding a spec to the project

If you ran the install template script it also installs a file template to make creating new specs simple.

* Add a new 'OCDSpec2 -> Spec' file to your project.
* Make sure it's only in your spec target, not your main target.
* Any files you are going to test also need to be in your spec target.

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
    * This makes it compatible with OCMock
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

## Change log
* 1.5.1
    * CocoaPods
* 1.5
    * Fixed the exit code for the latest iOS changes
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

## Working on OCDSpec2 itself

* Building the OCDSpec2 scheme will run all the unit tests and the acceptance test
* Make sure you test everything you add
* Make your tests better than my tests

## Credits

* Inspired by Eric Smith's [OCDSpec](https://github.com/paytonrules/OCDSpec).


## License

Copyright (c) 2013 Eric Meyer

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
