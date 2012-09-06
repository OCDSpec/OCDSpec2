#import "OCDSFakeFailureReporter.h"
#import "OCDSFakeFailure.h"

@implementation OCDSFakeFailureReporter

- (void) reportFailure:(NSString*)msg inFile:(NSString*)file atLine:(int)line {
  OCDSFakeFailure *failure = [[[OCDSFakeFailure alloc] init] autorelease];
  
  failure.report = msg;
  failure.inFile = file;
  failure.atLine = line;
  
  self.failureReports = [[NSArray arrayWithArray:self.failureReports] arrayByAddingObject:failure];
}

- (void) reportWarning:(NSString*)msg inFile:(NSString*)file atLine:(int)line {
  OCDSFakeFailure *failure = [[[OCDSFakeFailure alloc] init] autorelease];
  
  failure.report = msg;
  failure.inFile = file;
  failure.atLine = line;
  
  self.warningReports = [[NSArray arrayWithArray:self.warningReports] arrayByAddingObject:failure];
}

@end
