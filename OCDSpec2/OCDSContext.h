#import <Foundation/Foundation.h>

#import <OCDSpec2/OCDSFailureReporter.h>
#import <OCDSpec2/OCDSDescription.h>

int OCDSpec2RunAllTests();

@interface OCDSContext : NSObject <OCDSFailureReporter>

@property (readwrite, retain) OCDSDescription *topLevelDescription;
@property (readwrite, assign) OCDSDescription *currentDescription;

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

#define OCDSpec2Context(classname) void OCDSContextRunFor##classname(OCDSContext* self); @interface OCDSContext##classname : OCDSContext; @end; @implementation OCDSContext##classname; - (void) gatherExamples { OCDSContextRunFor##classname(self); }; @end; void OCDSContextRunFor##classname(OCDSContext* self)

#define Describe [self _functionForDescribeBlock]
#define It [self _functionForExampleBlockInFile:__FILE__ atLine:__LINE__]

#define BeforeEach [self _functionForBeforeEachBlock]
#define AfterEach [self _functionForAfterEachBlock]
