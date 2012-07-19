#import <SenTestingKit/SenTestingKit.h>

#import "SenTestCase+ReportingHelper.h"

#import "SKContext.h"
#import "SKObjectExpectation.h"
#import "SKFakeFailureReporter.h"

@interface TestObjectExpectation : SenTestCase
@end
@implementation TestObjectExpectation

- (void) testToBeEqualToPass {
  SKFakeFailureReporter *reporter = [[[SKFakeFailureReporter alloc] init] autorelease];
  [[SKObjectExpectation expectationFunctionInFile:"file1" line:2 failureReporter:reporter](@"a") toBeEqualTo: @"a"];
  SKHelperExpectNoReport();
}

- (void) testToBeEqualToFail {
  SKFakeFailureReporter *reporter = [[[SKFakeFailureReporter alloc] init] autorelease];
  [[SKObjectExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter](@"a") toBeEqualTo: @"b"];
  SKHelperExpectReport(@"file11", 22, @"Expected b, got a");
}

- (void) testToBePass {
  id a = [[[NSObject alloc] init] autorelease];
  
  SKFakeFailureReporter *reporter = [[[SKFakeFailureReporter alloc] init] autorelease];
  [[SKObjectExpectation expectationFunctionInFile:"file1" line:2 failureReporter:reporter](a) toBe: a];
  SKHelperExpectNoReport();
}

- (void) testToBeFail {
  id a = [NSMutableString stringWithString:@"a"];
  id b = [NSMutableString stringWithString:@"b"];
  
  SKFakeFailureReporter *reporter = [[[SKFakeFailureReporter alloc] init] autorelease];
  [[SKObjectExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter](a) toBe: b];
  SKHelperExpectReport(@"file11", 22, @"Expected b, got a");
}

- (void) testToExistPass {
  SKFakeFailureReporter *reporter = [[[SKFakeFailureReporter alloc] init] autorelease];
  [[SKObjectExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter](@"a") toExist];
  SKHelperExpectNoReport();
}

- (void) testToExistFail {
  SKFakeFailureReporter *reporter = [[[SKFakeFailureReporter alloc] init] autorelease];
  [[SKObjectExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter](nil) toExist];
  SKHelperExpectReport(@"file11", 22, @"Expected nil, but isn't");
}

- (void) testToBeNilPass {
  SKFakeFailureReporter *reporter = [[[SKFakeFailureReporter alloc] init] autorelease];
  [[SKObjectExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter](nil) toBeNil];
  SKHelperExpectNoReport();
}

- (void) testToBeNilFail {
  SKFakeFailureReporter *reporter = [[[SKFakeFailureReporter alloc] init] autorelease];
  [[SKObjectExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter](@"a") toBeNil];
  SKHelperExpectReport(@"file11", 22, @"Expected nil, got a");
}

@end
