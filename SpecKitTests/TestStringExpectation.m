#import <SenTestingKit/SenTestingKit.h>

#import "SKContext.h"
#import "SKStringExpectation.h"
#import "SKFakeFailureReporter.h"

#import "SenTestCase+ReportingHelper.h"

@interface TestStringExpectation : SenTestCase {
  SKFakeFailureReporter *reporter;
}
@end
@implementation TestStringExpectation

- (void) setUp {
  reporter = [[SKFakeFailureReporter alloc] init];
}

- (void) tearDown {
  [reporter release];
}

- (void) testToContainPass {
  [[[SKStringExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withString]
   (@"hello") toContain: @"hell"];
  SKHelperExpectNoReport();
}

- (void) testToContainFail {
  [[[SKStringExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withString]
   (@"hello") toContain: @"jello"];
  SKHelperExpectReport(@"file1", 2, @"Want \"*jello*\", got \"hello\"");
}

- (void) testToStartWithPass {
  [[[SKStringExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withString]
   (@"hello") toStartWith: @"hell"];
  SKHelperExpectNoReport();
}

- (void) testToStartWithFail {
  [[[SKStringExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withString]
   (@"hello") toStartWith: @"ell"];
  SKHelperExpectReport(@"file1", 2, @"Want \"ell*\", got \"hello\"");
}

@end
