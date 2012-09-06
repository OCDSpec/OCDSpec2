#import <SenTestingKit/SenTestingKit.h>

#import "SKContext.h"
#import "SKFloatExpectation.h"
#import "SKFakeFailureReporter.h"

#import "SenTestCase+ReportingHelper.h"

@interface TestFloatExpectation : SenTestCase {
  SKFakeFailureReporter *reporter;
}
@end
@implementation TestFloatExpectation

- (void) setUp {
  reporter = [[SKFakeFailureReporter alloc] init];
}

- (void) tearDown {
  [reporter release];
}

- (void) testToBeWithPrecisionPass {
  [[[SKFloatExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withFloat]
   (1.0) toBe: 1.0 withPrecision: 0.0000001];
  SKHelperExpectNoReport();
}

- (void) testToBeWithPrecisionPassReallyCloseThough {
  [[[SKFloatExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withFloat]
   (1.99999) toBe: 2.0 withPrecision: 0.0001];
  SKHelperExpectNoReport();
}

- (void) testToBeWithPrecisionFail {
  [[[SKFloatExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withFloat]
   (1.2) toBe: 2.1234 withPrecision: 0.0000001];
  SKHelperExpectReport(@"file11", 22, @"Want 2.1234, got 1.2");
}

- (void) testToBeWithPrecisionFailReallyCloseThough {
  [[[SKFloatExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withFloat]
   (1.99999) toBe: 2.0 withPrecision: 0.0000001];
  SKHelperExpectReport(@"file11", 22, @"Want 2, got 1.99999");
}

@end
