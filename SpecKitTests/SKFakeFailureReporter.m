#import "SKFakeFailureReporter.h"
#import "SKFakeFailure.h"

@implementation SKFakeFailureReporter

- (void) reportFailure:(NSString*)msg inFile:(NSString*)file atLine:(int)line {
  SKFakeFailure *failure = [[[SKFakeFailure alloc] init] autorelease];
  
  failure.report = msg;
  failure.inFile = file;
  failure.atLine = line;
  
  self.failureReports = [[NSArray arrayWithArray:self.failureReports] arrayByAddingObject:failure];
}

- (void) reportWarning:(NSString*)msg inFile:(NSString*)file atLine:(int)line {
  SKFakeFailure *failure = [[[SKFakeFailure alloc] init] autorelease];
  
  failure.report = msg;
  failure.inFile = file;
  failure.atLine = line;
  
  self.warningReports = [[NSArray arrayWithArray:self.warningReports] arrayByAddingObject:failure];
}

@end
