#import "OCDSFakeFailureReporter.h"

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

- (int) numberOfFailures {
  if (self.failureReports == NULL) {
    return 0;
  }
  
  return (int)[self.failureReports count];
}

- (NSString *)findFailureMessageInFile:(NSString *)file onLine:(int)line {
  for (OCDSFakeFailure *failure in self.failureReports) {
    if ([failure.inFile isEqualToString:file] && failure.atLine == line) {
      return failure.report;
    }
  }
  
  return @"";
}

- (NSString *)findWarningMessageInFile:(NSString *)file onLine:(int)line {
  for (OCDSFakeFailure *failure in self.warningReports) {
    if ([failure.inFile isEqualToString:file] && failure.atLine == line) {
      return failure.report;
    }
  }
  
  return @"";
}

@end
