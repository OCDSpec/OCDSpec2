#import "SKContext.h"
#import "SKDescription.h"
#import "SKExample.h"
#import <objc/runtime.h>

void SpecKitRunAllTests() {
  [SKContext runAllTestsUsingOutput:[NSFileHandle fileHandleWithStandardError]];
}

@implementation SKContext

@synthesize reportOutputFile;
@synthesize descriptions;

- (void) dealloc {
  self.reportOutputFile = nil;
  self.descriptions = nil;
  
  [super dealloc];
}

+ (void) runAllTestsUsingOutput:(NSFileHandle*)outputFile {
  for (Class contextClass in [self contextClasses]) {
    SKContext *ctx = [[[contextClass alloc] init] autorelease];
    ctx.reportOutputFile = outputFile;
    
    [ctx gatherExamples];
    [ctx runAllExamples];
  }
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
  
  return testClasses;
}

- (void(^)(NSString*, void(^)(void))) _functionForDescribeBlock {
  return [[^(NSString* name, void(^blk)(void)) {
    SKDescription *desc = [[[SKDescription alloc] init] autorelease];
    desc.name = name;
    self.descriptions = [[NSArray arrayWithArray:self.descriptions] arrayByAddingObject:desc];
    
    blk();
  } copy] autorelease];
}

- (void(^)(NSString*, void(^)(void))) _functionForExampleBlock {
  return [[^(NSString* name, void(^blk)(void)) {
    SKDescription *desc = [self.descriptions lastObject];
    
    SKExample *ex = [[[SKExample alloc] init] autorelease];
    ex.name = name;
    ex.block = blk;
    desc.examples = [[NSArray arrayWithArray:desc.examples] arrayByAddingObject:ex];
  } copy] autorelease];
}

- (void(^)(void(^)(void))) _functionForBeforeEachBlock {
  return [[^(void(^blk)(void)) {
    SKDescription *desc = [self.descriptions lastObject];
    desc.beforeEachBlock = blk;
  } copy] autorelease];
}

- (void(^)(void(^)(void))) _functionForAfterEachBlock {
  return [[^(void(^blk)(void)) {
    SKDescription *desc = [self.descriptions lastObject];
    desc.afterEachBlock = blk;
  } copy] autorelease];
}

- (void) reportFailure:(NSString*)msg inFile:(NSString*)file atLine:(int)line {
  NSString *decoratedMessage = [NSString stringWithFormat:@"%@:%d: error: %@\n", file, line, msg];
  [self.reportOutputFile writeData:[decoratedMessage dataUsingEncoding:NSUTF8StringEncoding]];
}

- (void) gatherExamples {
  // overridden
}

- (void) runAllExamples {
  for (SKDescription *desc in self.descriptions) {
    for (SKExample *example in desc.examples) {
      if (desc.beforeEachBlock)
        desc.beforeEachBlock();
      
      example.block();
      
      if (desc.afterEachBlock)
        desc.afterEachBlock();
    }
  }
}

@end
