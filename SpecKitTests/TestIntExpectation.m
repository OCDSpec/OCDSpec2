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
  [[[SKIntExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withInt]
   (2) toBe: 3];
  SKHelperExpectReport(@"file11", 22, @"Want 3, got 2");
}

- (void) testToBeNegativeFail {
  [[[SKIntExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withInt]
   (-1) toBe: 1];
  SKHelperExpectReport(@"file1", 2, @"Want 1, got -1");
}

- (void) testToBePass {
  [[[SKIntExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withInt]
   (1) toBe: 1];
  SKHelperExpectNoReport();
}

- (void) testToBeTrueFail {
  [[[SKIntExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withInt]
   (NO) toBeTrue];
  SKHelperExpectReport(@"file11", 22, @"Want true, got false");
}

- (void) testToBeTruePass {
  [[[SKIntExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withInt]
   (YES) toBeTrue];
  SKHelperExpectNoReport();
}

- (void) testToBeFalseFail {
  [[[SKIntExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withInt]
   (YES) toBeFalse];
  SKHelperExpectReport(@"file11", 22, @"Want false, got true");
}

- (void) testToBeFalsePass {
  [[[SKIntExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withInt]
   (NO) toBeFalse];
  SKHelperExpectNoReport();
}

- (void) testToBeNotFalseFail {
  [[[SKIntExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withInt]
   (NO) toNotBeFalse];
  SKHelperExpectReport(@"file11", 22, @"Want anything but false, got false");
}

- (void) testToBeNotFalsePass {
  [[[SKIntExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withInt]
   (YES) toNotBeFalse];
  SKHelperExpectNoReport();
}

- (void) testToBeNotFalsePassAlternative {
  [[[SKIntExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withInt]
   (3) toNotBeFalse];
  SKHelperExpectNoReport();
}

- (void) testToBeNotFalsePassNegative {
  [[[SKIntExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withInt]
   (-3) toNotBeFalse];
  SKHelperExpectNoReport();
}

@end
