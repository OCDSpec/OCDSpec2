#import "SKFakeFailureReporter.h"

@implementation SKFakeFailureReporter

@synthesize reportCount;
@synthesize lastReport;
@synthesize lastFile;
@synthesize lastLine;

- (void) dealloc {
  self.lastReport = nil;
  self.lastFile = nil;
  
  [super dealloc];
}

- (void) reportFailure:(NSString*)msg inFile:(NSString*)file atLine:(int)line {
  self.reportCount++;
  self.lastReport = msg;
  self.lastFile = file;
  self.lastLine = line;
}

@end
