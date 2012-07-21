#import "SKFloatExpectation.h"

@implementation SKFloatExpectation

@synthesize number;

- (SKFloatExpectation*(^)(double)) withFloat {
  return [[^SKFloatExpectation*(double num){
    self.number = num;
    return self;
  } copy] autorelease];
}

- (void) toBe:(double)other withPrecision:(double)precision {
  if (!(fabsl(self.number - other) < precision)) {
    [self reportFailure:[NSString stringWithFormat:@"Want %@, got %@",
                         [NSNumber numberWithDouble:other],
                         [NSNumber numberWithDouble:self.number]]];
  }
}

@end
