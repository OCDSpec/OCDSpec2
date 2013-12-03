#import <OCDSpec2/OCDSpec2.h>

#import "OCDSFakeFailureReporter.h"
#import "SpecExpectation.h"

#undef Reporter
#define Reporter reporter

OCDSpec2Context(ObjectExpectationSpec) {
  
  __block OCDSFakeFailureReporter *reporter;
  
  BeforeEach(^{
    reporter = [OCDSFakeFailureReporter new];
  });
  
  Describe(@"-toBeEqualTo", ^{
    
    It(@"passes when two objects are equal", ^{
      [ExpectObj(@"a") toBeEqualTo:@"a"];
      
      ExpectErrorCount(0);
    });
    
    It(@"fails when two objects are not equal", ^{
      [ExpectObj(@"a") toBeEqualTo:@"b"];
      
      ExpectLastErrorMessage(@"Want b, got a");
    });
    
  });
  
  Describe(@"-toBe", ^{
    
    It(@"passes when two objects are the same object", ^{
      id a = [NSObject new];
      
      [ExpectObj(a) toBe:a];
      
      ExpectErrorCount(0);
    });
    
    It(@"fails when two objects are not the same object", ^{
      id a = [NSMutableString stringWithString:@"a"];
      id b = [NSMutableString stringWithString:@"b"];
      
      [ExpectObj(a) toBe:b];
      
      ExpectLastErrorMessage(@"Want b, got a");
    });
    
  });
  
  Describe(@"-toExist", ^{
    
    It(@"passes when object is not nil", ^{
      [ExpectObj(@"a") toExist];
      
      ExpectErrorCount(0);
    });
    
    It(@"fails when object is nil", ^{
      [ExpectObj(nil) toExist];
      
      ExpectLastErrorMessage(@"Want real object, got nil");
    });
    
  });
  
  Describe(@"-toBeNil", ^{
    
    It(@"passes when object is nil", ^{
      [ExpectObj(nil) toBeNil];
      
      ExpectErrorCount(0);
    });
    
    It(@"fails when object is not nil", ^{
      [ExpectObj(@"a") toBeNil];
      
      ExpectLastErrorMessage(@"Want nil, got a");
    });
    
  });
  
  Describe(@"-toBeMemberOfClass", ^{
    
    It(@"passes when object is a member of the class", ^{
      [ExpectObj([NSNull null]) toBeMemberOfClass:[NSNull self]];
      
      ExpectErrorCount(0);
    });
    
    It(@"fails when object is not a member of the class", ^{
      [ExpectObj(@2) toBeMemberOfClass:[NSString self]];
      
      ExpectLastErrorMessage(@"Want NSString, got __NSCFNumber");
    });
    
    It(@"fails when object is a member of a subclass of desired class", ^{
      [ExpectObj(@"hi") toBeMemberOfClass:[NSString self]];
      
      ExpectLastErrorMessage(@"Want NSString, got __NSCFConstantString");
    });
    
  });
  
  Describe(@"-toBeKindOfClass", ^{
    
    It(@"passes when object's class is desired class", ^{
      [ExpectObj([NSNull null]) toBeKindOfClass:[NSNull self]];
      
      ExpectErrorCount(0);
    });
    
    It(@"passes when object's class is obvious subclass of desired class", ^{
      [ExpectObj([NSMutableString stringWithString:@"hello"]) toBeKindOfClass:[NSString self]];
      
      ExpectErrorCount(0);
    });
    
    It(@"passes when object's class is less obvious subclass of desired class", ^{
      [ExpectObj(@"hi") toBeKindOfClass:[NSString self]];
      
      ExpectErrorCount(0);
    });
    
    It(@"fails when object's class does not match desired class", ^{
      [ExpectObj(@2) toBeKindOfClass:[NSString self]];
      
      ExpectLastErrorMessage(@"Want NSString, got __NSCFNumber");
    });
    
  });
  
  Describe(@"-pending", ^{
    
    It(@"warns that the test is pending", ^{
      Pending();
      
      ExpectLastWarningMessage(@"Pending");
    });
    
    It(@"warns that the test is pending with a string", ^{
      PendingStr(@"todo = test me");
      
      ExpectLastWarningMessage(@"Pending: todo = test me");
    });
    
    It(@"stops executing when it encounters pending", ^{
      Pending();

      [NSException raise:@"Error" format:@""];
    });
    
    It(@"stops executing when it encounters pending with a string", ^{
      PendingStr(@"Pending");
      
      [NSException raise:@"Error" format:@""];
    });
    
  });
  
}
