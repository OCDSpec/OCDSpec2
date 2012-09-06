#import <Foundation/Foundation.h>

#import <OCDSpec2/OCDSExpectation.h>

@interface OCDSStringExpectation : OCDSExpectation

@property (readwrite, assign) NSString* string;

- (OCDSStringExpectation*(^)(NSString*)) withString;

- (void) toContain:(NSString*)substring;
- (void) toStartWith:(NSString*)substring;

@end

#define ExpectStr [[OCDSStringExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:self] withString]
