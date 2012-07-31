#import <Foundation/Foundation.h>

#import <SpecKit/SKExpectation.h>

@interface SKArrayExpectation : SKExpectation

@property (readwrite, assign) NSArray* array;

- (SKArrayExpectation*(^)(NSArray*)) withArray;

- (void) toContain:(id)obj;

@end

#define ExpectArray [[SKArrayExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:self] withArray]
