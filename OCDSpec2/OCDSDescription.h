#import <Foundation/Foundation.h>

@interface OCDSDescription : NSObject

@property (readwrite, retain) NSArray *subDescriptions;
@property (readwrite, retain) NSString* name;
@property (readwrite, retain) NSArray *examples;

@property (readwrite, copy) void (^beforeEachBlock)(void);
@property (readwrite, copy) void (^afterEachBlock)(void);

- (void) runAllExamplesWithBeforeBlocks:(NSArray*)beforeBlocks afterBlocks:(NSArray*)afterBlocks;

@end
