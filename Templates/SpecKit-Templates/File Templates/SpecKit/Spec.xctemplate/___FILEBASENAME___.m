#import <SpecKit/SpecKit.h>

SpecKitContext(___FILEBASENAMEASIDENTIFIER___) {
  
  Describe(@"-someMethod", ^{
    
    It(@"fails", ^{
      [ExpectBool(NO) toBeTrue];
    });
    
  });
  
}
