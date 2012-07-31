#import <SenTestingKit/SenTestingKit.h>

#import "SKContext.h"
#import "SKBlockExpectation.h"
#import "SKFakeFailureReporter.h"

#import "SenTestCase+ReportingHelper.h"

@interface TestBlockExpectation : SenTestCase {
  SKFakeFailureReporter *reporter;
}
@end
@implementation TestBlockExpectation

- (void) setUp {
  reporter = [[SKFakeFailureReporter alloc] init];
}

- (void) tearDown {
  [reporter release];
}

- (void) testToNotRaiseExceptionPass {
  [[[SKBlockExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withBlock]
   (^{}) toNotRaiseException];
  SKHelperExpectNoReport();
}

- (void) testToNotRaiseExceptionFail {
  [[[SKBlockExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withBlock]
   (^{ [NSException raise:NSInternalInconsistencyException format:@"aww"];}) toNotRaiseException];
  SKHelperExpectReport(@"file1", 2, @"Want no exception, but got one anyway");
}

@end
