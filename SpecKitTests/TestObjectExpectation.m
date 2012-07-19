#import <SenTestingKit/SenTestingKit.h>

#import "SenTestCase+ReportingHelper.h"

#import "SKContext.h"
#import "SKObjectExpectation.h"
#import "SKFakeFailureReporter.h"

@interface TestObjectExpectation : SenTestCase {
  SKFakeFailureReporter *reporter;
}
@end
@implementation TestObjectExpectation

- (void) setUp {
  reporter = [[SKFakeFailureReporter alloc] init];
}

- (void) tearDown {
  [reporter release];
}

- (void) testToBeEqualToPass {
  [[SKObjectExpectation expectationFunctionInFile:"file1" line:2 failureReporter:reporter](@"a") toBeEqualTo: @"a"];
  SKHelperExpectNoReport();
}

- (void) testToBeEqualToFail {
  [[SKObjectExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter](@"a") toBeEqualTo: @"b"];
  SKHelperExpectReport(@"file11", 22, @"Want b, got a");
}

- (void) testToBePass {
  id a = [[[NSObject alloc] init] autorelease];
  
  [[SKObjectExpectation expectationFunctionInFile:"file1" line:2 failureReporter:reporter](a) toBe: a];
  SKHelperExpectNoReport();
}

- (void) testToBeFail {
  id a = [NSMutableString stringWithString:@"a"];
  id b = [NSMutableString stringWithString:@"b"];
  
  [[SKObjectExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter](a) toBe: b];
  SKHelperExpectReport(@"file11", 22, @"Want b, got a");
}

- (void) testToExistPass {
  [[SKObjectExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter](@"a") toExist];
  SKHelperExpectNoReport();
}

- (void) testToExistFail {
  [[SKObjectExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter](nil) toExist];
  SKHelperExpectReport(@"file11", 22, @"Want nil, but isn't");
}

- (void) testToBeNilPass {
  [[SKObjectExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter](nil) toBeNil];
  SKHelperExpectNoReport();
}

- (void) testToBeNilFail {
  [[SKObjectExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter](@"a") toBeNil];
  SKHelperExpectReport(@"file11", 22, @"Want nil, got a");
}

@end
