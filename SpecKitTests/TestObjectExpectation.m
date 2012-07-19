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
  [[SKObjectExpectation expectationFunctionInFile:"file1" line:2 failureReporter:reporter]
   (@"a") toBeEqualTo: @"a"];
  SKHelperExpectNoReport();
}

- (void) testToBeEqualToFail {
  [[SKObjectExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter]
   (@"a") toBeEqualTo: @"b"];
  SKHelperExpectReport(@"file11", 22, @"Want b, got a");
}

- (void) testToBePass {
  id a = [[[NSObject alloc] init] autorelease];
  
  [[SKObjectExpectation expectationFunctionInFile:"file1" line:2 failureReporter:reporter]
   (a) toBe: a];
  SKHelperExpectNoReport();
}

- (void) testToBeFail {
  id a = [NSMutableString stringWithString:@"a"];
  id b = [NSMutableString stringWithString:@"b"];
  
  [[SKObjectExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter]
   (a) toBe: b];
  SKHelperExpectReport(@"file11", 22, @"Want b, got a");
}

- (void) testToExistPass {
  [[SKObjectExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter]
   (@"a") toExist];
  SKHelperExpectNoReport();
}

- (void) testToExistFail {
  [[SKObjectExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter]
   (nil) toExist];
  SKHelperExpectReport(@"file11", 22, @"Want nil, but isn't");
}

- (void) testToBeNilPass {
  [[SKObjectExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter]
   (nil) toBeNil];
  SKHelperExpectNoReport();
}

- (void) testToBeNilFail {
  [[SKObjectExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter]
   (@"a") toBeNil];
  SKHelperExpectReport(@"file11", 22, @"Want nil, got a");
}

- (void) testToBeMemberOfClassPass {
  [[SKObjectExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter]
   ([NSNull null]) toBeMemberOfClass: [NSNull self]];
  SKHelperExpectNoReport();
}

- (void) testToBeMemberOfClassFail {
  [[SKObjectExpectation expectationFunctionInFile:"file12" line:23 failureReporter:reporter]
   ([NSNumber numberWithInt:2]) toBeMemberOfClass: [NSString self]];
  SKHelperExpectReport(@"file12", 23, @"Want NSString, got __NSCFNumber");
}

- (void) testToBeMemberOfClassFailDueToSubclass {
  [[SKObjectExpectation expectationFunctionInFile:"file14" line:25 failureReporter:reporter]
   (@"hi") toBeMemberOfClass: [NSString self]];
  SKHelperExpectReport(@"file14", 25, @"Want NSString, got __NSCFConstantString");
}

- (void) testToBeKindOfClassPass {
  [[SKObjectExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter]
   ([NSNull null]) toBeKindOfClass: [NSNull self]];
  SKHelperExpectNoReport();
}

- (void) testToBeKindOfClassObviousSubclassPass {
  [[SKObjectExpectation expectationFunctionInFile:"file12" line:23 failureReporter:reporter]
   ([NSMutableString stringWithString:@"hello"]) toBeKindOfClass: [NSString self]];
  SKHelperExpectNoReport();
}

- (void) testToBeKindOfClassLessObviousSubclassPass {
  [[SKObjectExpectation expectationFunctionInFile:"file11" line:22 failureReporter:reporter]
   (@"hi") toBeKindOfClass: [NSString self]];
  SKHelperExpectNoReport();
}

- (void) testToBeKindOfClassFail {
  [[SKObjectExpectation expectationFunctionInFile:"file12" line:3 failureReporter:reporter]
   ([NSNumber numberWithInt:2]) toBeKindOfClass: [NSString self]];
  SKHelperExpectReport(@"file12", 23, @"Want NSString, got __NSCFNumber");
}

@end
