#import <Foundation/Foundation.h>

#import <OCDSpec2/OCDSExpectation.h>

@interface OCDSIntExpectation : OCDSExpectation

@property (readwrite, assign) long long number;

- (OCDSIntExpectation*(^)(long long)) withInt;

- (void) toBe:(long long)other;
- (void) toBeTrue;
- (void) toBeFalse;
- (void) toNotBeFalse;

@end

#define ExpectInt [[OCDSIntExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:Reporter] withInt]
#define ExpectBool [[OCDSIntExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:Reporter] withInt]
#define ExpectTrue(num) [[[OCDSIntExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:Reporter] withInt](num) toBeTrue];
#define ExpectFalse(num) [[[OCDSIntExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:Reporter] withInt](num) toBeFalse];
