#import <OCDSpec2/OCDSpec2.h>

#import "OCDSFakeFailureReporter.h"
#import "SpecExpectation.h"

#undef Reporter
#define Reporter reporter

OCDSpec2Context(FloatExpectationSpec) {
  
  __block OCDSFakeFailureReporter *reporter;
  
  BeforeEach(^{
    reporter = [OCDSFakeFailureReporter new];
  });
  
  Describe(@"-toBeWithPrecision", ^{
    
    It(@"passes when two floats are equal", ^{
      [ExpectFloat(1.0) toBe:1.0 withPrecision:0.0000001];
      
      ExpectErrorCount(0);
    });
    
    It(@"passes when two floats are not equal but close enough", ^{
      [ExpectFloat(1.99999) toBe:2.0 withPrecision:0.0001];
      
      ExpectErrorCount(0);
    });
    
    It(@"fails when two floats are not equal", ^{
      [ExpectFloat(1.2) toBe:2.1234 withPrecision:0.000001];
      
      ExpectLastErrorMessage(@"Want 2.1234, got 1.2");
    });
    
    It(@"fails when two floats are not equal with very high precision", ^{
      [ExpectFloat(1.99999) toBe:2.0 withPrecision:0.000001];
      
      ExpectLastErrorMessage(@"Want 2, got 1.99999");
    });
    
  });
  
}
