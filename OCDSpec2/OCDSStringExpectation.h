#import <Foundation/Foundation.h>

#import <OCDSpec2/OCDSObjectExpectation.h>

@interface OCDSStringExpectation : OCDSObjectExpectation

- (OCDSStringExpectation*(^)(NSString*)) withString;

- (void) toContain:(NSString*)substring;
- (void) toStartWith:(NSString*)substring;

@end

#define ExpectStr [[OCDSStringExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:self] withString]
