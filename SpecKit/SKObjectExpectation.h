#import <Foundation/Foundation.h>

#import "SKFailureReporter.h"

@interface SKObjectExpectation : NSObject

@property (readwrite, assign) NSString *file;
@property (readwrite, assign) int line;
@property (readwrite, assign) id<SKFailureReporter> failureReporter;
@property (readwrite, assign) id object;

+ (SKObjectExpectation*(^)(id)) expectationFunctionInFile:(char*)file
                                                     line:(int)line
                                          failureReporter:(id<SKFailureReporter>)reporter;

- (void) toBe:(id)other;
- (void) toBeEqualTo:(id)other;
- (void) toExist;
- (void) toBeNil;

@end

#define expect [SKObjectExpectation expectationFunctionInFile:__FILE__ line:__LINE__ failureReporter:self]
