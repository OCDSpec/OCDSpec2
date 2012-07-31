#import <Foundation/Foundation.h>

#import <SpecKit/SKExpectation.h>

@interface SKStringExpectation : SKExpectation

@property (readwrite, assign) NSString* string;

- (SKStringExpectation*(^)(NSString*)) withString;

- (void) toContain:(NSString*)substring;
- (void) toStartWith:(NSString*)substring;

@end

#define ExpectStr [[SKStringExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:self] withString]
