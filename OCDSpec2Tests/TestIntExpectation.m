#import <SenTestingKit/SenTestingKit.h>

#import "OCDSContext.h"
#import "OCDSIntExpectation.h"
#import "OCDSFakeFailureReporter.h"

#import "SenTestCase+ReportingHelper.h"

@interface TestIntExpectation : SenTestCase {
  OCDSFakeFailureReporter *reporter;
}
@end
@implementation TestIntExpectation

- (void) setUp {
  reporter = [[OCDSFakeFailureReporter alloc] init];
}

- (void) tearDown {
  [reporter release];
}

- (void) testToBeFail {
  [[[OCDSIntExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withInt]
   (2) toBe: 3];
  OCDSHelperExpectReport(@"file11", 22, @"Want 3, got 2");
}

- (void) testToBeNegativeFail {
  [[[OCDSIntExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withInt]
   (-1) toBe: 1];
  OCDSHelperExpectReport(@"file1", 2, @"Want 1, got -1");
}

- (void) testToBePass {
  [[[OCDSIntExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withInt]
   (1) toBe: 1];
  OCDSHelperExpectNoReport();
}

- (void) testToBeTrueFail {
  [[[OCDSIntExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withInt]
   (NO) toBeTrue];
  OCDSHelperExpectReport(@"file11", 22, @"Want true, got false");
}

- (void) testToBeTruePass {
  [[[OCDSIntExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withInt]
   (YES) toBeTrue];
  OCDSHelperExpectNoReport();
}

- (void) testToBeFalseFail {
  [[[OCDSIntExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withInt]
   (YES) toBeFalse];
  OCDSHelperExpectReport(@"file11", 22, @"Want false, got true");
}

- (void) testToBeFalsePass {
  [[[OCDSIntExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withInt]
   (NO) toBeFalse];
  OCDSHelperExpectNoReport();
}

- (void) testToBeNotFalseFail {
  [[[OCDSIntExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withInt]
   (NO) toNotBeFalse];
  OCDSHelperExpectReport(@"file11", 22, @"Want anything but false, got false");
}

- (void) testToBeNotFalsePass {
  [[[OCDSIntExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withInt]
   (YES) toNotBeFalse];
  OCDSHelperExpectNoReport();
}

- (void) testToBeNotFalsePassAlternative {
  [[[OCDSIntExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withInt]
   (3) toNotBeFalse];
  OCDSHelperExpectNoReport();
}

- (void) testToBeNotFalsePassNegative {
  [[[OCDSIntExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withInt]
   (-3) toNotBeFalse];
  OCDSHelperExpectNoReport();
}

@end
