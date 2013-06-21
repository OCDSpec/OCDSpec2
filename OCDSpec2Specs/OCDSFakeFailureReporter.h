#import <Foundation/Foundation.h>

#import "OCDSFailureReporter.h"
#import "OCDSFakeFailure.h"

@interface OCDSFakeFailureReporter : NSObject <OCDSFailureReporter>

@property (assign) NSArray* failureReports;
@property (assign) NSArray* warningReports;

- (int) numberOfFailures;
- (NSString *) findFailureMessageInFile:(NSString *)file onLine:(int)line;
- (NSString *) findWarningMessageInFile:(NSString *)file onLine:(int)line;

@end
