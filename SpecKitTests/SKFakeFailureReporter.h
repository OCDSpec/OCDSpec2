#import <Foundation/Foundation.h>

#import "SKFailureReporter.h"

@interface SKFakeFailureReporter : NSObject <SKFailureReporter>

@property int reportCount;
@property (retain) NSString* lastReport;
@property (retain) NSString* lastFile;
@property int lastLine;

@end
