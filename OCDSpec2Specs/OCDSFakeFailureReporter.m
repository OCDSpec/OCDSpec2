#import "OCDSFakeFailureReporter.h"

@implementation OCDSFakeFailureReporter

- (void) reportFailure:(NSString*)msg inFile:(NSString*)file atLine:(int)line {
  OCDSFakeFailure *failure = [OCDSFakeFailure new];
  
  failure.report = msg;
  failure.inFile = file;
  failure.atLine = line;
  
  self.failureReports = [[NSArray arrayWithArray:self.failureReports] arrayByAddingObject:failure];
}

- (void) reportWarning:(NSString*)msg inFile:(NSString*)file atLine:(int)line {
  OCDSFakeFailure *failure = [OCDSFakeFailure new];
  
  failure.report = msg;
  failure.inFile = file;
  failure.atLine = line;
  
  self.warningReports = [[NSArray arrayWithArray:self.warningReports] arrayByAddingObject:failure];
}

- (int) numberOfFailures {
  if (self.failureReports == NULL) {
    return 0;
  }
  
  return [self.failureReports count];
}

- (NSString *)findLastFailureMessageInFile:(NSString *)file {
  for (OCDSFakeFailure *failure in [self.failureReports reverseObjectEnumerator]) {
    if ([failure.inFile isEqualToString:file]) {
      return failure.report;
    }
  }
  
  return @"";
}

- (NSArray *)findLastFailureMessagesInFile:(NSString *)file count:(int)count {
  NSMutableArray *failureMessages = [NSMutableArray new];
  
  for (OCDSFakeFailure *failure in [self.failureReports reverseObjectEnumerator]) {
    if ([failure.inFile isEqualToString:file] && [failureMessages count] < count) {
      [failureMessages addObject:failure.report];
    }
  }
  
  return [[failureMessages reverseObjectEnumerator] allObjects];
}

- (NSString *)findLastWarningMessageInFile:(NSString *)file {
  for (OCDSFakeFailure *warning in [self.warningReports reverseObjectEnumerator]) {
    if ([warning.inFile isEqualToString:file]) {
      return warning.report;
    }
  }
  
  return @"";
}

@end
