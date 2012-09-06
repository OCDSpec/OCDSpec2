#import <SenTestingKit/SenTestingKit.h>

#import "OCDSpec2.h"

@interface SampleBeforeAll : NSObject<SKPrelude>
@end

@implementation SampleBeforeAll

- (void) run {
}

@end

OCDSpec2Context(Sample1) {
}

OCDSpec2Context(Sample2) {
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

- (void) testGetBeforeAllRunnerClasses {
  NSArray *runnerClasses = [SKContext preludeClasses];
  
  STAssertTrue([runnerClasses count] == 1, nil);
  STAssertTrue([runnerClasses containsObject: [SampleBeforeAll self]], nil);
}

@end
