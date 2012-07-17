#import "SKIntExpectation.h"

@implementation SKIntExpectation

@synthesize file;
@synthesize line;
@synthesize failureReporter;
@synthesize number;

+ (SKIntExpectation*(^)(long long)) expectationFunctionInFile:(char*)file
                                                         line:(int)line
                                              failureReporter:(id<SKFailureReporter>)reporter
{
  return [[^SKIntExpectation*(long long num){
    SKIntExpectation *expectation = [[[SKIntExpectation alloc] init] autorelease];
    expectation.file = [NSString stringWithUTF8String:file];
    expectation.line = line;
    expectation.failureReporter = reporter;
    
    expectation.number = num;
    
    return expectation;
  } copy] autorelease];
}

- (void) toBe:(long long)other {
  if (self.number != other) {
    NSString *message = [NSString stringWithFormat:@"Expected %d, got %d",
                         other,
                         self.number];
    
    [self.failureReporter reportFailure:message
                                 inFile:self.file
                                 atLine:self.line];
  }
}

@end
