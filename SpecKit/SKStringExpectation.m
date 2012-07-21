#import "SKStringExpectation.h"

@implementation SKStringExpectation

@synthesize string;

+ (SKStringExpectation*(^)(NSString*)) expectationFunctionInFile:(char*)file
                                                            line:(int)line
                                                 failureReporter:(id<SKFailureReporter>)reporter
{
  return [[^SKStringExpectation*(NSString *str){
    SKStringExpectation *expectation = [[[SKStringExpectation alloc] initWithFile:file
                                                                             line:line
                                                                  failureReporter:reporter] autorelease];
    expectation.string = str;
    return expectation;
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
