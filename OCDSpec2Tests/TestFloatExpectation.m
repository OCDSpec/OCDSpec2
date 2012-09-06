#import <SenTestingKit/SenTestingKit.h>

#import "OCDSContext.h"
#import "OCDSFloatExpectation.h"
#import "OCDSFakeFailureReporter.h"

#import "SenTestCase+ReportingHelper.h"

@interface TestFloatExpectation : SenTestCase {
  OCDSFakeFailureReporter *reporter;
}
@end
@implementation TestFloatExpectation

- (void) setUp {
  reporter = [[OCDSFakeFailureReporter alloc] init];
}

- (void) tearDown {
  [reporter release];
}

- (void) testToBeWithPrecisionPass {
  [[[OCDSFloatExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withFloat]
   (1.0) toBe: 1.0 withPrecision: 0.0000001];
  OCDSHelperExpectNoReport();
}

- (void) testToBeWithPrecisionPassReallyCloseThough {
  [[[OCDSFloatExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withFloat]
   (1.99999) toBe: 2.0 withPrecision: 0.0001];
  OCDSHelperExpectNoReport();
}

- (void) testToBeWithPrecisionFail {
  [[[OCDSFloatExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withFloat]
   (1.2) toBe: 2.1234 withPrecision: 0.0000001];
  OCDSHelperExpectReport(@"file11", 22, @"Want 2.1234, got 1.2");
}

- (void) testToBeWithPrecisionFailReallyCloseThough {
  [[[OCDSFloatExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withFloat]
   (1.99999) toBe: 2.0 withPrecision: 0.0000001];
  OCDSHelperExpectReport(@"file11", 22, @"Want 2, got 1.99999");
}

@end
