#import <Foundation/Foundation.h>

#import <SpecKit/SKExpectation.h>

@interface SKObjectExpectation : SKExpectation

@property (readwrite, assign) id object;

- (SKObjectExpectation*(^)(id)) withObject;

- (void) toBe:(id)other;
- (void) toBeEqualTo:(id)other;
- (void) toExist;
- (void) toBeNil;
- (void) toBeMemberOfClass:(Class)cls;
- (void) toBeKindOfClass:(Class)cls;

@end

#define expect [[SKObjectExpectation expectationInFile:__FILE__ line:__LINE__ failureReporter:self] withObject]
