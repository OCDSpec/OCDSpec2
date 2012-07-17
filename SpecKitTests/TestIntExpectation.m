#import <SenTestingKit/SenTestingKit.h>

#import "SKContext.h"
#import "SKIntExpectation.h"
#import "SKFakeFailureReporter.h"

@interface TestIntExpectation : SenTestCase
@end
@implementation TestIntExpectation

- (void) testSimpleExpectationToBe {
  SKFakeFailureReporter *reporter = [[[SKFakeFailureReporter alloc] init] autorelease];
  
  SKIntExpectation *exp = [SKIntExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter](2);
  [exp toBe: 3];
  
  STAssertTrue(reporter.reportCount == 1, nil);
  STAssertTrue([reporter.lastReport isEqualToString: @"Expected 3, got 2"], nil);
  STAssertTrue([reporter.lastFile isEqualToString: @"file11"], nil);
  STAssertTrue(reporter.lastLine == 22, nil);
}

- (void) testAnotherSimpleExpectationToBe {
  SKFakeFailureReporter *reporter = [[[SKFakeFailureReporter alloc] init] autorelease];
  
  SKIntExpectation *exp = [SKIntExpectation expectationFunctionInFile:"file1" line:2 failureReporter:reporter](-1);
  [exp toBe: 1];
  
  STAssertTrue(reporter.reportCount == 1, nil);
  STAssertTrue([reporter.lastReport isEqualToString: @"Expected 1, got -1"], nil);
  STAssertTrue([reporter.lastFile isEqualToString: @"file1"], nil);
  STAssertTrue(reporter.lastLine == 2, nil);
}

- (void) testNonFailureReportsNothing {
  SKFakeFailureReporter *reporter = [[[SKFakeFailureReporter alloc] init] autorelease];
  
  SKIntExpectation *exp = [SKIntExpectation expectationFunctionInFile:"file1" line:2 failureReporter:reporter](1);
  [exp toBe: 1];
  
  STAssertTrue(reporter.reportCount == 0, nil);
}

@end
