#import "SKObjectExpectation.h"

@implementation SKObjectExpectation

@synthesize object;

- (SKObjectExpectation*(^)(id)) withObject {
  return [[^SKObjectExpectation*(id obj){
    self.object = obj;
    return self;
  } copy] autorelease];
}

- (void) toBe:(id)other {
  if (self.object != other) {
    [self reportFailure:[NSString stringWithFormat:@"Want %@, got %@",
                         [other description],
                         [self.object description]]];
  }
}

- (void) toBeEqualTo:(id)other {
  if (![self.object isEqual: other]) {
    [self reportFailure:[NSString stringWithFormat:@"Want %@, got %@",
                         [other description],
                         [self.object description]]];
  }
}

- (void) toExist {
  if (self.object == nil) {
    [self reportFailure:@"Want nil, but isn't"];
  }
}

- (void) toBeNil {
  if (self.object != nil) {
    [self reportFailure:[NSString stringWithFormat:@"Want nil, got %@",
                         [self.object description]]];
  }
}

- (void) toBeMemberOfClass:(Class)cls {
  if (![self.object isMemberOfClass: cls]) {
    [self reportFailure:[NSString stringWithFormat:@"Want %@, got %@",
                         cls,
                         [self.object class]]];
  }
}

- (void) toBeKindOfClass:(Class)cls {
  if (![self.object isKindOfClass: cls]) {
    [self reportFailure:[NSString stringWithFormat:@"Want %@, got %@",
                         cls,
                         [self.object class]]];
  }
}

@end
