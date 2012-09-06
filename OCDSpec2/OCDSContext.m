#import "OCDSContext.h"
#import "OCDSDescription.h"
#import "OCDSExample.h"
#import "OCDSPrelude.h"
#import <objc/runtime.h>

#import "OCDSBlockExpectation.h"

int OCDSpec2RunAllTests() {
  return [OCDSContext runAllTestsUsingOutput:[NSFileHandle fileHandleWithStandardError]];
}

@implementation OCDSContext

- (void) dealloc {
  self.reportOutputFile = nil;
  self.topLevelDescription = nil;
  
  [super dealloc];
}

+ (int) runAllTestsUsingOutput:(NSFileHandle*)outputFile {
  int errorCount = 0;
  
  for (Class runnerClass in [self preludeClasses]) {
    id<OCDSPrelude> runner = [[[runnerClass alloc] init] autorelease];
    [runner run];
  }
  
  for (Class contextClass in [self contextClasses]) {
    OCDSContext *ctx = [[[contextClass alloc] init] autorelease];
    ctx.reportOutputFile = outputFile;
    
    [ctx gatherExamples];
    [ctx runAllExamples];
    
    errorCount += ctx.errorCount;
  }
  
  if (errorCount == 0) {
    NSString *decoratedMessage = [NSString stringWithFormat:@"PASS\n"];
    [outputFile writeData:[decoratedMessage dataUsingEncoding:NSUTF8StringEncoding]];
  }
  else {
    NSString *decoratedMessage = [NSString stringWithFormat:@"FAIL: %d errors\n", errorCount];
    [outputFile writeData:[decoratedMessage dataUsingEncoding:NSUTF8StringEncoding]];
  }
  
  return errorCount;
}

+ (NSArray*) contextClasses {
  int classCount = objc_getClassList(NULL, 0);
  Class classes[classCount];
  objc_getClassList(classes, classCount);
  
  NSMutableArray *testClasses = [NSMutableArray array];
  
  for (int i = 0; i < classCount; i++) {
    Class class = classes[i];
    
    if (class_getSuperclass(class) == [OCDSContext self]) {
      [testClasses addObject:class];
    }
  }
  
  [testClasses sortUsingComparator:^NSComparisonResult(Class c1, Class c2) {
    return [NSStringFromClass(c1) compare: NSStringFromClass(c2)];
  }];
  
  return testClasses;
}

+ (NSArray*) preludeClasses {
  int classCount = objc_getClassList(NULL, 0);
  Class classes[classCount];
  objc_getClassList(classes, classCount);
  
  NSMutableArray *preludeClasses = [NSMutableArray array];
  
  for (int i = 0; i < classCount; i++) {
    Class class = classes[i];
    
    if (class_conformsToProtocol(class, @protocol(OCDSPrelude))) {
      [preludeClasses addObject:class];
    }
  }
  
  [preludeClasses sortUsingComparator:^NSComparisonResult(Class c1, Class c2) {
    return [NSStringFromClass(c1) compare: NSStringFromClass(c2)];
  }];
  
  return preludeClasses;
}

- (id) init {
  if ((self = [super init])) {
    self.topLevelDescription = [[[OCDSDescription alloc] init] autorelease];
    self.topLevelDescription.name = @"Top level";
    
    self.currentDescription = self.topLevelDescription;
  }
  return self;
}

- (void(^)(NSString*, void(^)(void))) _functionForDescribeBlock {
  return [[^(NSString* name, void(^blk)(void)) {
    OCDSDescription *desc = [[[OCDSDescription alloc] init] autorelease];
    desc.name = name;
    self.currentDescription.subDescriptions = [[NSArray arrayWithArray:self.currentDescription.subDescriptions] arrayByAddingObject:desc];
    
    self.currentDescription = desc;
    
    blk();
  } copy] autorelease];
}

- (void(^)(NSString*, void(^)(void))) _functionForExampleBlockInFile:(char*)inFile atLine:(int)atLine {
  return [[^(NSString* name, void(^blk)(void)) {
    OCDSExample *ex = [[[OCDSExample alloc] init] autorelease];
    ex.name = name;
    ex.block = ^{
      [[[OCDSBlockExpectation expectationInFile:inFile
                                         line:atLine
                              failureReporter:self] withBlock](blk) toNotRaiseException];
    };
    self.currentDescription.examples = [[NSArray arrayWithArray:self.currentDescription.examples] arrayByAddingObject:ex];
  } copy] autorelease];
}

- (void(^)(void(^)(void))) _functionForBeforeEachBlock {
  return [[^(void(^blk)(void)) {
    self.currentDescription.beforeEachBlock = blk;
  } copy] autorelease];
}

- (void(^)(void(^)(void))) _functionForAfterEachBlock {
  return [[^(void(^blk)(void)) {
    self.currentDescription.afterEachBlock = blk;
  } copy] autorelease];
}

- (void) reportFailure:(NSString*)msg inFile:(NSString*)file atLine:(int)line {
  self.errorCount++;
  NSString *decoratedMessage = [NSString stringWithFormat:@"%@:%d: error: %@\n", file, line, msg];
  [self.reportOutputFile writeData:[decoratedMessage dataUsingEncoding:NSUTF8StringEncoding]];
}

- (void) reportWarning:(NSString*)msg inFile:(NSString*)file atLine:(int)line {
  NSString *decoratedMessage = [NSString stringWithFormat:@"%@:%d: warning: %@\n", file, line, msg];
  [self.reportOutputFile writeData:[decoratedMessage dataUsingEncoding:NSUTF8StringEncoding]];
}

- (void) gatherExamples {
  // overridden
}

- (void) runAllExamples {
  [self.topLevelDescription runAllExamplesWithBeforeBlocks:@[] afterBlocks:@[]];
}

@end
