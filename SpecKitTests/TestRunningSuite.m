#import <SenTestingKit/SenTestingKit.h>

#import "SpecKit.h"

int SampleBeforeAllCount;

@interface SampleBeforeAll : NSObject<SKPrelude>
@end

@implementation SampleBeforeAll

- (void) run {
  SampleBeforeAllCount++;
}

@end

SpecKitContext(Sample1) {
  describe(@"this", ^{
    it(@"contains erroneous examples", ^{
      SampleBeforeAllCount *= 2;
      [expectInt(2) toBe: 3];
      [expectInt(4) toBe: 5];
    });
  });
}

SpecKitContext(Sample2) {
  describe(@"another example", ^{
    it(@"contains correct examples", ^{
      SampleBeforeAllCount *= 3;
      
      [expectStr(@"good morning") toContain: @"go"];
      [expectStr(@"good morning") toStartWith: @"go"];
      
      [expectBool(YES) toBeTrue];
      [expectFloat(1.23) toBe:1.23 withPrecision:0.00001];
      [expect(@"hi") toBe: @"hi"];
      [expectArray([NSArray arrayWithObject:@"hi"]) toContain: @"hi"];
    });
  });
}

@interface TestRunningSuite : SenTestCase
@end
@implementation TestRunningSuite

- (void) testGetContextClasses {
  NSArray *contextClasses = [SKContext contextClasses];
  
  STAssertTrue([contextClasses count] == 2, nil);
  STAssertTrue([contextClasses containsObject: [SKContextSample1 self]], nil);
  STAssertTrue([contextClasses containsObject: [SKContextSample2 self]], nil);
}

- (void) testContextRunExecutesContents {
  NSPipe *pipe = [NSPipe pipe];
  
  int errorCount = [SKContext runAllTestsUsingOutput:[pipe fileHandleForWriting]];
  STAssertEquals(errorCount, 2, nil);
  STAssertTrue(errorCount == 2, nil);
  
  [[pipe fileHandleForWriting] closeFile];
  
  NSFileHandle *handle = [pipe fileHandleForReading];
  NSString *str = [[[NSString alloc] initWithData:[handle readDataToEndOfFile]
                                         encoding:NSUTF8StringEncoding] autorelease];
  
  NSString *expected1 = [NSString stringWithFormat:@"%s:%d: error: Want 5, got 4\n", __FILE__, 23];
  NSString *expected2 = [NSString stringWithFormat:@"%s:%d: error: Want 3, got 2\n", __FILE__, 22];
  
  STAssertTrue([str rangeOfString:expected1].location != NSNotFound, nil);
  STAssertTrue([str rangeOfString:expected2].location != NSNotFound, nil);
}

- (void) testGetBeforeAllRunnerClasses {
  NSArray *runnerClasses = [SKContext preludeClasses];
  
  STAssertTrue([runnerClasses count] == 1, nil);
  STAssertTrue([runnerClasses containsObject: [SampleBeforeAll self]], nil);
}

- (void) testRunsBeforeAllClasses {
  SampleBeforeAllCount = 0;
  
  [SKContext runAllTestsUsingOutput:nil];
  
  STAssertTrue(SampleBeforeAllCount == 6, nil);
}

@end
