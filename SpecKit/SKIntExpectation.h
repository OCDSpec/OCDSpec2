#import <Foundation/Foundation.h>

#import "SKExpectation.h"

@interface SKIntExpectation : SKExpectation

@property (readwrite, assign) long long number;

+ (SKIntExpectation*(^)(long long)) expectationFunctionInFile:(char*)file
                                                         line:(int)line
                                              failureReporter:(id<SKFailureReporter>)reporter;

- (void) toBe:(long long)other;
- (void) toBeTrue;
- (void) toBeFalse;
- (void) toNotBeFalse;

@end

#define expectInt [SKIntExpectation expectationFunctionInFile:__FILE__ line:__LINE__ failureReporter:self]
#define expectBool [SKIntExpectation expectationFunctionInFile:__FILE__ line:__LINE__ failureReporter:self]
