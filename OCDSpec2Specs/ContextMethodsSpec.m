#import <OCDSpec2/OCDSpec2.h>


@interface SampleBeforeAll : NSObject<OCDSPrelude>
@end

@implementation SampleBeforeAll

- (void) run {
}

@end

OCDSpec2Context(Sample1) {
}

OCDSpec2Context(Sample2) {
}


OCDSpec2Context(ContextMethodsSpec) {
  
  Describe(@"Gathering Sample1 and Sample2 contexts", ^{
    
    It(@"adds both sample contexts to the list of all context classes", ^{
      NSArray *contextClasses = [OCDSContext contextClasses];
      
      [ExpectArray(contextClasses) toContain: [OCDSContextSample1 self]];
      [ExpectArray(contextClasses) toContain: [OCDSContextSample2 self]];
    });
    
    It(@"adds SampleBeforeAll the the list of prelude classes", ^{
      NSArray *runnerClasses = [OCDSContext preludeClasses];

      [ExpectArray(runnerClasses) toContain: [SampleBeforeAll self]];
    });
    
  });
  
}
