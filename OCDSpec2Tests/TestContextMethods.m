#import <SenTestingKit/SenTestingKit.h>

#import "OCDSpec2.h"

@interface SampleBeforeAll : NSObject<OCDSPrelude>
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
  NSArray *contextClasses = [OCDSContext contextClasses];
  
  STAssertTrue([contextClasses count] == 2, nil);
  STAssertTrue([contextClasses containsObject: [OCDSContextSample1 self]], nil);
  STAssertTrue([contextClasses containsObject: [OCDSContextSample2 self]], nil);
}

- (void) testGetBeforeAllRunnerClasses {
  NSArray *runnerClasses = [OCDSContext preludeClasses];
  
  STAssertTrue([runnerClasses count] == 1, nil);
  STAssertTrue([runnerClasses containsObject: [SampleBeforeAll self]], nil);
}

@end
