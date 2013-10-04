#import <OCDSpec2/OCDSpec2.h>

#import "OCDSFakeFailureReporter.h"

OCDSpec2Context(StringExpectationSpec) {
  
  __block OCDSFakeFailureReporter *reporter;
  
  BeforeEach(^{
    reporter = [OCDSFakeFailureReporter new];
  });
  
  Describe(@"-toContain", ^{
    
    It(@"passes when hello contains hell", ^{
      [[[OCDSStringExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withString]
       (@"hello") toContain: @"hell"];
      
      [ExpectInt(reporter.numberOfFailures) toBe:0];
    });
    
    It(@"fails when hello does not contain jello", ^{
      [[[OCDSStringExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withString]
       (@"hello") toContain: @"jello"];
      NSString *report = [reporter findFailureMessageInFile:@"file1"
                                                     onLine:2];
      
      [ExpectObj(report) toBeEqualTo:@"Want \"*jello*\", got \"hello\""];
    });
    
  });
  
  Describe(@"-toStartWith", ^{
    
    It(@"passes when hello starts with hell", ^{
      [[[OCDSStringExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withString]
       (@"hello") toStartWith: @"hell"];
      
      [ExpectInt(reporter.numberOfFailures) toBe:0];
    });
    
    It(@"fails when hello does not start with ell", ^{
      [[[OCDSStringExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withString]
       (@"hello") toStartWith: @"ell"];
      NSString *report = [reporter findFailureMessageInFile:@"file1"
                                                     onLine:2];
      
      [ExpectObj(report) toBeEqualTo:@"Want \"ell*\", got \"hello\""];
    });
    
  });
  
}
