#import <SenTestingKit/SenTestingKit.h>

#import "OCDSContext.h"
#import "OCDSDescription.h"
#import "OCDSExample.h"

@interface TestRunningExamples : SenTestCase
@end
@implementation TestRunningExamples

- (void) testRunningExamples {
  OCDSContext *ctx = [[[OCDSContext alloc] init] autorelease];
  
  OCDSDescription *desc1 = [[[OCDSDescription alloc] init] autorelease];
  OCDSDescription *desc2 = [[[OCDSDescription alloc] init] autorelease];
  
  NSMutableString *counter = [NSMutableString string];
  
  OCDSExample *example1 = [[[OCDSExample alloc] init] autorelease];
  OCDSExample *example2 = [[[OCDSExample alloc] init] autorelease];
  OCDSExample *example3 = [[[OCDSExample alloc] init] autorelease];
  OCDSExample *example4 = [[[OCDSExample alloc] init] autorelease];
  
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
  OCDSContext *ctx = [[[OCDSContext alloc] init] autorelease];
  
  OCDSDescription *desc1 = [[[OCDSDescription alloc] init] autorelease];
  OCDSDescription *desc2 = [[[OCDSDescription alloc] init] autorelease];
  
  NSMutableString *counter = [NSMutableString string];
  
  desc1.beforeEachBlock = ^{
    [counter appendString:@"["];
  };
  
  OCDSExample *example1 = [[[OCDSExample alloc] init] autorelease];
  OCDSExample *example2 = [[[OCDSExample alloc] init] autorelease];
  OCDSExample *example3 = [[[OCDSExample alloc] init] autorelease];
  OCDSExample *example4 = [[[OCDSExample alloc] init] autorelease];
  
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
  OCDSContext *ctx = [[[OCDSContext alloc] init] autorelease];
  
  OCDSDescription *desc1 = [[[OCDSDescription alloc] init] autorelease];
  OCDSDescription *desc2 = [[[OCDSDescription alloc] init] autorelease];
  
  NSMutableString *counter = [NSMutableString string];
  
  desc1.afterEachBlock = ^{
    [counter appendString:@"]"];
  };
  
  OCDSExample *example1 = [[[OCDSExample alloc] init] autorelease];
  OCDSExample *example2 = [[[OCDSExample alloc] init] autorelease];
  OCDSExample *example3 = [[[OCDSExample alloc] init] autorelease];
  OCDSExample *example4 = [[[OCDSExample alloc] init] autorelease];
  
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
  OCDSContext *ctx = [[[OCDSContext alloc] init] autorelease];
  
  OCDSDescription *desc1 = [[[OCDSDescription alloc] init] autorelease];
  OCDSDescription *desc2 = [[[OCDSDescription alloc] init] autorelease];
  
  NSMutableString *counter = [NSMutableString string];
  
  desc1.beforeEachBlock = ^{
    [counter appendString:@"["];
  };
  
  desc1.afterEachBlock = ^{
    [counter appendString:@"]"];
  };
  
  OCDSExample *example1 = [[[OCDSExample alloc] init] autorelease];
  OCDSExample *example2 = [[[OCDSExample alloc] init] autorelease];
  OCDSExample *example3 = [[[OCDSExample alloc] init] autorelease];
  OCDSExample *example4 = [[[OCDSExample alloc] init] autorelease];
  
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
