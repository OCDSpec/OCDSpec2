#import "FakeLogger.h"

@implementation FakeLogger

-(id) init {
    self = [super init];
    if (self) {
      self.messages = @[];
    }
    return self;
}

-(void) log:(NSString *)message {
  self.messages = [self.messages arrayByAddingObject:message];
}

@end
