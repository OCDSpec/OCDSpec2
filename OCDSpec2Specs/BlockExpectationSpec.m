#import <OCDSpec2/OCDSpec2.h>

#import "OCDSFakeFailureReporter.h"
#import "SpecExpectation.h"

#undef Reporter
#define Reporter reporter

OCDSpec2Context(BlockExpectationSpec) {
  
  __block OCDSFakeFailureReporter *reporter;
  
  BeforeEach(^{
    reporter = [OCDSFakeFailureReporter new];
  });
  
  Describe(@"-toNotRaiseException", ^{
    
    It(@"passes when the block does not raise an exception", ^{
      [ExpectBlock(^{}) toNotRaiseException];
      
      ExpectErrorCount(0);
    });
    
    It(@"fails when the block raises an exception", ^{
      [ExpectBlock(^{ [NSException raise:NSInternalInconsistencyException format:@"aww"];}) toNotRaiseException];
      
      ExpectLastErrorMessage(@"Want no exception, but got one anyway: NSInternalInconsistencyException: aww");
    });
    
  });
  
}
