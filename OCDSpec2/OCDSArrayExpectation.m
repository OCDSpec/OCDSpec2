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

- (void) toHaveCount:(int)count {
  if ([self.object count] != count) {
    [self reportFailure:[NSString stringWithFormat:@"Want count %d, got %i",
                         count,
                         (int)[self.object count]]];
  }
}

- (void) toBeEmpty {
  if ([self.object count] != 0) {
    [self reportFailure:[NSString stringWithFormat:@"Want empty array, got %@",
                         self.object]];
  }
}

@end
