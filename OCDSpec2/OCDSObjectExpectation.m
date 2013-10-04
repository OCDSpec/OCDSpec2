#import "OCDSObjectExpectation.h"

@implementation OCDSObjectExpectation

- (OCDSObjectExpectation*(^)(id)) withObject {
  return [^OCDSObjectExpectation*(id obj){
    self.object = obj;
    return self;
  } copy];
}

- (void) pending {
  [self reportWarning:@"Pending"];
}

- (void(^)(NSString*))pendingWithString {
  return [^(NSString* msg){
    [self reportWarning:[NSString stringWithFormat:@"Pending: %@", msg]];
  } copy];
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
    [self reportFailure:@"Want real object, got nil"];
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
