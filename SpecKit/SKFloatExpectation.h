#import <Foundation/Foundation.h>

#import <SpecKit/SKExpectation.h>

@interface SKFloatExpectation : SKExpectation

@property (readwrite, assign) double number;

+ (SKFloatExpectation*(^)(double)) expectationFunctionInFile:(char*)file
                                                        line:(int)line
                                             failureReporter:(id<SKFailureReporter>)reporter;

- (void) toBe:(double)other withPrecision:(double)precision;

@end

#define expectFloat [SKFloatExpectation expectationFunctionInFile:__FILE__ line:__LINE__ failureReporter:self]
