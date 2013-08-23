#import <OCDSpec2/OCDSpec2.h>

#import "OCDSExample.h"
#import "FakeLogger.h"

OCDSpec2Context(OCDSDescriptionSpec) {
  
  Describe(@"running examples", ^{
    
    It(@"logs all description names", ^{
      FakeLogger *logger = [[FakeLogger new] autorelease];
      OCDSDescription *description = [[[OCDSDescription alloc] initWithLogger:logger] autorelease];
      description.name = @"Test";
      
      OCDSExample *example = [[OCDSExample new] autorelease];
      example.block = ^{};
      example.name = @"My Example";
      description.examples = @[example];
  
      [description runAll];
      [ExpectArray(logger.messages) toContain:[description logMessage:example.name]];
    });
    
  });
  
}
