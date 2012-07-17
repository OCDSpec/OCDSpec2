#import "SKDescription.h"

@implementation SKDescription

@synthesize name;
@synthesize examples;

@synthesize beforeEachBlock;
@synthesize afterEachBlock;

- (void) dealloc {
  self.name = nil;
  self.examples = nil;
  
  self.beforeEachBlock = nil;
  self.afterEachBlock = nil;
  
  [super dealloc];
}

@end
