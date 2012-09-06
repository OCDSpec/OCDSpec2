#import <OCDSpec2/OCDSpec2.h>

OCDSpec2Context(___FILEBASENAMEASIDENTIFIER___) {
  
  Describe(@"-someMethod", ^{
    
    It(@"fails", ^{
      [ExpectBool(NO) toBeTrue];
    });
    
  });
  
}
