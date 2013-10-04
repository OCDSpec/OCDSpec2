#import <OCDSpec2/OCDSpec2.h>

#import "OCDSFakeFailureReporter.h"

OCDSpec2Context(BlockExpectationSpec) {
  
  __block OCDSFakeFailureReporter *reporter;
  
  BeforeEach(^{
    reporter = [OCDSFakeFailureReporter new];
  });
  
  Describe(@"-toNotRaiseException", ^{
    
    It(@"passes when the block does not raise an exception", ^{
      [[[OCDSBlockExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withBlock]
       (^{}) toNotRaiseException];
    
      [ExpectInt(reporter.numberOfFailures) toBe:0];
    });
    
    It(@"fails when the block raises an exception", ^{
      [[[OCDSBlockExpectation expectationInFile:"file1" line:2 failureReporter:reporter] withBlock]
       (^{ [NSException raise:NSInternalInconsistencyException format:@"aww"];}) toNotRaiseException];
      NSString *report = [reporter findFailureMessageInFile:@"file1"
                                                     onLine:2];
      
      [ExpectObj(report) toBeEqualTo:@"Want no exception, but got one anyway: NSInternalInconsistencyException: aww"];
    });
    
  });
  
}
