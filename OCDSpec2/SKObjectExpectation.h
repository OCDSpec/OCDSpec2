#import <Foundation/Foundation.h>

#import <OCDSpec2/SKExpectation.h>

@interface SKObjectExpectation : SKExpectation

@property (readwrite, assign) id object;

- (SKObjectExpectation*(^)(id)) withObject;

- (void) pending;
- (void(^)(NSString*))pendingWithString;

- (void) toBe:(id)other;
- (void) toBeEqualTo:(id)other;
- (void) toExist;
- (void) toBeNil;
- (void) toBeMemberOfClass:(Class)cls;
- (void) toBeKindOfClass:(Class)cls;

@end

#define ExpectObj [[SKObjectExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:self] withObject]

#define Pending() [[SKObjectExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:self] pending]
#define PendingStr [[SKObjectExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:self] pendingWithString]
