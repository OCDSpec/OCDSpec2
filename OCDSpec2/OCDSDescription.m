#import "OCDSDescription.h"
#import "OCDSExample.h"
#import "OCDSLog.h"

@implementation OCDSDescription

-(id) init {
  return [self initWithLogger:[OCDSLog new]];
}

-(id) initWithLogger:(NSObject<OCDSLogger> *)logger {
  self = [super init];
  if (self) {
    self.logger = logger;
  }
  return self;
}

-(void) runAll {
  [self runAllExamplesWithBeforeBlocks:@[] afterBlocks:@[]];
}

-(void) runAllExamplesWithBeforeBlocks:(NSArray *)beforeBlocks afterBlocks:(NSArray *)afterBlocks {
  if (self.beforeEachBlock)
    beforeBlocks = [beforeBlocks arrayByAddingObject:self.beforeEachBlock];
  
  if (self.afterEachBlock)
    afterBlocks = [afterBlocks arrayByAddingObject:self.afterEachBlock];
  
  for (OCDSExample* example in self.examples) {
    for (void(^beforeBlock)(void) in beforeBlocks) {
      beforeBlock();
    }
    
    [self.logger log:([self logMessage:example.name])];
    example.block();
    
    for (void(^afterBlock)(void) in afterBlocks) {
      afterBlock();
    }
  }
  
  for (OCDSDescription* desc in self.subDescriptions) {
    [desc runAllExamplesWithBeforeBlocks:beforeBlocks afterBlocks:afterBlocks];
  }
}

-(NSString *) logMessage:(NSString *)exampleName {
  return [NSString stringWithFormat:@"Running %@: %@", self.name, exampleName];
}

@end
