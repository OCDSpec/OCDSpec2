#import <OCDSpec2/OCDSpec2.h>

#import "OCDSFakeFailureReporter.h"

OCDSpec2Context(IntExpectationSpec) {

  __block OCDSFakeFailureReporter *reporter;
  
  BeforeEach(^{
    reporter = [OCDSFakeFailureReporter new];
  });
  
  Describe(@"-toBe", ^{
    
    It(@"passes when two ints are equal", ^{
      [[[OCDSIntExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withInt]
       (1) toBe: 1];
      
      [ExpectInt(reporter.numberOfFailures) toBe:0];
    });
    
    It(@"fails when two ints are not equal", ^{
      [[[OCDSIntExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withInt]
       (2) toBe: 3];
      NSString *report = [reporter findFailureMessageInFile:@"file1"
                                                     onLine:2];
      
      [ExpectObj(report) toBeEqualTo:@"Want 3, got 2"];
    });
    
    It(@"fails when two ints are equal but one is negative", ^{
      [[[OCDSIntExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withInt]
       (-1) toBe: 1];
      NSString *report = [reporter findFailureMessageInFile:@"file1"
                                                     onLine:2];
      
      [ExpectObj(report) toBeEqualTo:@"Want 1, got -1"];
    });
    
  });
  
  Describe(@"-toBeTrue", ^{
    
    It(@"passes when the value is true", ^{
      [[[OCDSIntExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withInt]
       (YES) toBeTrue];
      
      [ExpectInt(reporter.numberOfFailures) toBe:0];
    });
    
    It(@"fails when the value is false", ^{
      [[[OCDSIntExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withInt]
       (NO) toBeTrue];
      NSString *report = [reporter findFailureMessageInFile:@"file1"
                                                     onLine:2];
      
      [ExpectObj(report) toBeEqualTo:@"Want true, got false"];
    });
    
  });
  
  Describe(@"-toBeFalse", ^{
    
    It(@"passes when the value is false", ^{
      [[[OCDSIntExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withInt]
       (NO) toBeFalse];
      
      [ExpectInt(reporter.numberOfFailures) toBe:0];
    });
    
    It(@"fails when the value is true", ^{
      [[[OCDSIntExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withInt]
       (YES) toBeFalse];
      NSString *report = [reporter findFailureMessageInFile:@"file1"
                                                     onLine:2];
      
      [ExpectObj(report) toBeEqualTo:@"Want false, got true"];
    });
    
  });
  
  Describe(@"-toBeNotFalse", ^{
    
    It(@"passes when the value is true", ^{
      [[[OCDSIntExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withInt]
       (YES) toNotBeFalse];
      
      [ExpectInt(reporter.numberOfFailures) toBe:0];
    });
    
    It(@"passes when the value is a positive int", ^{
      [[[OCDSIntExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withInt]
       (3) toNotBeFalse];
      
      [ExpectInt(reporter.numberOfFailures) toBe:0];
    });
    
    It(@"passes when the value is a negative int", ^{
      [[[OCDSIntExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withInt]
       (-3) toNotBeFalse];
      
      [ExpectInt(reporter.numberOfFailures) toBe:0];
    });
    
    It(@"fails when the value is false", ^{
      [[[OCDSIntExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withInt]
       (NO) toNotBeFalse];
      NSString *report = [reporter findFailureMessageInFile:@"file1"
                                                   onLine:2];
    
      [ExpectObj(report) toBeEqualTo:@"Want anything but false, got false"];
    });
      
  });

  Describe(@"ExpectTrue", ^{
    
    It(@"passes on YES", ^{
      ExpectTrue(YES);
    });

  });

  Describe(@"ExpectFalse", ^{
    
    It(@"passes on NO", ^{
      ExpectFalse(NO);
    });
    
  });
  
}
