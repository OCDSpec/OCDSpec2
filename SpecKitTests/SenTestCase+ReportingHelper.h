#import <SenTestingKit/SenTestingKit.h>
#import "SKFakeFailureReporter.h"

@interface SenTestCase (ReportingHelper)

- (void) expectReport:(NSString*)message
               inFile:(NSString*)file
                 line:(int)line
        failingInFile:(char*)inFile
               atLine:(int)atLine
          forReporter:(SKFakeFailureReporter*)reporter
            asFailure:(BOOL)isFailure;

- (void) expectNoReportInFile:(char*)inFile
                       atLine:(int)atLine
                  forReporter:(SKFakeFailureReporter*)reporter
                    asFailure:(BOOL)isFailure;

@end

#define SKHelperExpectReport(__file, __line, __messg) [self expectReport:__messg inFile:__file line:__line failingInFile:__FILE__ atLine:__LINE__ forReporter:reporter asFailure:YES]
#define SKHelperExpectNoReport() [self expectNoReportInFile:__FILE__ atLine:__LINE__ forReporter:reporter asFailure:YES]

#define SKHelperExpectWarning(__file, __line, __messg) [self expectReport:__messg inFile:__file line:__line failingInFile:__FILE__ atLine:__LINE__ forReporter:reporter asFailure:NO]
#define SKHelperExpectNoWarning() [self expectNoReportInFile:__FILE__ atLine:__LINE__ forReporter:reporter asFailure:NO]
