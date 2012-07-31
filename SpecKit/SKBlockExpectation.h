#import <Foundation/Foundation.h>

#import <SpecKit/SKExpectation.h>

@interface SKBlockExpectation : SKExpectation

@property (readwrite, assign) void(^block)(void);

- (SKBlockExpectation*(^)(void(^)(void))) withBlock;

- (void) toNotRaiseException;

@end

#define expectBlock [[SKBlockExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:self] withBlock]
