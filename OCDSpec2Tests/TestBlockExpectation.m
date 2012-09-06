#import <SenTestingKit/SenTestingKit.h>

#import "OCDSContext.h"
#import "OCDSBlockExpectation.h"
#import "OCDSFakeFailureReporter.h"

#import "SenTestCase+ReportingHelper.h"

@interface TestBlockExpectation : SenTestCase {
  OCDSFakeFailureReporter *reporter;
}
@end
@implementation TestBlockExpectation

- (void) setUp {
  reporter = [[OCDSFakeFailureReporter alloc] init];
}

- (void) tearDown {
  [reporter release];
}

- (void) testToNotRaiseExceptionPass {
  [[[OCDSBlockExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withBlock]
   (^{}) toNotRaiseException];
  OCDSHelperExpectNoReport();
}

- (void) testToNotRaiseExceptionFail {
  [[[OCDSBlockExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withBlock]
   (^{ [NSException raise:NSInternalInconsistencyException format:@"aww"];}) toNotRaiseException];
  OCDSHelperExpectReport(@"file1", 2, @"Want no exception, but got one anyway: NSInternalInconsistencyException: aww");
}

@end
