#import <OCDSpec2/OCDSpec2.h>

#import "OCDSFakeFailureReporter.h"

OCDSpec2Context(ObjectExpectationSpec) {
  
  __block OCDSFakeFailureReporter *reporter;
  
  BeforeEach(^{
    reporter = [OCDSFakeFailureReporter new];
  });
  
  Describe(@"-toBeEqual", ^{
    
    It(@"passes when two objects are equal", ^{
      [[[OCDSObjectExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withObject]
       (@"a") toBeEqualTo: @"a"];
      
      [ExpectInt(reporter.numberOfFailures) toBe:0];
    });
    
    It(@"fails when two objects are not equal", ^{
      [[[OCDSObjectExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withObject]
       (@"a") toBeEqualTo: @"b"];
      NSString *report = [reporter findFailureMessageInFile:@"file1"
                                                     onLine:2];
      
      [ExpectObj(report) toBeEqualTo:@"Want b, got a"];
    });
    
  });
  
  Describe(@"-toBe", ^{
    
    It(@"passes when two objects are the same object", ^{
      id a = [NSObject new];
      
      [[[OCDSObjectExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withObject]
       (a) toBe: a];
      
      [ExpectInt(reporter.numberOfFailures) toBe:0];
    });
    
    It(@"fails when two objects are not the same object", ^{
      id a = [NSMutableString stringWithString:@"a"];
      id b = [NSMutableString stringWithString:@"b"];
      [[[OCDSObjectExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withObject]
       (a) toBe: b];
      NSString *report = [reporter findFailureMessageInFile:@"file1"
                                                     onLine:2];
      
      [ExpectObj(report) toBeEqualTo:@"Want b, got a"];
    });
    
  });
  
  Describe(@"-toExist", ^{
    
    It(@"passes when object is not nil", ^{
      [[[OCDSObjectExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withObject]
       (@"a") toExist];
      
      [ExpectInt(reporter.numberOfFailures) toBe:0];
    });
    
    It(@"fails when object is nil", ^{
      [[[OCDSObjectExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withObject]
       (nil) toExist];
      NSString *report = [reporter findFailureMessageInFile:@"file1"
                                                     onLine:2];
      
      [ExpectObj(report) toBeEqualTo:@"Want real object, got nil"];
    });
    
  });
  
  Describe(@"-toBeNil", ^{
    
    It(@"passes when object is nil", ^{
      [[[OCDSObjectExpectation expectationInFile:"file11" line:2 failureReporter:reporter] withObject]
       (nil) toBeNil];
      
      [ExpectInt(reporter.numberOfFailures) toBe:0];
    });
    
    It(@"fails when object is not nil", ^{
      [[[OCDSObjectExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withObject]
       (@"a") toBeNil];
      NSString *report = [reporter findFailureMessageInFile:@"file1"
                                                     onLine:2];
      
      [ExpectObj(report) toBeEqualTo:@"Want nil, got a"];
    });
    
  });
  
  Describe(@"-toBeMemberOfClass", ^{
    
    It(@"passes when object is a member of the class", ^{
      [[[OCDSObjectExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withObject]
       ([NSNull null]) toBeMemberOfClass: [NSNull self]];

      [ExpectInt(reporter.numberOfFailures) toBe:0];
    });
    
    It(@"fails when object is not a member of the class", ^{
      [[[OCDSObjectExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withObject]
       (@2) toBeMemberOfClass: [NSString self]];
      NSString *report = [reporter findFailureMessageInFile:@"file1"
                                                     onLine:2];
      
      [ExpectObj(report) toBeEqualTo:@"Want NSString, got __NSCFNumber"];
    });
    
    It(@"fails when object is a member of a subclass of desired class", ^{
      [[[OCDSObjectExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withObject]
       (@"hi") toBeMemberOfClass: [NSString self]];
      NSString *report = [reporter findFailureMessageInFile:@"file1"
                                                     onLine:2];
      
      [ExpectObj(report) toBeEqualTo:@"Want NSString, got __NSCFConstantString"];
    });
    
  });
  
  Describe(@"-toBeKindOfClass", ^{
    
    It(@"passes when object's class is desired class", ^{
      [[[OCDSObjectExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withObject]
       ([NSNull null]) toBeKindOfClass: [NSNull self]];
      
      [ExpectInt(reporter.numberOfFailures) toBe:0];
    });
    
    It(@"passes when object's class is obvious subclass of desired class", ^{
      [[[OCDSObjectExpectation expectationInFile:"file12" line:23 failureReporter:reporter] withObject]
       ([NSMutableString stringWithString:@"hello"]) toBeKindOfClass: [NSString self]];
      
      [ExpectInt(reporter.numberOfFailures) toBe:0];
    });
    
    It(@"passes when object's class is less obvious subclass of desired class", ^{
      [[[OCDSObjectExpectation expectationInFile:"file11" line:22 failureReporter:reporter] withObject]
       (@"hi") toBeKindOfClass: [NSString self]];
      
      [ExpectInt(reporter.numberOfFailures) toBe:0];
    });
    
    It(@"fails when object's class does not match desired class", ^{
      [[[OCDSObjectExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withObject]
       (@2) toBeKindOfClass: [NSString self]];
      NSString *report = [reporter findFailureMessageInFile:@"file1"
                                                     onLine:2];
      
      [ExpectObj(report) toBeEqualTo:@"Want NSString, got __NSCFNumber"];
    });
    
  });
  
  Describe(@"-pending", ^{
    
    It(@"warns that the test is pending", ^{
      [[OCDSObjectExpectation expectationInFile:"file1" line:2 failureReporter:reporter] pending];
      NSString *report = [reporter findWarningMessageInFile:@"file1"
                                                     onLine:2];
      
      [ExpectObj(report) toBeEqualTo:@"Pending"];
    });
    
    It(@"warns that the test is pending with a string", ^{
      [[OCDSObjectExpectation expectationInFile:"file1" line:2 failureReporter:reporter] pendingWithString](@"todo = test me");
      NSString *report = [reporter findWarningMessageInFile:@"file1"
                                                     onLine:2];
      
      [ExpectObj(report) toBeEqualTo:@"Pending: todo = test me"];
    });
    
    It(@"stops executing when it encounters pending", ^{
      Pending();
      
      [ExpectBool(YES) toBeFalse];
    });
    
    It(@"stops executing when it encounters pending with a string", ^{
      PendingStr(@"Pending");
      
      [ExpectBool(YES) toBeFalse];
    });
    
  });
  
}
