#import <OCDSpec2/OCDSpec2.h>

#import "OCDSExample.h"

OCDSpec2Context(GatheringExamplesSpec) {

  __block OCDSContext *context;
  
  BeforeEach(^{
    context = [[[OCDSContext alloc] init] autorelease];
  });
  
  Describe(@"OCDSpec context", ^{
    
    It(@"gathers multiple examples", ^{
      __block int proofBlockGetsCalled = 0;
      
      id itBlock = ^{
        proofBlockGetsCalled += 42;
      };
      
      [context _functionForDescribeBlock](@"hi", ^{
        [context _functionForExampleBlockInFile:__FILE__ atLine:__LINE__](@"sup", itBlock);
      });
      
      [ExpectInt([context.topLevelDescription.subDescriptions count]) toBe: 1];

      OCDSDescription *desc = [context.topLevelDescription.subDescriptions objectAtIndex:0];
      [ExpectObj(desc.name) toBeEqualTo: @"hi"];
      
      OCDSExample *example = [desc.examples objectAtIndex:0];
      [ExpectInt([desc.examples count]) toBe:1];
      
      [ExpectObj(example.name) toBeEqualTo:@"sup"];
      
      [ExpectInt(proofBlockGetsCalled) toBe:0];
      
      example.block();
      [ExpectInt(proofBlockGetsCalled) toBe:42];
    });
    
    It(@"starts with no before block", ^{
      [context _functionForDescribeBlock](@"hi", ^{});
      
      OCDSDescription *desc = [context.topLevelDescription.subDescriptions objectAtIndex:0];
      
      [ExpectObj(desc.beforeEachBlock) toBeNil];
    });
    
    It(@"starts with no after block", ^{
      [context _functionForDescribeBlock](@"hi", ^{});
      
      OCDSDescription *desc = [context.topLevelDescription.subDescriptions objectAtIndex:0];
      
      [ExpectObj(desc.afterEachBlock) toBeNil];
    });


    It(@"sets a before block", ^{
      id beforeEachBlock = ^{};
      [context _functionForDescribeBlock](@"hi", ^{
        [context _functionForBeforeEachBlock](beforeEachBlock);
      });
      
      OCDSDescription *desc = [context.topLevelDescription.subDescriptions objectAtIndex:0];
      [ExpectObj(desc.beforeEachBlock) toBe: beforeEachBlock];
    });

    It(@"sets an after block", ^{
      id afterEachBlock = ^{};
      
      [context _functionForDescribeBlock](@"hi", ^{
        [context _functionForAfterEachBlock](afterEachBlock);
      });
      
      OCDSDescription *desc = [context.topLevelDescription.subDescriptions objectAtIndex:0];
      [ExpectObj(desc.afterEachBlock) toBe: afterEachBlock];
    });

  });
  
}
