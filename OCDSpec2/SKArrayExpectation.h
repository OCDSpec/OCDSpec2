#import <Foundation/Foundation.h>

#import <OCDSpec2/SKExpectation.h>

@interface SKArrayExpectation : SKExpectation

@property (readwrite, assign) NSArray* array;

- (SKArrayExpectation*(^)(NSArray*)) withArray;

- (void) toContain:(id)obj;

@end

#define ExpectArray [[SKArrayExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:self] withArray]
