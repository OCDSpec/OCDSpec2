#import <SenTestingKit/SenTestingKit.h>

#import "SKFakeFailure.h"
#import "SKContext.h"
#import "SKArrayExpectation.h"
#import "SKFakeFailureReporter.h"

#import "SenTestCase+ReportingHelper.h"

@interface TestArrayExpectation : SenTestCase {
  SKFakeFailureReporter *reporter;
}
@end
@implementation TestArrayExpectation

- (void) setUp {
  reporter = [[SKFakeFailureReporter alloc] init];
}

- (void) tearDown {
  [reporter release];
}

- (void) testToContainPass {
  [[[SKArrayExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withArray]
   ([NSArray arrayWithObject:@"a"]) toContain: @"a"];
  SKHelperExpectNoReport();
}

- (void) testToContainFail {
  [[[SKArrayExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withArray]
   ([NSArray arrayWithObject:@"a"]) toContain: @"b"];
  
  STAssertTrue([reporter.reports count] == 3, nil);
  STAssertEqualObjects([[reporter.reports objectAtIndex:0] inFile], @"file11", nil);
  STAssertEqualObjects([[reporter.reports objectAtIndex:1] inFile], @"file11", nil);
  STAssertEqualObjects([[reporter.reports objectAtIndex:2] inFile], @"file11", nil);
  
  STAssertEquals([[reporter.reports objectAtIndex:0] atLine], 22, nil);
  STAssertEquals([[reporter.reports objectAtIndex:1] atLine], 23, nil);
  STAssertEquals([[reporter.reports objectAtIndex:2] atLine], 24, nil);
  
  STAssertEqualObjects([[reporter.reports objectAtIndex:0] report], @"Want array (", nil);
  STAssertEqualObjects([[reporter.reports objectAtIndex:1] report], @"    a", nil);
  STAssertEqualObjects([[reporter.reports objectAtIndex:2] report], @") to contain b", nil);
}

@end
