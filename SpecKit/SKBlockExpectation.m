#import "SKBlockExpectation.h"

@implementation SKBlockExpectation

- (SKBlockExpectation*(^)(void(^)(void))) withBlock {
  return [[^SKBlockExpectation*(void(^b)(void)){
    self.block = b;
    return self;
  } copy] autorelease];
}

- (void) toNotRaiseException {
  @try {
    self.block();
  }
  @catch (NSException *exception) {
    [self reportFailure:[NSString stringWithFormat:@"Want no exception, but got one anyway: %@: %@",
                         exception.name,
                         exception.reason]];
  }
}

@end
