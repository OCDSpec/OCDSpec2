#import <OCDSpec2/OCDSpec2.h>

#import "OCDSExample.h"
#import "FakeLogger.h"

OCDSpec2Context(RunningExamplesSpec) {
  
  Describe(@"-someBehavior", ^{

    __block OCDSContext *context;
    __block OCDSDescription *desc1;
    __block OCDSDescription *desc2;
    __block NSMutableString *counter;
    __block OCDSExample *example1;
    __block OCDSExample *example2;
    __block OCDSExample *example3;
    __block OCDSExample *example4;

    BeforeEach(^{
      FakeLogger *logger = [FakeLogger new];

      context = [OCDSContext new];
      desc1 = [[OCDSDescription alloc] initWithLogger:logger];
      desc2 = [[OCDSDescription alloc] initWithLogger:logger];
      counter = [NSMutableString string];

      example1 = [OCDSExample new];
      example2 = [OCDSExample new];
      example3 = [OCDSExample new];
      example4 = [OCDSExample new];

      example1.block = ^{
        [counter appendString:@"1"];
      };
      
      example2.block = ^{
        [counter appendString:@"2"];
      };

      example3.block = ^{
        [counter appendString:@"3"];
      };

      example4.block = ^{
        [counter appendString:@"4"];
      };

      desc1.examples = @[example1, example2];
      desc2.examples = @[example3, example4];

      context.topLevelDescription.subDescriptions = @[desc1, desc2];
    });
    
    It(@"runs all examples with neither a before nor an after block", ^{
      [context runAllExamples];
      
      [ExpectObj(counter) toBeEqualTo:@"1234"];
    });

    It(@"runs a before each block for examples on one description", ^{
      desc1.beforeEachBlock = ^{
        [counter appendString:@"["];
      };

      [context runAllExamples];

      [ExpectObj(counter) toBeEqualTo: @"[1[234"];
    });
    
    It(@"runs an after each block for examples on one description", ^{
      desc1.afterEachBlock = ^{
        [counter appendString:@"]"];
      };
      
      [context runAllExamples];
      
      [ExpectObj(counter) toBeEqualTo: @"1]2]34"];
    });
    
    It(@"runs a before each and after each block on one description", ^{
      desc1.beforeEachBlock = ^{
        [counter appendString:@"["];
      };
      
      desc1.afterEachBlock = ^{
        [counter appendString:@"]"];
      };
      
      [context runAllExamples];
      
      [ExpectObj(counter) toBeEqualTo: @"[1][2]34"];
    });
    
  });
  
}
