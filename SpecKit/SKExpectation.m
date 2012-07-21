#import "SKExpectation.h"

@implementation SKExpectation

@synthesize file;
@synthesize line;
@synthesize failureReporter;

+ (id) expectationInFile:(char*)someFile
                    line:(int)someLine
         failureReporter:(id<SKFailureReporter>)reporter
{
  SKExpectation *expectation = [[[self alloc] init] autorelease];
  expectation.file = [NSString stringWithUTF8String:someFile];
  expectation.line = someLine;
  expectation.failureReporter = reporter;
  return expectation;
}

- (void) reportFailure:(NSString*)message {
  [self.failureReporter reportFailure:message
                               inFile:self.file
                               atLine:self.line];
}

@end
