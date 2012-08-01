#import <Foundation/Foundation.h>

#import "SKFailureReporter.h"

@interface SKFakeFailureReporter : NSObject <SKFailureReporter>

@property (assign) NSArray* failureReports;
@property (assign) NSArray* warningReports;

@end
