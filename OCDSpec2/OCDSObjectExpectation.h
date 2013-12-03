#import <Foundation/Foundation.h>

#import <OCDSpec2/OCDSExpectation.h>

@interface OCDSObjectExpectation : OCDSExpectation

@property (readwrite, assign) id object;

- (OCDSObjectExpectation*(^)(id)) withObject;

- (void) pending;
- (void(^)(NSString*))pendingWithString;

- (void) toBe:(id)other;
- (void) toBeEqualTo:(id)other;
- (void) toExist;
- (void) toBeNil;
- (void) toBeMemberOfClass:(Class)cls;
- (void) toBeKindOfClass:(Class)cls;

@end

#define ExpectObj [[OCDSObjectExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:Reporter] withObject]

#define Pending() return [[OCDSObjectExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:Reporter] pending]
#define PendingStr return [[OCDSObjectExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:Reporter] pendingWithString]
