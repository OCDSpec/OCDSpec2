#import <SpecKit/SpecKit.h>

int SamplePreludeRunCount;

SpecKitContext(AcceptanceTest1) {
  
  Describe(@"failures", ^{
    
    It(@"is so very cool", ^{
      [ExpectInt(SamplePreludeRunCount) toBe: 1];
      
      [ExpectObj(@"a") toBeEqualTo: @"A"];
      [ExpectObj(@"b") toBe: @"B"];
      
      [ExpectBool(YES) toBeFalse];
      [ExpectInt(3) toBe: 4];
      
      [ExpectFloat(1.23) toBe:2 withPrecision:0.00001];
      
      [ExpectStr(@"good morning") toContain: @"stop"];
      [ExpectStr(@"good morning") toStartWith: @"stop"];
      
      [ExpectArray([NSArray arrayWithObject:@"hi"]) toContain: @"hello"];
    });
    
  });
  
  Describe(@"successes", ^{
    
    It(@"doesnt show up as errors", ^{
      [ExpectInt(SamplePreludeRunCount) toBe: 1];
      
      [ExpectObj(@"a") toBeEqualTo: @"a"];
      [ExpectObj(@"b") toBe: @"b"];
      
      [ExpectBool(YES) toBeTrue];
      [ExpectInt(3) toBe: 3];
      
      [ExpectFloat(1.23) toBe:1.23 withPrecision:0.00001];
      
      [ExpectStr(@"good morning") toContain: @"go"];
      [ExpectStr(@"good morning") toStartWith: @"go"];
      
      [ExpectArray([NSArray arrayWithObject:@"hi"]) toContain: @"hi"];
    });
    
  });
}

SpecKitContext(AcceptanceTest2) {
  
  Describe(@"multiple contexts", ^{
    
    It(@"sees them all", ^{
      [ExpectInt(SamplePreludeRunCount) toBe: 1];
      
      [ExpectBool(YES) toBeFalse];
    });
    
    Describe(@"nested describes", ^{
      
      It(@"knows what you mean", ^{
        [ExpectFloat(3.0) toBe: 3.14 withPrecision:0.0001];
      });
      
    });
    
  });
  
}

SpecKitContext(AcceptanceTest3) {
  
  __block NSMutableString* mutableString;
  
  BeforeEach(^{
    mutableString = [NSMutableString string];
  });
  
  Describe(@"failures", ^{
    
    It(@"does before-each before each example", ^{
      [ExpectInt(SamplePreludeRunCount) toBe: 1];
      
      [mutableString appendString:@"test"];
      [ExpectObj(mutableString) toBeEqualTo: @"beforetest"];
    });
    
  });
  
  Describe(@"successes", ^{
    
    BeforeEach(^{
      [mutableString appendString:@"before"];
    });
    
    It(@"does before-each before each example", ^{
      [ExpectInt(SamplePreludeRunCount) toBe: 1];
      
      [mutableString appendString:@"test"];
      [ExpectObj(mutableString) toBeEqualTo: @"wrongvalue"];
    });

    It(@"does before-each before each example", ^{
      [ExpectInt(SamplePreludeRunCount) toBe: 1];
      
      [ExpectObj(mutableString) toBeEqualTo: @"wrongvalue"];
    });
    
  });
}

SpecKitContext(AcceptanceTest4) {
  
  It(@"allows top-level examples", ^{
    [ExpectBool(YES) toBeFalse];
  });
  
}

SpecKitContext(AcceptanceTest5) {
  
  It(@"shows multi-line errors on multiple lines", ^{
    [ExpectObj([NSArray arrayWithObject:@"a"]) toBeEqualTo: [NSArray arrayWithObject:@"b"]];
  });
  
}

SpecKitContext(AcceptanceTest6) {
  
  It(@"catches exceptions and reports that they do in fact suck", ^{
    [ExpectBlock(^{
      [NSException raise:NSInternalInconsistencyException format:@"aww"];
    }) toNotRaiseException];
  });
  
}

SpecKitContext(AcceptanceTest7) {
  
  It(@"catches exceptions implicitly and reports that they do in fact suck", ^{
    [NSException raise:NSInternalInconsistencyException format:@"AWW!"];
  });
  
}

@interface SamplePrelude : NSObject <SKPrelude>
@end

@implementation SamplePrelude

- (void) run {
  SamplePreludeRunCount++;
}

@end
