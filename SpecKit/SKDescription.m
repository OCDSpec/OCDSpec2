#import "SKDescription.h"

@implementation SKDescription

- (void) dealloc {
  self.name = nil;
  self.examples = nil;
  
  self.beforeEachBlock = nil;
  self.afterEachBlock = nil;
  
  [super dealloc];
}

@end
