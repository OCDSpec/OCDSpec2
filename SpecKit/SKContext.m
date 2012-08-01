#import "SKContext.h"
#import "SKDescription.h"
#import "SKExample.h"
#import "SKPrelude.h"
#import <objc/runtime.h>

#import "SKBlockExpectation.h"

int SpecKitRunAllTests() {
  return [SKContext runAllTestsUsingOutput:[NSFileHandle fileHandleWithStandardError]];
}

@implementation SKContext

- (void) dealloc {
  self.reportOutputFile = nil;
  self.topLevelDescription = nil;
  
  [super dealloc];
}

+ (int) runAllTestsUsingOutput:(NSFileHandle*)outputFile {
  int errorCount = 0;
  
  for (Class runnerClass in [self preludeClasses]) {
    id<SKPrelude> runner = [[[runnerClass alloc] init] autorelease];
    [runner run];
  }
  
  for (Class contextClass in [self contextClasses]) {
    SKContext *ctx = [[[contextClass alloc] init] autorelease];
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
    
    if (class_getSuperclass(class) == [SKContext self]) {
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
    
    if (class_conformsToProtocol(class, @protocol(SKPrelude))) {
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
    self.topLevelDescription = [[[SKDescription alloc] init] autorelease];
    self.topLevelDescription.name = @"Top level";
    
    self.currentDescription = self.topLevelDescription;
  }
  return self;
}

- (void(^)(NSString*, void(^)(void))) _functionForDescribeBlock {
  return [[^(NSString* name, void(^blk)(void)) {
    SKDescription *desc = [[[SKDescription alloc] init] autorelease];
    desc.name = name;
    self.currentDescription.subDescriptions = [[NSArray arrayWithArray:self.currentDescription.subDescriptions] arrayByAddingObject:desc];
    
    self.currentDescription = desc;
    
    blk();
  } copy] autorelease];
}

- (void(^)(NSString*, void(^)(void))) _functionForExampleBlockInFile:(char*)inFile atLine:(int)atLine {
  return [[^(NSString* name, void(^blk)(void)) {
    SKExample *ex = [[[SKExample alloc] init] autorelease];
    ex.name = name;
    ex.block = ^{
      [[[SKBlockExpectation expectationInFile:inFile
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

- (void) gatherExamples {
  // overridden
}

- (void) runAllExamples {
  [self.topLevelDescription runAllExamplesWithBeforeBlocks:@[] afterBlocks:@[]];
}

@end
