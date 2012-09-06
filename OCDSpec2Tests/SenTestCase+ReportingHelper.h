#import <SenTestingKit/SenTestingKit.h>
#import "OCDSFakeFailureReporter.h"

@interface SenTestCase (ReportingHelper)

- (void) expectReport:(NSString*)message
               inFile:(NSString*)file
                 line:(int)line
        failingInFile:(char*)inFile
               atLine:(int)atLine
          forReporter:(OCDSFakeFailureReporter*)reporter
            asFailure:(BOOL)isFailure;

- (void) expectNoReportInFile:(char*)inFile
                       atLine:(int)atLine
                  forReporter:(OCDSFakeFailureReporter*)reporter
                    asFailure:(BOOL)isFailure;

@end

#define OCDSHelperExpectReport(__file, __line, __messg) [self expectReport:__messg inFile:__file line:__line failingInFile:__FILE__ atLine:__LINE__ forReporter:reporter asFailure:YES]
#define OCDSHelperExpectNoReport() [self expectNoReportInFile:__FILE__ atLine:__LINE__ forReporter:reporter asFailure:YES]

#define OCDSHelperExpectWarning(__file, __line, __messg) [self expectReport:__messg inFile:__file line:__line failingInFile:__FILE__ atLine:__LINE__ forReporter:reporter asFailure:NO]
#define OCDSHelperExpectNoWarning() [self expectNoReportInFile:__FILE__ atLine:__LINE__ forReporter:reporter asFailure:NO]
