#import "SKDescription.h"

#import "SKExample.h"

@implementation SKDescription

- (void) dealloc {
  self.subDescriptions = nil;
  
  self.name = nil;
  self.examples = nil;
  
  self.beforeEachBlock = nil;
  self.afterEachBlock = nil;
  
  [super dealloc];
}

- (void) runAllExamplesWithBeforeBlocks:(NSArray*)beforeBlocks afterBlocks:(NSArray*)afterBlocks {
  if (self.beforeEachBlock)
    beforeBlocks = [beforeBlocks arrayByAddingObject:self.beforeEachBlock];
  
  if (self.afterEachBlock)
    afterBlocks = [afterBlocks arrayByAddingObject:self.afterEachBlock];
  
  for (SKExample* example in self.examples) {
    for (void(^beforeBlock)(void) in beforeBlocks) {
      beforeBlock();
    }
    
    example.block();
    
    for (void(^afterBlock)(void) in afterBlocks) {
      afterBlock();
    }
  }
  
  for (SKDescription* desc in self.subDescriptions) {
    [desc runAllExamplesWithBeforeBlocks:beforeBlocks afterBlocks:afterBlocks];
  }
}

@end
