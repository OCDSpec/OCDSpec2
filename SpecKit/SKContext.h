#import <Foundation/Foundation.h>

#import "SKFailureReporter.h"

int SpecKitRunAllTests();

@interface SKContext : NSObject <SKFailureReporter>

@property (readwrite, retain) NSFileHandle *reportOutputFile;
@property (readwrite, retain) NSArray *descriptions;
@property (readwrite, assign) int errorCount;

+ (int) runAllTestsUsingOutput:(NSFileHandle*)outputFile;
+ (NSArray*) contextClasses;

- (void(^)(NSString*, void(^)(void))) _functionForDescribeBlock;
- (void(^)(NSString*, void(^)(void))) _functionForExampleBlock;

- (void(^)(void(^)(void))) _functionForBeforeEachBlock;
- (void(^)(void(^)(void))) _functionForAfterEachBlock;

- (void) gatherExamples;
- (void) runAllExamples;

@end

#define SpecKitContext(classname) void SKContextRunFor##classname(SKContext* self); @interface SKContext##classname : SKContext; @end; @implementation SKContext##classname; - (void) gatherExamples { SKContextRunFor##classname(self); }; @end; void SKContextRunFor##classname(SKContext* self)

#define describe [self _functionForDescribeBlock]
#define it [self _functionForExampleBlock]

#define beforeEach [self _functionForBeforeEachBlock]
#define afterEach [self _functionForAfterEachBlock]
