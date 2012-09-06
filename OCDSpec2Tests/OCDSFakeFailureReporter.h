#import <Foundation/Foundation.h>

#import "OCDSFailureReporter.h"

@interface OCDSFakeFailureReporter : NSObject <OCDSFailureReporter>

@property (assign) NSArray* failureReports;
@property (assign) NSArray* warningReports;

@end
