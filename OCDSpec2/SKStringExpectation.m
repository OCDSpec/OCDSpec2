#import "SKStringExpectation.h"

@implementation SKStringExpectation

- (SKStringExpectation*(^)(NSString*)) withString {
  return [[^SKStringExpectation*(NSString *str){
    self.string = str;
    return self;
  } copy] autorelease];
}

- (void) toContain:(NSString*)substring {
  if ([self.string rangeOfString:substring].location == NSNotFound) {
    [self reportFailure:[NSString stringWithFormat:@"Want \"*%@*\", got \"%@\"",
                         substring,
                         self.string]];
  }
}

- (void) toStartWith:(NSString*)substring {
    if ([self.string rangeOfString:substring].location != 0) {
        [self reportFailure:[NSString stringWithFormat:@"Want \"%@*\", got \"%@\"",
                             substring,
                             self.string]];
    }
}

@end
