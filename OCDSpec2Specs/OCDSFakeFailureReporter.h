#import <Foundation/Foundation.h>

#import "OCDSFailureReporter.h"
#import "OCDSFakeFailure.h"

@interface OCDSFakeFailureReporter : NSObject <OCDSFailureReporter>

@property (assign) NSArray* failureReports;
@property (assign) NSArray* warningReports;

- (int) numberOfFailures;
- (NSString *) findLastFailureMessageInFile:(NSString *)file;
- (NSArray *) findLastFailureMessagesInFile:(NSString *)file count:(int)count;
- (NSString *) findLastWarningMessageInFile:(NSString *)file;

@end
