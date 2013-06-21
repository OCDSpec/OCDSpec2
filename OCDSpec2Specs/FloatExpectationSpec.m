#import <OCDSpec2/OCDSpec2.h>

#import "OCDSFakeFailureReporter.h"

OCDSpec2Context(FloatExpectationSpec) {
  
  __block OCDSFakeFailureReporter *reporter;
  
  BeforeEach(^{
    reporter = [OCDSFakeFailureReporter new];
  });
  
  AfterEach(^{
    [reporter release];
  });
  
  Describe(@"-toBeWithPrecision", ^{
    
    It(@"passes when two floats are equal", ^{
      [[[OCDSFloatExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withFloat]
       (1.0) toBe: 1.0 withPrecision: 0.0000001];
      
      [ExpectInt(reporter.numberOfFailures) toBe:0];
    });
    
    It(@"passes when two floats are not equal but close enough", ^{
      [[[OCDSFloatExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withFloat]
       (1.99999) toBe: 2.0 withPrecision: 0.0001];
      
      [ExpectInt(reporter.numberOfFailures) toBe:0];
    });
    
    It(@"fails when two floats are not equal", ^{
      [[[OCDSFloatExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withFloat]
       (1.2) toBe: 2.1234 withPrecision: 0.0000001];
      NSString *report = [reporter findFailureMessageInFile:@"file1"
                                                     onLine:2];
      
      [ExpectObj(report) toBeEqualTo:@"Want 2.1234, got 1.2"];      
    });
    
    It(@"fails when two floats are not equal with very high precision", ^{
      [[[OCDSFloatExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withFloat]
       (1.99999) toBe: 2.0 withPrecision: 0.0000001];
      NSString *report = [reporter findFailureMessageInFile:@"file1"
                                                     onLine:2];
      
      [ExpectObj(report) toBeEqualTo:@"Want 2, got 1.99999"];
    });
    
  });
  
}
