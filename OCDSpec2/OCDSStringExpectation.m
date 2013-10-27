#import "OCDSStringExpectation.h"

@implementation OCDSStringExpectation

- (OCDSStringExpectation*(^)(NSString*)) withString {
  return [^OCDSStringExpectation*(NSString *str){
    self.object = str;
    return self;
  } copy];
}

- (void) toContain:(NSString*)substring {
  if ([self.object rangeOfString:substring].location == NSNotFound) {
    [self reportFailure:[NSString stringWithFormat:@"Want \"*%@*\", got \"%@\"",
                         substring,
                         self.object]];
  }
}

- (void) toStartWith:(NSString*)substring {
    if ([self.object rangeOfString:substring].location != 0) {
        [self reportFailure:[NSString stringWithFormat:@"Want \"%@*\", got \"%@\"",
                             substring,
                             self.object]];
    }
}

@end
