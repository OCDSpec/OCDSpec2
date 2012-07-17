#import <SenTestingKit/SenTestingKit.h>

#import "SKContext.h"
#import "SKObjectExpectation.h"
#import "SKFakeFailureReporter.h"

@interface TestObjectExpectation : SenTestCase
@end
@implementation TestObjectExpectation

- (void) testSimpleExpectationToBe {
  SKFakeFailureReporter *reporter = [[[SKFakeFailureReporter alloc] init] autorelease];
  
  SKObjectExpectation *exp = [SKObjectExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter](@"a");
  [exp toBe: @"b"];
  
  STAssertTrue(reporter.reportCount == 1, nil);
  STAssertTrue([reporter.lastReport isEqualToString: @"Expected b, got a"], nil);
  STAssertTrue([reporter.lastFile isEqualToString: @"file11"], nil);
  STAssertTrue(reporter.lastLine == 22, nil);
}

- (void) testAnotherSimpleExpectationToBe {
  SKFakeFailureReporter *reporter = [[[SKFakeFailureReporter alloc] init] autorelease];
  
  SKObjectExpectation *exp = [SKObjectExpectation expectationFunctionInFile:"file1" line:2 failureReporter:reporter]([NSNumber numberWithInt:1]);
  [exp toBe: [NSNumber numberWithInt:2]];
  
  STAssertTrue(reporter.reportCount == 1, nil);
  STAssertTrue([reporter.lastReport isEqualToString: @"Expected 2, got 1"], nil);
  STAssertTrue([reporter.lastFile isEqualToString: @"file1"], nil);
  STAssertTrue(reporter.lastLine == 2, nil);
}

- (void) testNonFailureReportsNothing {
  SKFakeFailureReporter *reporter = [[[SKFakeFailureReporter alloc] init] autorelease];
  
  SKObjectExpectation *exp = [SKObjectExpectation expectationFunctionInFile:"file1" line:2 failureReporter:reporter](@"a");
  [exp toBe: @"a"];
  
  STAssertTrue(reporter.reportCount == 0, nil);
}

- (void) testToExistPass {
  SKFakeFailureReporter *reporter = [[[SKFakeFailureReporter alloc] init] autorelease];
  
  SKObjectExpectation *exp = [SKObjectExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter](@"a");
  [exp toExist];
  
  STAssertTrue(reporter.reportCount == 0, nil);
}

- (void) testToExistFail {
  SKFakeFailureReporter *reporter = [[[SKFakeFailureReporter alloc] init] autorelease];
  
  SKObjectExpectation *exp = [SKObjectExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter](nil);
  [exp toExist];
  
  STAssertTrue(reporter.reportCount == 1, nil);
  STAssertTrue([reporter.lastReport isEqualToString: @"Expected nil, but isn't"], nil);
  STAssertTrue([reporter.lastFile isEqualToString: @"file11"], nil);
  STAssertTrue(reporter.lastLine == 22, nil);
}

- (void) testToBeNilPass {
  SKFakeFailureReporter *reporter = [[[SKFakeFailureReporter alloc] init] autorelease];
  
  SKObjectExpectation *exp = [SKObjectExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter](nil);
  [exp toBeNil];
  
  STAssertTrue(reporter.reportCount == 0, nil);
}

- (void) testToBeNilFail {
  SKFakeFailureReporter *reporter = [[[SKFakeFailureReporter alloc] init] autorelease];
  
  SKObjectExpectation *exp = [SKObjectExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter](@"a");
  [exp toBeNil];
  
  STAssertTrue(reporter.reportCount == 1, nil);
  STAssertTrue([reporter.lastReport isEqualToString: @"Expected nil, got a"], nil);
  STAssertTrue([reporter.lastFile isEqualToString: @"file11"], nil);
  STAssertTrue(reporter.lastLine == 22, nil);
}

@end
