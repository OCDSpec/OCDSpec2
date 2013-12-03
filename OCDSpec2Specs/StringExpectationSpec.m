#import <OCDSpec2/OCDSpec2.h>

#import "OCDSFakeFailureReporter.h"
#import "SpecExpectation.h"

#undef Reporter
#define Reporter reporter

OCDSpec2Context(StringExpectationSpec) {

  __block OCDSFakeFailureReporter *reporter;

  BeforeEach(^{
    reporter = [OCDSFakeFailureReporter new];
  });

  Describe(@"-toContain", ^{

    It(@"passes when hello contains hell", ^{
      [ExpectStr(@"hello") toContain:@"hell"];

      ExpectErrorCount(0);
    });

    It(@"fails when hello does not contain jello", ^{
      [ExpectStr(@"hello") toContain:@"jello"];

      ExpectLastErrorMessage(@"Want \"*jello*\", got \"hello\"");
    });

  });

  Describe(@"-toStartWith", ^{

    It(@"passes when hello starts with hell", ^{
      [ExpectStr(@"hello") toStartWith:@"hell"];
      
      ExpectErrorCount(0);
    });

    It(@"fails when hello does not start with ell", ^{
      [ExpectStr(@"hello") toStartWith:@"ell"];

      ExpectLastErrorMessage(@"Want \"ell*\", got \"hello\"");
    });

  });

  Describe(@"-toBeEqualTo", ^{

    It(@"passes when the strings are equal", ^{
      [ExpectStr(@"a") toContain:@"a"];
      
      ExpectErrorCount(0);
    });

    It(@"fails when the two strings are not equal", ^{
      [ExpectStr(@"a") toBeEqualTo:@"b"];

      ExpectLastErrorMessage(@"Want b, got a");
    });

  });

}
