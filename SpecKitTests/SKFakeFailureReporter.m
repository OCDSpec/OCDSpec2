#import "SKFakeFailureReporter.h"
#import "SKFakeFailure.h"

@implementation SKFakeFailureReporter

@synthesize reports;

- (void) reportFailure:(NSString*)msg inFile:(NSString*)file atLine:(int)line {
  SKFakeFailure *failure = [[[SKFakeFailure alloc] init] autorelease];
  
  failure.report = msg;
  failure.inFile = file;
  failure.atLine = line;
  
  self.reports = [[NSArray arrayWithArray:self.reports] arrayByAddingObject:failure];
}

@end
