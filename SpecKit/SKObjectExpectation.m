#import "SKObjectExpectation.h"

@implementation SKObjectExpectation

@synthesize file;
@synthesize line;
@synthesize failureReporter;
@synthesize object;

+ (SKObjectExpectation*(^)(id)) expectationFunctionInFile:(char*)file
                                                     line:(int)line
                                          failureReporter:(id<SKFailureReporter>)reporter
{
  return [[^SKObjectExpectation*(id obj){
    SKObjectExpectation *expectation = [[[SKObjectExpectation alloc] init] autorelease];
    expectation.file = [NSString stringWithUTF8String:file];
    expectation.line = line;
    expectation.failureReporter = reporter;
    
    expectation.object = obj;
    
    return expectation;
  } copy] autorelease];
}

- (void) toBe:(id)other {
  if (self.object != other) {
    NSString *message = [NSString stringWithFormat:@"Want %@, got %@",
                         [other description],
                         [self.object description]];
    
    [self.failureReporter reportFailure:message
                                 inFile:self.file
                                 atLine:self.line];
  }
}

- (void) toBeEqualTo:(id)other {
  if (![self.object isEqual: other]) {
    NSString *message = [NSString stringWithFormat:@"Want %@, got %@",
                         [other description],
                         [self.object description]];
    
    [self.failureReporter reportFailure:message
                                 inFile:self.file
                                 atLine:self.line];
  }
}

- (void) toExist {
  if (self.object == nil) {
    [self.failureReporter reportFailure:@"Want nil, but isn't"
                                 inFile:self.file
                                 atLine:self.line];
  }
}

- (void) toBeNil {
  if (self.object != nil) {
    NSString *message = [NSString stringWithFormat:@"Want nil, got %@",
                         [self.object description]];
    
    [self.failureReporter reportFailure:message
                                 inFile:self.file
                                 atLine:self.line];
  }
}

@end
