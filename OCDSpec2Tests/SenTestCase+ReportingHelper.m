#import "SenTestCase+ReportingHelper.h"
#import "OCDSFakeFailure.h"

@implementation SenTestCase (ReportingHelper)

- (void) expectReport:(NSString*)message
               inFile:(NSString*)file
                 line:(int)line
        failingInFile:(char*)inFile
               atLine:(int)atLine
          forReporter:(OCDSFakeFailureReporter*)reporter
            asFailure:(BOOL)isFailure
{
  NSArray *reports = isFailure ? reporter.failureReports : reporter.warningReports;
  NSArray *unReports = isFailure ? reporter.warningReports : reporter.failureReports;
  
  OCDSFakeFailure *failure = [reports lastObject];
  
  if ([reports count] != 1 || [unReports count] != 0) {
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
                  forReporter:(OCDSFakeFailureReporter*)reporter
                    asFailure:(BOOL)isFailure
{
  NSArray *reports = isFailure ? reporter.failureReports : reporter.warningReports;
  NSArray *unReports = isFailure ? reporter.warningReports : reporter.failureReports;
  
  if ([reports count] != 0 || [unReports count] != 0) {
    [self failWithException:[NSException failureInFile:[NSString stringWithUTF8String:inFile]
                                                atLine:atLine
                                       withDescription:@"got unexpected failure [%@], didnt expect one", [[reports lastObject] report]]];
  }
}

@end
