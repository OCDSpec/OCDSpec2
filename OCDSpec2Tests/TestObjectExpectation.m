#import <SenTestingKit/SenTestingKit.h>

#import "SenTestCase+ReportingHelper.h"

#import "OCDSContext.h"
#import "OCDSObjectExpectation.h"
#import "OCDSFakeFailureReporter.h"

@interface TestObjectExpectation : SenTestCase {
  OCDSFakeFailureReporter *reporter;
}
@end
@implementation TestObjectExpectation

- (void) setUp {
  reporter = [[OCDSFakeFailureReporter alloc] init];
}

- (void) tearDown {
  [reporter release];
}

- (void) testToBeEqualToPass {
  [[[OCDSObjectExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withObject]
   (@"a") toBeEqualTo: @"a"];
  OCDSHelperExpectNoReport();
}

- (void) testToBeEqualToFail {
  [[[OCDSObjectExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withObject]
   (@"a") toBeEqualTo: @"b"];
  OCDSHelperExpectReport(@"file11", 22, @"Want b, got a");
}

- (void) testToBePass {
  id a = [[[NSObject alloc] init] autorelease];
  
  [[[OCDSObjectExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withObject]
   (a) toBe: a];
  OCDSHelperExpectNoReport();
}

- (void) testToBeFail {
  id a = [NSMutableString stringWithString:@"a"];
  id b = [NSMutableString stringWithString:@"b"];
  
  [[[OCDSObjectExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withObject]
   (a) toBe: b];
  OCDSHelperExpectReport(@"file11", 22, @"Want b, got a");
}

- (void) testToExistPass {
  [[[OCDSObjectExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withObject]
   (@"a") toExist];
  OCDSHelperExpectNoReport();
}

- (void) testToExistFail {
  [[[OCDSObjectExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withObject]
   (nil) toExist];
  OCDSHelperExpectReport(@"file11", 22, @"Want real object, got nil");
}

- (void) testToBeNilPass {
  [[[OCDSObjectExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withObject]
   (nil) toBeNil];
  OCDSHelperExpectNoReport();
}

- (void) testToBeNilFail {
  [[[OCDSObjectExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withObject]
   (@"a") toBeNil];
  OCDSHelperExpectReport(@"file11", 22, @"Want nil, got a");
}

- (void) testToBeMemberOfClassPass {
  [[[OCDSObjectExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withObject]
   ([NSNull null]) toBeMemberOfClass: [NSNull self]];
  OCDSHelperExpectNoReport();
}

- (void) testToBeMemberOfClassFail {
  [[[OCDSObjectExpectation expectationInFile:"file12" line:23 failureReporter:reporter] withObject]
   ([NSNumber numberWithInt:2]) toBeMemberOfClass: [NSString self]];
  OCDSHelperExpectReport(@"file12", 23, @"Want NSString, got __NSCFNumber");
}

- (void) testToBeMemberOfClassFailDueToSubclass {
  [[[OCDSObjectExpectation expectationInFile:"file14" line:25 failureReporter:reporter] withObject]
   (@"hi") toBeMemberOfClass: [NSString self]];
  OCDSHelperExpectReport(@"file14", 25, @"Want NSString, got __NSCFConstantString");
}

- (void) testToBeKindOfClassPass {
  [[[OCDSObjectExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withObject]
   ([NSNull null]) toBeKindOfClass: [NSNull self]];
  OCDSHelperExpectNoReport();
}

- (void) testToBeKindOfClassObviousSubclassPass {
  [[[OCDSObjectExpectation expectationInFile:"file12" line:23 failureReporter:reporter] withObject]
   ([NSMutableString stringWithString:@"hello"]) toBeKindOfClass: [NSString self]];
  OCDSHelperExpectNoReport();
}

- (void) testToBeKindOfClassLessObviousSubclassPass {
  [[[OCDSObjectExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withObject]
   (@"hi") toBeKindOfClass: [NSString self]];
  OCDSHelperExpectNoReport();
}

- (void) testToBeKindOfClassFail {
  [[[OCDSObjectExpectation expectationInFile:"file12" line:23 failureReporter:reporter] withObject]
   ([NSNumber numberWithInt:2]) toBeKindOfClass: [NSString self]];
  OCDSHelperExpectReport(@"file12", 23, @"Want NSString, got __NSCFNumber");
}

- (void) testPendingWithoutString {
  [[OCDSObjectExpectation expectationInFile:"file11" line:22 failureReporter:reporter] pending];
  OCDSHelperExpectWarning(@"file11", 22, @"Pending");
}

- (void) testPendingWithString {
  [[OCDSObjectExpectation expectationInFile:"file12" line:23 failureReporter:reporter] pendingWithString](@"todo = test me");
  OCDSHelperExpectWarning(@"file12", 23, @"Pending: todo = test me");
}

@end
