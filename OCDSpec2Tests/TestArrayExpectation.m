#import <SenTestingKit/SenTestingKit.h>

#import "OCDSFakeFailure.h"
#import "OCDSContext.h"
#import "OCDSArrayExpectation.h"
#import "OCDSFakeFailureReporter.h"

#import "SenTestCase+ReportingHelper.h"

@interface TestArrayExpectation : SenTestCase {
  OCDSFakeFailureReporter *reporter;
}
@end
@implementation TestArrayExpectation

- (void) setUp {
  reporter = [[OCDSFakeFailureReporter alloc] init];
}

- (void) tearDown {
  [reporter release];
}

- (void) testToContainPass {
  [[[OCDSArrayExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withArray]
   ([NSArray arrayWithObject:@"a"]) toContain: @"a"];
  OCDSHelperExpectNoReport();
}

- (void) testToContainFail {
  [[[OCDSArrayExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withArray]
   ([NSArray arrayWithObject:@"a"]) toContain: @"b"];
  
  STAssertTrue([reporter.failureReports count] == 3, nil);
  STAssertEqualObjects([[reporter.failureReports objectAtIndex:0] inFile], @"file11", nil);
  STAssertEqualObjects([[reporter.failureReports objectAtIndex:1] inFile], @"file11", nil);
  STAssertEqualObjects([[reporter.failureReports objectAtIndex:2] inFile], @"file11", nil);
  
  STAssertEquals([[reporter.failureReports objectAtIndex:0] atLine], 22, nil);
  STAssertEquals([[reporter.failureReports objectAtIndex:1] atLine], 23, nil);
  STAssertEquals([[reporter.failureReports objectAtIndex:2] atLine], 24, nil);
  
  STAssertEqualObjects([[reporter.failureReports objectAtIndex:0] report], @"Want array (", nil);
  STAssertEqualObjects([[reporter.failureReports objectAtIndex:1] report], @"    a", nil);
  STAssertEqualObjects([[reporter.failureReports objectAtIndex:2] report], @") to contain b", nil);
}

@end
