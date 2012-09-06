#import <SenTestingKit/SenTestingKit.h>

#import "OCDSContext.h"
#import "OCDSStringExpectation.h"
#import "OCDSFakeFailureReporter.h"

#import "SenTestCase+ReportingHelper.h"

@interface TestStringExpectation : SenTestCase {
  OCDSFakeFailureReporter *reporter;
}
@end
@implementation TestStringExpectation

- (void) setUp {
  reporter = [[OCDSFakeFailureReporter alloc] init];
}

- (void) tearDown {
  [reporter release];
}

- (void) testToContainPass {
  [[[OCDSStringExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withString]
   (@"hello") toContain: @"hell"];
  OCDSHelperExpectNoReport();
}

- (void) testToContainFail {
  [[[OCDSStringExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withString]
   (@"hello") toContain: @"jello"];
  OCDSHelperExpectReport(@"file1", 2, @"Want \"*jello*\", got \"hello\"");
}

- (void) testToStartWithPass {
  [[[OCDSStringExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withString]
   (@"hello") toStartWith: @"hell"];
  OCDSHelperExpectNoReport();
}

- (void) testToStartWithFail {
  [[[OCDSStringExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withString]
   (@"hello") toStartWith: @"ell"];
  OCDSHelperExpectReport(@"file1", 2, @"Want \"ell*\", got \"hello\"");
}

@end
