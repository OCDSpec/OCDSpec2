#import <Foundation/Foundation.h>

#import <SpecKit/SKExpectation.h>

@interface SKIntExpectation : SKExpectation

@property (readwrite, assign) long long number;

- (SKIntExpectation*(^)(long long)) withInt;

- (void) toBe:(long long)other;
- (void) toBeTrue;
- (void) toBeFalse;
- (void) toNotBeFalse;

@end

#define expectInt [[SKIntExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:self] withInt]
#define expectBool [[SKIntExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:self] withInt]
