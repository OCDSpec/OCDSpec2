#import <Foundation/Foundation.h>

#import <SpecKit/SKFailureReporter.h>
#import <SpecKit/SKDescription.h>

int SpecKitRunAllTests();

@interface SKContext : NSObject <SKFailureReporter>

@property (readwrite, retain) SKDescription *topLevelDescription;
@property (readwrite, assign) SKDescription *currentDescription;

@property (readwrite, retain) NSFileHandle *reportOutputFile;
@property (readwrite, assign) int errorCount;

+ (int) runAllTestsUsingOutput:(NSFileHandle*)outputFile;
+ (NSArray*) contextClasses;
+ (NSArray*) preludeClasses;

- (void(^)(NSString*, void(^)(void))) _functionForDescribeBlock;
- (void(^)(NSString*, void(^)(void))) _functionForExampleBlockInFile:(char*)inFile atLine:(int)atLine;

- (void(^)(void(^)(void))) _functionForBeforeEachBlock;
- (void(^)(void(^)(void))) _functionForAfterEachBlock;

- (void) gatherExamples;
- (void) runAllExamples;

@end

#define SpecKitContext(classname) void SKContextRunFor##classname(SKContext* self); @interface SKContext##classname : SKContext; @end; @implementation SKContext##classname; - (void) gatherExamples { SKContextRunFor##classname(self); }; @end; void SKContextRunFor##classname(SKContext* self)

#define Describe [self _functionForDescribeBlock]
#define It [self _functionForExampleBlockInFile:__FILE__ atLine:__LINE__]

#define BeforeEach [self _functionForBeforeEachBlock]
#define AfterEach [self _functionForAfterEachBlock]
