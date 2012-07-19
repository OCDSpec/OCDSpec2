#import <SenTestingKit/SenTestingKit.h>
#import "SKFakeFailureReporter.h"

@interface SenTestCase (ReportingHelper)

- (void) expectReport:(NSString*)message
               inFile:(NSString*)file
                 line:(int)line
        failingInFile:(char*)inFile
               atLine:(int)atLine
          forReporter:(SKFakeFailureReporter*)reporter;

- (void) expectNoReportInFile:(char*)inFile
                       atLine:(int)atLine
                  forReporter:(SKFakeFailureReporter*)reporter;

@end

#define SKHelperExpectReport(__file, __line, __messg) [self expectReport:__messg inFile:__file line:__line failingInFile:__FILE__ atLine:__LINE__ forReporter:reporter]

#define SKHelperExpectNoReport() [self expectNoReportInFile:__FILE__ atLine:__LINE__ forReporter:reporter]
