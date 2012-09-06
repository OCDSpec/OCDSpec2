#import <Foundation/Foundation.h>

#import <OCDSpec2/SKFailureReporter.h>

@interface SKExpectation : NSObject

@property (readwrite, assign) NSString *file;
@property (readwrite, assign) int line;
@property (readwrite, assign) id<SKFailureReporter> failureReporter;

+ (id) expectationInFile:(char*)someFile
                    line:(int)someLine
         failureReporter:(id<SKFailureReporter>)reporter;

- (void) reportFailure:(NSString*)message;
- (void) reportWarning:(NSString*)message;

@end
