#import <SenTestingKit/SenTestingKit.h>

#import "SKContext.h"
#import "SKDescription.h"
#import "SKExample.h"

@interface TestGatheringExamples : SenTestCase
@end
@implementation TestGatheringExamples

- (void) testContextGatherExamples {
  SKContext *ctx = [[[SKContext alloc] init] autorelease];
  
  __block int proofBlockGetsCalled = 0;
  
  id itBlock = ^{
    proofBlockGetsCalled += 42;
  };
  
  [ctx _functionForDescribeBlock](@"hi", ^{
    [ctx _functionForExampleBlockInFile:__FILE__ atLine:__LINE__](@"sup", itBlock);
  });
  
  STAssertTrue([ctx.topLevelDescription.subDescriptions count] == 1, nil);
  
  SKDescription *desc = [ctx.topLevelDescription.subDescriptions objectAtIndex:0];
  STAssertTrue([desc.name isEqualToString: @"hi"], nil);
  
  SKExample *example = [desc.examples objectAtIndex:0];
  STAssertTrue([desc.examples count] == 1, nil);
  
  STAssertTrue([example.name isEqual: @"sup"], nil);
  
  STAssertTrue(proofBlockGetsCalled == 0, nil);
  example.block();
  STAssertTrue(proofBlockGetsCalled == 42, nil);
}

- (void) testDefaultBeforeAfterEachBlocks {
  SKContext *ctx = [[[SKContext alloc] init] autorelease];
  
  [ctx _functionForDescribeBlock](@"hi", ^{});
  
  SKDescription *desc = [ctx.topLevelDescription.subDescriptions objectAtIndex:0];
  
  STAssertTrue(desc.beforeEachBlock == nil, nil);
  STAssertTrue(desc.afterEachBlock == nil, nil);
}

- (void) testSettingBeforeAfterEachBlocks {
  SKContext *ctx = [[[SKContext alloc] init] autorelease];
  
  id beforeEachBlock = ^{};
  id afterEachBlock = ^{};
  
  [ctx _functionForDescribeBlock](@"hi", ^{
    
    [ctx _functionForBeforeEachBlock](beforeEachBlock);
    [ctx _functionForAfterEachBlock](afterEachBlock);
    
  });
  
  SKDescription *desc = [ctx.topLevelDescription.subDescriptions objectAtIndex:0];
  
  STAssertTrue((id)desc.beforeEachBlock == beforeEachBlock, nil);
  STAssertTrue((id)desc.afterEachBlock == afterEachBlock, nil);
}

@end
