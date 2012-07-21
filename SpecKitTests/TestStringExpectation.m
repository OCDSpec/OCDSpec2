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
  [[SKStringExpectation expectationFunctionInFile:"file1" line:2 failureReporter:reporter]
   (@"hello") toContain: @"hell"];
  SKHelperExpectNoReport();
}

- (void) testToContainFail {
  [[SKStringExpectation expectationFunctionInFile:"file1" line:2 failureReporter:reporter]
   (@"hello") toContain: @"jello"];
  SKHelperExpectReport(@"file1", 2, @"Want \"*jello*\", got \"hello\"");
}

@end
