#import <SenTestingKit/SenTestingKit.h>

#import "SpecKit.h"

int SampleBeforeAllCount;

@interface SampleBeforeAll : NSObject<SKRunBeforeAll>
@end

@implementation SampleBeforeAll

- (void) run {
  SampleBeforeAllCount++;
}

@end

SpecKitContext(Sample1) {
  describe(@"this", ^{
    it(@"is an example", ^{
      SampleBeforeAllCount *= 2;
      [expectInt(2) toBe: 3];
    });
  });
}

SpecKitContext(Sample2) {
  describe(@"another example", ^{
    it(@"is easy to write", ^{
      SampleBeforeAllCount *= 3;
      [expectInt(4) toBe: 5];
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
  STAssertTrue(errorCount == 2, nil);
  
  [[pipe fileHandleForWriting] closeFile];
  
  NSFileHandle *handle = [pipe fileHandleForReading];
  NSString *str = [[[NSString alloc] initWithData:[handle readDataToEndOfFile]
                                         encoding:NSUTF8StringEncoding] autorelease];
  
  NSString *expected1 = [NSString stringWithFormat:@"%s:%d: error: Want 5, got 4\n", __FILE__, 31];
  NSString *expected2 = [NSString stringWithFormat:@"%s:%d: error: Want 3, got 2\n", __FILE__, 22];
  
  STAssertTrue([str rangeOfString:expected1].location != NSNotFound, nil);
  STAssertTrue([str rangeOfString:expected2].location != NSNotFound, nil);
}

- (void) testGetBeforeAllRunnerClasses {
  NSArray *runnerClasses = [SKContext beforeAllRunnerClasses];
  
  STAssertTrue([runnerClasses count] == 1, nil);
  STAssertTrue([runnerClasses containsObject: [SampleBeforeAll self]], nil);
}

- (void) testRunsBeforeAllClasses {
  SampleBeforeAllCount = 0;
  
  [SKContext runAllTestsUsingOutput:nil];
  
  STAssertTrue(SampleBeforeAllCount == 6, nil);
}

@end
