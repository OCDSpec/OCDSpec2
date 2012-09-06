#import <Foundation/Foundation.h>

#import <OCDSpec2/SKExpectation.h>

@interface SKIntExpectation : SKExpectation

@property (readwrite, assign) long long number;

- (SKIntExpectation*(^)(long long)) withInt;

- (void) toBe:(long long)other;
- (void) toBeTrue;
- (void) toBeFalse;
- (void) toNotBeFalse;

@end

#define ExpectInt [[SKIntExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:self] withInt]
#define ExpectBool [[SKIntExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:self] withInt]
