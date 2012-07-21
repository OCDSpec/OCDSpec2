#import <Foundation/Foundation.h>

#import <SpecKit/SKExpectation.h>

@interface SKFloatExpectation : SKExpectation

@property (readwrite, assign) double number;

- (SKFloatExpectation*(^)(double)) withFloat;

- (void) toBe:(double)other withPrecision:(double)precision;

@end

#define expectFloat [[SKFloatExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:self] withFloat]
