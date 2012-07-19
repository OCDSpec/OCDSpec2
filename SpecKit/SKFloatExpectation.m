#import "SKFloatExpectation.h"

@implementation SKFloatExpectation

@synthesize number;

+ (SKFloatExpectation*(^)(double)) expectationFunctionInFile:(char*)file
                                                        line:(int)line
                                             failureReporter:(id<SKFailureReporter>)reporter
{
  return [[^SKFloatExpectation*(double num){
    SKFloatExpectation *expectation = [[[SKFloatExpectation alloc] initWithFile:file
                                                                           line:line
                                                                failureReporter:reporter] autorelease];
    expectation.number = num;
    return expectation;
  } copy] autorelease];
}

- (void) toBe:(double)other withPrecision:(double)precision {
  if (!(fabsl(self.number - other) < precision)) {
    [self reportFailure:[NSString stringWithFormat:@"Want %@, got %@",
                         [NSNumber numberWithDouble:other],
                         [NSNumber numberWithDouble:self.number]]];
  }
}

@end
