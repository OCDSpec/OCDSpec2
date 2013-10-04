#import "OCDSFloatExpectation.h"

@implementation OCDSFloatExpectation

- (OCDSFloatExpectation*(^)(double)) withFloat {
  return [^OCDSFloatExpectation*(double num){
    self.number = num;
    return self;
  } copy];
}

- (void) toBe:(double)other withPrecision:(double)precision {
  if (!(fabsl(self.number - other) < precision)) {
    [self reportFailure:[NSString stringWithFormat:@"Want %@, got %@",
                         @(other),
                         @(self.number)]];
  }
}

@end
