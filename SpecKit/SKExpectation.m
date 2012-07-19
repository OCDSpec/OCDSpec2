#import "SKExpectation.h"

@implementation SKExpectation

@synthesize file;
@synthesize line;
@synthesize failureReporter;

- (id) initWithFile:(char*)someFile
               line:(int)someLine
    failureReporter:(id<SKFailureReporter>)reporter
{
  if ((self = [super init])) {
    self.file = [NSString stringWithUTF8String:someFile];
    self.line = someLine;
    self.failureReporter = reporter;
  }
  return self;
}

- (void) reportFailure:(NSString*)message {
  [self.failureReporter reportFailure:message
                               inFile:self.file
                               atLine:self.line];
}

@end
