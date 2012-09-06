#import <Foundation/Foundation.h>

#import <OCDSpec2/OCDSExpectation.h>

@interface OCDSArrayExpectation : OCDSExpectation

@property (readwrite, assign) NSArray* array;

- (OCDSArrayExpectation*(^)(NSArray*)) withArray;

- (void) toContain:(id)obj;

@end

#define ExpectArray [[OCDSArrayExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:self] withArray]
