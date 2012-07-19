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
  [[SKIntExpectation expectationFunctionInFile:"file1" line:2 failureReporter:reporter](1) toBe: 1];
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

- (void) testToBeFalseFail {
  [[SKIntExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter](YES) toBeFalse];
  SKHelperExpectReport(@"file11", 22, @"Want false, got true");
}

- (void) testToBeFalsePass {
  [[SKIntExpectation expectationFunctionInFile:"file1" line:2 failureReporter:reporter](NO) toBeFalse];
  SKHelperExpectNoReport();
}

- (void) testToBeNotFalseFail {
  [[SKIntExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter](NO) toNotBeFalse];
  SKHelperExpectReport(@"file11", 22, @"Want anything but false, got false");
}

- (void) testToBeNotFalsePass {
  [[SKIntExpectation expectationFunctionInFile:"file1" line:2 failureReporter:reporter](YES) toNotBeFalse];
  SKHelperExpectNoReport();
}

- (void) testToBeNotFalsePassAlternative {
  [[SKIntExpectation expectationFunctionInFile:"file1" line:2 failureReporter:reporter](3) toNotBeFalse];
  SKHelperExpectNoReport();
}

- (void) testToBeNotFalsePassNegative {
  [[SKIntExpectation expectationFunctionInFile:"file1" line:2 failureReporter:reporter](-3) toNotBeFalse];
  SKHelperExpectNoReport();
}

@end
