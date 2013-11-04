#import <OCDSpec2/OCDSpec2.h>

#import "OCDSFakeFailureReporter.h"
#import "OCDSIntExpectation.h"
#import "SpecExpectation.h"

#undef Reporter
#define Reporter reporter

OCDSpec2Context(IntExpectationSpec) {

  __block OCDSFakeFailureReporter *reporter;
  
  BeforeEach(^{
    reporter = [OCDSFakeFailureReporter new];
  });
  
  Describe(@"-toBe", ^{
    
    It(@"passes when two ints are equal", ^{
      [ExpectInt(1) toBe:1];
      
      ExpectErrorCount(0);
    });
    
    It(@"fails when two ints are not equal", ^{
      [ExpectInt(2) toBe:3];
      
      ExpectLastErrorMessage(@"Want 3, got 2");
    });
    
    It(@"fails when two ints are equal but one is negative", ^{
      [ExpectInt(-1) toBe:1];

      ExpectLastErrorMessage(@"Want 1, got -1");
    });
    
  });
  
  Describe(@"-toBeTrue", ^{
    
    It(@"passes when the value is true", ^{
      [ExpectInt(YES) toBeTrue];

      ExpectErrorCount(0);
    });
    
    It(@"fails when the value is false", ^{
      [ExpectInt(NO) toBeTrue];

      ExpectLastErrorMessage(@"Want true, got false");
    });
    
  });
  
  Describe(@"-toBeFalse", ^{
    
    It(@"passes when the value is false", ^{
      [ExpectInt(NO) toBeFalse];

      ExpectErrorCount(0);
    });
    
    It(@"fails when the value is true", ^{
      [ExpectInt(YES) toBeFalse];

      ExpectLastErrorMessage(@"Want false, got true");
    });
    
  });
  
  Describe(@"-toBeNotFalse", ^{
    
    It(@"passes when the value is true", ^{
      [ExpectInt(YES) toNotBeFalse];

      ExpectErrorCount(0);
    });
    
    It(@"passes when the value is a positive int", ^{
      [ExpectInt(3) toNotBeFalse];
      
      ExpectErrorCount(0);
    });
    
    It(@"passes when the value is a negative int", ^{
      [ExpectInt(-3) toNotBeFalse];
      
      ExpectErrorCount(0);
    });
    
    It(@"fails when the value is false", ^{
      [ExpectInt(NO) toNotBeFalse];

      ExpectLastErrorMessage(@"Want anything but false, got false");
    });
      
  });

  Describe(@"ExpectTrue", ^{
    
    It(@"passes on YES", ^{
      ExpectTrue(YES);
      
      ExpectErrorCount(0);
    });
    
    It(@"fails on NO", ^{
      ExpectTrue(NO);
      
      ExpectLastErrorMessage(@"Want true, got false");
    });

  });

  Describe(@"ExpectFalse", ^{
    
    It(@"passes on NO", ^{
      ExpectFalse(NO);
      
      ExpectErrorCount(0);
    });
    
  });
  
}
