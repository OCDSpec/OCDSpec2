#import "OCDSBlockExpectation.h"

@implementation OCDSBlockExpectation

- (OCDSBlockExpectation*(^)(void(^)(void))) withBlock {
  return [^OCDSBlockExpectation*(void(^b)(void)){
    self.block = b;
    return self;
  } copy];
}

- (void) toNotRaiseException {
  @try {
    self.block();
  }
  @catch (NSException *exception) {
    [self reportFailure:[NSString stringWithFormat:@"Want no exception, but got one anyway: %@: %@",
                         exception.name,
                         exception.reason]];
    NSLog(@"%@", exception.callStackSymbols);
  }
}

@end
