#import <Foundation/Foundation.h>

#import <OCDSpec2/OCDSExpectation.h>

@interface OCDSFloatExpectation : OCDSExpectation

@property (readwrite, assign) double number;

- (OCDSFloatExpectation*(^)(double)) withFloat;

- (void) toBe:(double)other withPrecision:(double)precision;

@end

#define ExpectFloat [[OCDSFloatExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:self] withFloat]
