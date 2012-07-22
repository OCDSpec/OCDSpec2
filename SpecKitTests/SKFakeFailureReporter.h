#import <Foundation/Foundation.h>

#import "SKFailureReporter.h"

@interface SKFakeFailureReporter : NSObject <SKFailureReporter>

@property (assign) NSArray* reports;

@end
