#import "SpecKit.h"

SpecKitContext(___FILEBASENAMEASIDENTIFIER___) {
  
  describe(@"-someMethod", ^{
    
    it(@"fails", ^{
      [expectBool(NO) toBeTrue];
    });
    
  });
  
}
