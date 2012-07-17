#import "SKExample.h"

@implementation SKExample

@synthesize name;
@synthesize block;

- (void) dealloc {
  self.name = nil;
  self.block = nil;
  
  [super dealloc];
}

@end
