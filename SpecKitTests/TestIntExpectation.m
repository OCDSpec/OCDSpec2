#import <SenTestingKit/SenTestingKit.h>

#import "SKContext.h"
#import "SKIntExpectation.h"
#import "SKFakeFailureReporter.h"

#import "SenTestCase+ReportingHelper.h"

@interface TestIntExpectation : SenTestCase {
  SKFakeFailureReporter *reporter;
}
@end
@implementation TestIntExpectation

- (void) setUp {
  reporter = [[SKFakeFailureReporter alloc] init];
}

- (void) tearDown {
  [reporter release];
}

- (void) testToBeFail {
  [[SKIntExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter](2) toBe: 3];
  SKHelperExpectReport(@"file11", 22, @"Want 3, got 2");
}

- (void) testToBeNegativeFail {
  [[SKIntExpectation expectationFunctionInFile:"file1" line:2 failureReporter:reporter](-1) toBe: 1];
  SKHelperExpectReport(@"file1", 2, @"Want 1, got -1");
}

- (void) testToBePass {
  SKIntExpectation *exp = [SKIntExpectation expectationFunctionInFile:"file1" line:2 failureReporter:reporter](1);
  [exp toBe: 1];
  SKHelperExpectNoReport();
}

- (void) testToBeTrueFail {
  [[SKIntExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter](NO) toBeTrue];
  SKHelperExpectReport(@"file11", 22, @"Want true, got false");
}

- (void) testToBeTruePass {
  [[SKIntExpectation expectationFunctionInFile:"file1" line:2 failureReporter:reporter](YES) toBeTrue];
  SKHelperExpectNoReport();
}

@end
