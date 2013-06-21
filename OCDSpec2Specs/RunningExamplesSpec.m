#import <OCDSpec2/OCDSpec2.h>

#import "OCDSExample.h"

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
      context = [[[OCDSContext alloc] init] autorelease];
      desc1 = [[[OCDSDescription alloc] init] autorelease];
      desc2 = [[[OCDSDescription alloc] init] autorelease];
      counter = [NSMutableString string];

      example1 = [[[OCDSExample alloc] init] autorelease];
      example2 = [[[OCDSExample alloc] init] autorelease];
      example3 = [[[OCDSExample alloc] init] autorelease];
      example4 = [[[OCDSExample alloc] init] autorelease];
      
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

      desc1.examples = [NSArray arrayWithObjects: example1, example2, nil];
      desc2.examples = [NSArray arrayWithObjects: example3, example4, nil];
      
      context.topLevelDescription.subDescriptions = [NSArray arrayWithObjects: desc1, desc2, nil];
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
