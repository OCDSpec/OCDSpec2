#import "OCDSIntExpectation.h"

@implementation OCDSIntExpectation

- (OCDSIntExpectation*(^)(long long)) withInt {
  return [^OCDSIntExpectation*(long long num){
    self.number = num;
    return self;
  } copy];
}

- (void) toBe:(long long)other {
  if (self.number != other) {
    [self reportFailure:[NSString stringWithFormat:@"Want %qi, got %qi",
                         other,
                         self.number]];
  }
}

- (void) toBeTrue {
  if (self.number != YES) {
    [self reportFailure:@"Want true, got false"];
  }
}

- (void) toBeFalse {
  if (self.number != NO) {
    [self reportFailure:@"Want false, got true"];
  }
}

- (void) toNotBeFalse {
  if (self.number == NO) {
    [self reportFailure:@"Want anything but false, got false"];
  }
}

@end
