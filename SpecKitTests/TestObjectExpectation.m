#import <SenTestingKit/SenTestingKit.h>

#import "SKContext.h"
#import "SKObjectExpectation.h"
#import "SKFakeFailureReporter.h"

@interface TestObjectExpectation : SenTestCase
@end
@implementation TestObjectExpectation

- (void) testToBeEqualToPass {
  SKFakeFailureReporter *reporter = [[[SKFakeFailureReporter alloc] init] autorelease];
  
  SKObjectExpectation *exp = [SKObjectExpectation expectationFunctionInFile:"file1" line:2 failureReporter:reporter](@"a");
  [exp toBeEqualTo: @"a"];
  
  STAssertTrue(reporter.reportCount == 0, nil);
}

- (void) testToBeEqualToFail {
  SKFakeFailureReporter *reporter = [[[SKFakeFailureReporter alloc] init] autorelease];
  
  SKObjectExpectation *exp = [SKObjectExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter](@"a");
  [exp toBeEqualTo: @"b"];
  
  STAssertTrue(reporter.reportCount == 1, nil);
  STAssertTrue([reporter.lastReport isEqualToString: @"Expected b, got a"], nil);
  STAssertTrue([reporter.lastFile isEqualToString: @"file11"], nil);
  STAssertTrue(reporter.lastLine == 22, nil);
}

- (void) testToBePass {
  SKFakeFailureReporter *reporter = [[[SKFakeFailureReporter alloc] init] autorelease];
  
  id a = [[[NSObject alloc] init] autorelease];
  SKObjectExpectation *exp = [SKObjectExpectation expectationFunctionInFile:"file1" line:2 failureReporter:reporter](a);
  [exp toBe: a];
  
  STAssertTrue(reporter.reportCount == 0, nil);
}

- (void) testToBeFail {
  SKFakeFailureReporter *reporter = [[[SKFakeFailureReporter alloc] init] autorelease];
  
  id a = [NSMutableString stringWithString:@"a"];
  id b = [NSMutableString stringWithString:@"b"];
  
  SKObjectExpectation *exp = [SKObjectExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter](a);
  [exp toBe: b];
  
  STAssertTrue(reporter.reportCount == 1, nil);
  STAssertTrue([reporter.lastReport isEqualToString: @"Expected b, got a"], nil);
  STAssertTrue([reporter.lastFile isEqualToString: @"file11"], nil);
  STAssertTrue(reporter.lastLine == 22, nil);
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
