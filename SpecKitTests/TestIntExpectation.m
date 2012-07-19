#import <SenTestingKit/SenTestingKit.h>

#import "SKContext.h"
#import "SKIntExpectation.h"
#import "SKFakeFailureReporter.h"

#import "SenTestCase+ReportingHelper.h"

@interface TestIntExpectation : SenTestCase
@end
@implementation TestIntExpectation

- (void) testToBeFail {
  SKFakeFailureReporter *reporter = [[[SKFakeFailureReporter alloc] init] autorelease];
  [[SKIntExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter](2) toBe: 3];
  SKHelperExpectReport(@"file11", 22, @"Expected 3, got 2");
}

- (void) testToBeNegativeFail {
  SKFakeFailureReporter *reporter = [[[SKFakeFailureReporter alloc] init] autorelease];
  [[SKIntExpectation expectationFunctionInFile:"file1" line:2 failureReporter:reporter](-1) toBe: 1];
  SKHelperExpectReport(@"file1", 2, @"Expected 1, got -1");
}

- (void) testToBePass {
  SKFakeFailureReporter *reporter = [[[SKFakeFailureReporter alloc] init] autorelease];
  SKIntExpectation *exp = [SKIntExpectation expectationFunctionInFile:"file1" line:2 failureReporter:reporter](1);
  [exp toBe: 1];
  SKHelperExpectNoReport();
}

- (void) testToBeTrueFail {
  SKFakeFailureReporter *reporter = [[[SKFakeFailureReporter alloc] init] autorelease];
  [[SKIntExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter](NO) toBeTrue];
  SKHelperExpectReport(@"file11", 22, @"Expected true, got false");
}

- (void) testToBeTruePass {
  SKFakeFailureReporter *reporter = [[[SKFakeFailureReporter alloc] init] autorelease];
  [[SKIntExpectation expectationFunctionInFile:"file1" line:2 failureReporter:reporter](YES) toBeTrue];
  SKHelperExpectNoReport();
}

@end
