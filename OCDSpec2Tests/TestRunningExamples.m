#import <SenTestingKit/SenTestingKit.h>

#import "SKContext.h"
#import "SKDescription.h"
#import "SKExample.h"

@interface TestRunningExamples : SenTestCase
@end
@implementation TestRunningExamples

- (void) testRunningExamples {
  SKContext *ctx = [[[SKContext alloc] init] autorelease];
  
  SKDescription *desc1 = [[[SKDescription alloc] init] autorelease];
  SKDescription *desc2 = [[[SKDescription alloc] init] autorelease];
  
  NSMutableString *counter = [NSMutableString string];
  
  SKExample *example1 = [[[SKExample alloc] init] autorelease];
  SKExample *example2 = [[[SKExample alloc] init] autorelease];
  SKExample *example3 = [[[SKExample alloc] init] autorelease];
  SKExample *example4 = [[[SKExample alloc] init] autorelease];
  
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
  
  ctx.topLevelDescription.subDescriptions = [NSArray arrayWithObjects: desc1, desc2, nil];
  
  [ctx runAllExamples];
  
  STAssertTrue([counter isEqualToString: @"1234"], nil);
}

- (void) testRunningBeforeEach {
  SKContext *ctx = [[[SKContext alloc] init] autorelease];
  
  SKDescription *desc1 = [[[SKDescription alloc] init] autorelease];
  SKDescription *desc2 = [[[SKDescription alloc] init] autorelease];
  
  NSMutableString *counter = [NSMutableString string];
  
  desc1.beforeEachBlock = ^{
    [counter appendString:@"["];
  };
  
  SKExample *example1 = [[[SKExample alloc] init] autorelease];
  SKExample *example2 = [[[SKExample alloc] init] autorelease];
  SKExample *example3 = [[[SKExample alloc] init] autorelease];
  SKExample *example4 = [[[SKExample alloc] init] autorelease];
  
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
  
  ctx.topLevelDescription.subDescriptions = [NSArray arrayWithObjects: desc1, desc2, nil];
  
  [ctx runAllExamples];
  
  STAssertTrue([counter isEqualToString: @"[1[234"], nil);
}

- (void) testRunningAfterEach {
  SKContext *ctx = [[[SKContext alloc] init] autorelease];
  
  SKDescription *desc1 = [[[SKDescription alloc] init] autorelease];
  SKDescription *desc2 = [[[SKDescription alloc] init] autorelease];
  
  NSMutableString *counter = [NSMutableString string];
  
  desc1.afterEachBlock = ^{
    [counter appendString:@"]"];
  };
  
  SKExample *example1 = [[[SKExample alloc] init] autorelease];
  SKExample *example2 = [[[SKExample alloc] init] autorelease];
  SKExample *example3 = [[[SKExample alloc] init] autorelease];
  SKExample *example4 = [[[SKExample alloc] init] autorelease];
  
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
  
  ctx.topLevelDescription.subDescriptions = [NSArray arrayWithObjects: desc1, desc2, nil];
  
  [ctx runAllExamples];
  
  STAssertTrue([counter isEqualToString: @"1]2]34"], nil);
}

- (void) testRunningBeforeAndAfterEach {
  SKContext *ctx = [[[SKContext alloc] init] autorelease];
  
  SKDescription *desc1 = [[[SKDescription alloc] init] autorelease];
  SKDescription *desc2 = [[[SKDescription alloc] init] autorelease];
  
  NSMutableString *counter = [NSMutableString string];
  
  desc1.beforeEachBlock = ^{
    [counter appendString:@"["];
  };
  
  desc1.afterEachBlock = ^{
    [counter appendString:@"]"];
  };
  
  SKExample *example1 = [[[SKExample alloc] init] autorelease];
  SKExample *example2 = [[[SKExample alloc] init] autorelease];
  SKExample *example3 = [[[SKExample alloc] init] autorelease];
  SKExample *example4 = [[[SKExample alloc] init] autorelease];
  
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
  
  ctx.topLevelDescription.subDescriptions = [NSArray arrayWithObjects: desc1, desc2, nil];
  
  [ctx runAllExamples];
  
  STAssertTrue([counter isEqualToString: @"[1][2]34"], nil);
}

@end
