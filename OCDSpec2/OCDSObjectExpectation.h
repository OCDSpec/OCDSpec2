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

#define ExpectObj [[OCDSObjectExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:self] withObject]

#define Pending() [[OCDSObjectExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:self] pending]
#define PendingStr [[OCDSObjectExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:self] pendingWithString]
