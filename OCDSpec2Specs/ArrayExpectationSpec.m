#import <OCDSpec2/OCDSpec2.h>

#import "OCDSFakeFailureReporter.h"
#import "SpecExpectation.h"

#undef Reporter
#define Reporter reporter

OCDSpec2Context(ArrayExpectationSpec) {
  
  __block OCDSFakeFailureReporter *reporter;
  
  BeforeEach(^{
    reporter = [OCDSFakeFailureReporter new];
  });
  
  Describe(@"-toContain", ^{
    
    It(@"passes when the array contains the element", ^{
      [ExpectArray(@[@"a"]) toContain:@"a"];
      
      ExpectErrorCount(0);
    });
    
    It(@"fails when the array does not contain the element", ^{
      [ExpectArray(@[@"a"]) toContain:@"b"];
      
      NSArray *msgs = @[@"Want array (", @"    a", @") to contain b"];
      
      ExpectLastErrorMessages(msgs);
    });
    
  });
  
  Describe(@"-toBeEqualTo", ^{
    
    It(@"passes when two array are equal", ^{
      [ExpectArray(@[@"a"]) toBeEqualTo:@[@"a"]];
      
      ExpectErrorCount(0);
    });
    
    It(@"fails when two objects are not equal", ^{
      [ExpectArray(@[@"a"]) toBeEqualTo:@[@"b"]];
      
      NSArray *msgs = @[@"Want (", @"    b", @"), got (", @"    a", @")"];
      
      ExpectLastErrorMessages(msgs);
    });
    
  });
  
  Describe(@"-toHaveCount", ^{
    
    It(@"passes if the count is the same", ^{
      [ExpectArray(@[@"a", @"b", @"c"]) toHaveCount:3];
      
      ExpectErrorCount(0);
    });
    
    It(@"fails when the count does not match expected", ^{
      [ExpectArray(@[@"a", @"b", @"c"]) toHaveCount:2];

      ExpectLastErrorMessage(@"Want count 2, got 3");
    });

  });
  
  Describe(@"-toBeEmpty", ^{
    
    It(@"passes when the array is empty", ^{
      [ExpectArray(@[]) toBeEmpty];
      
      ExpectErrorCount(0);
    });

    It(@"fails when the array is not empty", ^{
      [ExpectArray(@[@"a"]) toBeEmpty];
      
      NSArray *msgs = @[@"Want empty array, got (", @"    a", @")"];
      
      ExpectLastErrorMessages(msgs);
    });

  });

}
