#import "SKArrayExpectation.h"

@implementation SKArrayExpectation

- (SKArrayExpectation*(^)(NSArray*)) withArray {
  return [[^SKArrayExpectation*(NSArray *a){
    self.array = a;
    return self;
  } copy] autorelease];
}

- (void) toContain:(id)obj {
  if (![self.array containsObject: obj]) {
    [self reportFailure:[NSString stringWithFormat:@"Want array %@ to contain %@",
                         self.array,
                         obj]];
  }
}

@end
