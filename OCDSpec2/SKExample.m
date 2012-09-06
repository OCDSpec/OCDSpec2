#import "SKExample.h"

@implementation SKExample

- (void) dealloc {
  self.name = nil;
  self.block = nil;
  
  [super dealloc];
}

@end
