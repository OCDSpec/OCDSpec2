#import <Foundation/Foundation.h>

#import "SKFailureReporter.h"

@interface SKExpectation : NSObject

@property (readwrite, assign) NSString *file;
@property (readwrite, assign) int line;
@property (readwrite, assign) id<SKFailureReporter> failureReporter;

- (id) initWithFile:(char*)file
               line:(int)line
    failureReporter:(id<SKFailureReporter>)reporter;

- (void) reportFailure:(NSString*)message;

@end
