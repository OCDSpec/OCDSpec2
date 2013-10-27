#import "OCDSArrayExpectation.h"

@implementation OCDSArrayExpectation

- (OCDSArrayExpectation*(^)(NSArray*)) withArray {
  return [^OCDSArrayExpectation*(NSArray *a){
    self.object = a;
    return self;
  } copy];
}

- (void) toContain:(id)obj {
  if (![self.object containsObject: obj]) {
    [self reportFailure:[NSString stringWithFormat:@"Want array %@ to contain %@",
                         self.object,
                         obj]];
  }
}

@end
