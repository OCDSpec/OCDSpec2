#import <SenTestingKit/SenTestingKit.h>

#import "SenTestCase+ReportingHelper.h"

#import "SKContext.h"
#import "SKObjectExpectation.h"
#import "SKFakeFailureReporter.h"

@interface TestObjectExpectation : SenTestCase {
  SKFakeFailureReporter *reporter;
}
@end
@implementation TestObjectExpectation

- (void) setUp {
  reporter = [[SKFakeFailureReporter alloc] init];
}

- (void) tearDown {
  [reporter release];
}

- (void) testToBeEqualToPass {
  [[[SKObjectExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withObject]
   (@"a") toBeEqualTo: @"a"];
  SKHelperExpectNoReport();
}

- (void) testToBeEqualToFail {
  [[[SKObjectExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withObject]
   (@"a") toBeEqualTo: @"b"];
  SKHelperExpectReport(@"file11", 22, @"Want b, got a");
}

- (void) testToBePass {
  id a = [[[NSObject alloc] init] autorelease];
  
  [[[SKObjectExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withObject]
   (a) toBe: a];
  SKHelperExpectNoReport();
}

- (void) testToBeFail {
  id a = [NSMutableString stringWithString:@"a"];
  id b = [NSMutableString stringWithString:@"b"];
  
  [[[SKObjectExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withObject]
   (a) toBe: b];
  SKHelperExpectReport(@"file11", 22, @"Want b, got a");
}

- (void) testToExistPass {
  [[[SKObjectExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withObject]
   (@"a") toExist];
  SKHelperExpectNoReport();
}

- (void) testToExistFail {
  [[[SKObjectExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withObject]
   (nil) toExist];
  SKHelperExpectReport(@"file11", 22, @"Want nil, but isn't");
}

- (void) testToBeNilPass {
  [[[SKObjectExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withObject]
   (nil) toBeNil];
  SKHelperExpectNoReport();
}

- (void) testToBeNilFail {
  [[[SKObjectExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withObject]
   (@"a") toBeNil];
  SKHelperExpectReport(@"file11", 22, @"Want nil, got a");
}

- (void) testToBeMemberOfClassPass {
  [[[SKObjectExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withObject]
   ([NSNull null]) toBeMemberOfClass: [NSNull self]];
  SKHelperExpectNoReport();
}

- (void) testToBeMemberOfClassFail {
  [[[SKObjectExpectation expectationInFile:"file12" line:23 failureReporter:reporter] withObject]
   ([NSNumber numberWithInt:2]) toBeMemberOfClass: [NSString self]];
  SKHelperExpectReport(@"file12", 23, @"Want NSString, got __NSCFNumber");
}

- (void) testToBeMemberOfClassFailDueToSubclass {
  [[[SKObjectExpectation expectationInFile:"file14" line:25 failureReporter:reporter] withObject]
   (@"hi") toBeMemberOfClass: [NSString self]];
  SKHelperExpectReport(@"file14", 25, @"Want NSString, got __NSCFConstantString");
}

- (void) testToBeKindOfClassPass {
  [[[SKObjectExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withObject]
   ([NSNull null]) toBeKindOfClass: [NSNull self]];
  SKHelperExpectNoReport();
}

- (void) testToBeKindOfClassObviousSubclassPass {
  [[[SKObjectExpectation expectationInFile:"file12" line:23 failureReporter:reporter] withObject]
   ([NSMutableString stringWithString:@"hello"]) toBeKindOfClass: [NSString self]];
  SKHelperExpectNoReport();
}

- (void) testToBeKindOfClassLessObviousSubclassPass {
  [[[SKObjectExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withObject]
   (@"hi") toBeKindOfClass: [NSString self]];
  SKHelperExpectNoReport();
}

- (void) testToBeKindOfClassFail {
  [[[SKObjectExpectation expectationInFile:"file12" line:23 failureReporter:reporter] withObject]
   ([NSNumber numberWithInt:2]) toBeKindOfClass: [NSString self]];
  SKHelperExpectReport(@"file12", 23, @"Want NSString, got __NSCFNumber");
}

@end
