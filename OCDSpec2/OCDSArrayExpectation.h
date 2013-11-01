#import <Foundation/Foundation.h>

#import <OCDSpec2/OCDSObjectExpectation.h>

@interface OCDSArrayExpectation : OCDSObjectExpectation

- (OCDSArrayExpectation*(^)(NSArray*)) withArray;

- (void) toContain:(id)obj;
- (void) toHaveCount:(int)count;
- (void) toBeEmpty;

@end

#define ExpectArray [[OCDSArrayExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:self] withArray]
