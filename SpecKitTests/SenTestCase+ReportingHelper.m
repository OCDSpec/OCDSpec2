#import "SenTestCase+ReportingHelper.h"
#import "SKFakeFailure.h"

@implementation SenTestCase (ReportingHelper)

- (void) expectReport:(NSString*)message
               inFile:(NSString*)file
                 line:(int)line
        failingInFile:(char*)inFile
               atLine:(int)atLine
          forReporter:(SKFakeFailureReporter*)reporter
{
  SKFakeFailure *failure = [reporter.reports lastObject];
  
  if ([reporter.reports count] != 1) {
    [self failWithException:[NSException failureInFile:[NSString stringWithUTF8String:inFile]
                                                atLine:atLine
                                       withDescription:@"too many reports sent"]];
  }
  
  if (![failure.report isEqualToString: message]) {
    [self failWithException:[NSException failureInFile:[NSString stringWithUTF8String:inFile]
                                                atLine:atLine
                                       withDescription:@"failed with wrong message: %@", failure.report]];
  }
  
  if (![failure.inFile isEqualToString: file]) {
    [self failWithException:[NSException failureInFile:[NSString stringWithUTF8String:inFile]
                                                atLine:atLine
                                       withDescription:@"failed in wrong file"]];
  }
  
  if (failure.atLine != line) {
    [self failWithException:[NSException failureInFile:[NSString stringWithUTF8String:inFile]
                                                atLine:atLine
                                       withDescription:@"failed at wrong line"]];
  }
}

- (void) expectNoReportInFile:(char*)inFile
                       atLine:(int)atLine
                  forReporter:(SKFakeFailureReporter*)reporter
{
  if ([reporter.reports count] != 0) {
    [self failWithException:[NSException failureInFile:[NSString stringWithUTF8String:inFile]
                                                atLine:atLine
                                       withDescription:@"got unexpected failure [%@], didnt expect one", [[reporter.reports lastObject] report]]];
  }
}

@end
