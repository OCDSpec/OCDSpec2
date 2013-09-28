#import <OCDSpec2/OCDSpec2.h>

OCDSpec2Context(___FILEBASENAMEASIDENTIFIER___) {
  
  Describe(@"-someBehavior", ^{
    
    It(@"fails", ^{
      [ExpectBool(NO) toBeTrue];
    });
    
  });
  
}
