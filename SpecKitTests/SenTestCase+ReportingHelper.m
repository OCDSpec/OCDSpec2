#import "SenTestCase+ReportingHelper.h"

@implementation SenTestCase (ReportingHelper)

- (void) expectReport:(NSString*)message
               inFile:(NSString*)file
                 line:(int)line
        failingInFile:(char*)inFile
               atLine:(int)atLine
          forReporter:(SKFakeFailureReporter*)reporter
{
  if (reporter.reportCount != 1) {
    [self failWithException:[NSException failureInFile:[NSString stringWithUTF8String:inFile]
                                                atLine:atLine
                                       withDescription:@"too many reports sent"]];
  }
  
  if (![reporter.lastReport isEqualToString: message]) {
    [self failWithException:[NSException failureInFile:[NSString stringWithUTF8String:inFile]
                                                atLine:atLine
                                       withDescription:@"failed with wrong message"]];
  }
  
  if (![reporter.lastFile isEqualToString: file]) {
    [self failWithException:[NSException failureInFile:[NSString stringWithUTF8String:inFile]
                                                atLine:atLine
                                       withDescription:@"failed in wrong file"]];
  }
  
  if (reporter.lastLine != line) {
    [self failWithException:[NSException failureInFile:[NSString stringWithUTF8String:inFile]
                                                atLine:atLine
                                       withDescription:@"failed at wrong line"]];
  }
}

- (void) expectNoReportInFile:(char*)inFile
                       atLine:(int)atLine
                  forReporter:(SKFakeFailureReporter*)reporter
{
  if (reporter.reportCount != 0) {
    [self failWithException:[NSException failureInFile:[NSString stringWithUTF8String:inFile]
                                                atLine:atLine
                                       withDescription:@"got a report, didnt expect one"]];
  }
}

@end
