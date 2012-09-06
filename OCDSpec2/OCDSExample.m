#import "OCDSExample.h"

@implementation OCDSExample

- (void) dealloc {
  self.name = nil;
  self.block = nil;
  
  [super dealloc];
}

@end
