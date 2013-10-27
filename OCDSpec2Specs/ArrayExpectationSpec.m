#import <OCDSpec2/OCDSpec2.h>

#import "OCDSFakeFailureReporter.h"

OCDSpec2Context(ArrayExpectationSpec) {
  
  __block OCDSFakeFailureReporter *reporter;
  
  BeforeEach(^{
    reporter = [OCDSFakeFailureReporter new];
  });
  
  Describe(@"-toContain", ^{
    
    It(@"passes when the array contains the element", ^{
      [[[OCDSArrayExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withArray]
       (@[@"a"]) toContain: @"a"];
      
      [ExpectInt(reporter.numberOfFailures) toBe:0];
    });
    
    It(@"fails when the array does not contain the element", ^{
      [[[OCDSArrayExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withArray]
       (@[@"a"]) toContain: @"b"];
      
      [ExpectInt(reporter.numberOfFailures) toBe:3];
      
      NSString *report;
      
      report = [reporter findFailureMessageInFile:@"file1" onLine:2];
      [ExpectObj(report) toBeEqualTo:@"Want array ("];
      
      report = [reporter findFailureMessageInFile:@"file1" onLine:3];
      [ExpectObj(report) toBeEqualTo:@"    a"];
      
      report = [reporter findFailureMessageInFile:@"file1" onLine:4];
      [ExpectObj(report) toBeEqualTo:@") to contain b"];
    });
    
  });
  
  Describe(@"-toBeEqualTo", ^{
    
    It(@"passes when two array are equal", ^{
      [[[OCDSArrayExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withArray]
       (@[@"a"]) toBeEqualTo: @[@"a"]];
      
      [ExpectInt(reporter.numberOfFailures) toBe:0];
    });
    
    It(@"fails when two objects are not equal", ^{
      [[[OCDSObjectExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withObject]
       (@[@"a"]) toBeEqualTo: @[@"b"]];
      NSString *report = [reporter findFailureMessageInFile:@"file1"
                                                     onLine:2];
      
      report = [reporter findFailureMessageInFile:@"file1" onLine:2];
      [ExpectObj(report) toBeEqualTo:@"Want ("];
      
      report = [reporter findFailureMessageInFile:@"file1" onLine:3];
      [ExpectObj(report) toBeEqualTo:@"    b"];
      
      report = [reporter findFailureMessageInFile:@"file1" onLine:4];
      [ExpectObj(report) toBeEqualTo:@"), got ("];

      report = [reporter findFailureMessageInFile:@"file1" onLine:5];
      [ExpectObj(report) toBeEqualTo:@"    a"];

      report = [reporter findFailureMessageInFile:@"file1" onLine:6];
      [ExpectObj(report) toBeEqualTo:@")"];
    });
    
  });
  
}
