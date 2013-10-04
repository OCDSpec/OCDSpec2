#import "OCDSExpectation.h"

@implementation OCDSExpectation

+ (id) expectationInFile:(char*)someFile
                    line:(int)someLine
         failureReporter:(id<OCDSFailureReporter>)reporter
{
  OCDSExpectation *expectation = [self new];
  expectation.file = @(someFile);
  expectation.line = someLine;
  expectation.failureReporter = reporter;
  return expectation;
}

- (void) reportFailure:(NSString*)message {
  int i = 0;
  for (NSString *rawStringLine in [message componentsSeparatedByString:@"\n"]) {
    [self.failureReporter reportFailure:rawStringLine
                                 inFile:self.file
                                 atLine:self.line + i];
    i++;
  }
}

- (void) reportWarning:(NSString*)message {
  int i = 0;
  for (NSString *rawStringLine in [message componentsSeparatedByString:@"\n"]) {
    [self.failureReporter reportWarning:rawStringLine
                                 inFile:self.file
                                 atLine:self.line + i];
    i++;
  }
}

@end
