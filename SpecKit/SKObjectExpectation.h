#import <Foundation/Foundation.h>

#import "SKExpectation.h"

@interface SKObjectExpectation : SKExpectation

@property (readwrite, assign) id object;

+ (SKObjectExpectation*(^)(id)) expectationFunctionInFile:(char*)file
                                                     line:(int)line
                                          failureReporter:(id<SKFailureReporter>)reporter;

- (void) toBe:(id)other;
- (void) toBeEqualTo:(id)other;
- (void) toExist;
- (void) toBeNil;
- (void) toBeMemberOfClass:(Class)cls;
- (void) toBeKindOfClass:(Class)cls;

@end

#define expect [SKObjectExpectation expectationFunctionInFile:__FILE__ line:__LINE__ failureReporter:self]
