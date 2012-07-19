#import "SKIntExpectation.h"

@implementation SKIntExpectation

@synthesize number;

+ (SKIntExpectation*(^)(long long)) expectationFunctionInFile:(char*)file
                                                         line:(int)line
                                              failureReporter:(id<SKFailureReporter>)reporter
{
  return [[^SKIntExpectation*(long long num){
    SKIntExpectation *expectation = [[[SKIntExpectation alloc] initWithFile:file
                                                                       line:line
                                                            failureReporter:reporter] autorelease];
    expectation.number = num;
    return expectation;
  } copy] autorelease];
}

- (void) toBe:(long long)other {
  if (self.number != other) {
    [self reportFailure:[NSString stringWithFormat:@"Want %d, got %d",
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
