#import <SpecKit/SpecKit.h>

int SamplePreludeRunCount;

SpecKitContext(AcceptanceTest1) {
  
  describe(@"failures", ^{
    
    it(@"is so very cool", ^{
      [expectInt(SamplePreludeRunCount) toBe: 1];
      
      [expect(@"a") toBeEqualTo: @"A"];
      [expect(@"b") toBe: @"B"];
      
      [expectBool(YES) toBeFalse];
      [expectInt(3) toBe: 4];
      
      [expectFloat(1.23) toBe:2 withPrecision:0.00001];
      
      [expectStr(@"good morning") toContain: @"stop"];
      [expectStr(@"good morning") toStartWith: @"stop"];
      
      [expectArray([NSArray arrayWithObject:@"hi"]) toContain: @"hello"];
    });
    
  });
  
  describe(@"successes", ^{
    
    it(@"doesnt show up as errors", ^{
      [expectInt(SamplePreludeRunCount) toBe: 1];
      
      [expect(@"a") toBeEqualTo: @"a"];
      [expect(@"b") toBe: @"b"];
      
      [expectBool(YES) toBeTrue];
      [expectInt(3) toBe: 3];
      
      [expectFloat(1.23) toBe:1.23 withPrecision:0.00001];
      
      [expectStr(@"good morning") toContain: @"go"];
      [expectStr(@"good morning") toStartWith: @"go"];
      
      [expectArray([NSArray arrayWithObject:@"hi"]) toContain: @"hi"];
    });
    
  });
}

SpecKitContext(AcceptanceTest2) {
  
  describe(@"multiple contexts", ^{
    
    it(@"sees them all", ^{
      [expectInt(SamplePreludeRunCount) toBe: 1];
      
      [expectBool(YES) toBeFalse];
    });
    
  });
  
}

SpecKitContext(AcceptanceTest3) {
  
  __block NSMutableString* mutableString;
  
  beforeEach(^{
    mutableString = [NSMutableString string];
  });
  
  describe(@"failures", ^{
    
    it(@"does before-each before each example", ^{
      [expectInt(SamplePreludeRunCount) toBe: 1];
      
      [mutableString appendString:@"test"];
//      [expect(mutableString) toBeEqualTo: @"beforetest"];
    });
    
  });
  
  describe(@"successes", ^{
    
    beforeEach(^{
      [mutableString appendString:@"before"];
    });
    
    it(@"does before-each before each example", ^{
      [expectInt(SamplePreludeRunCount) toBe: 1];
      
      [mutableString appendString:@"test"];
//      [expect(mutableString) toBeEqualTo: @"wrongvalue"];
    });

    it(@"does before-each before each example", ^{
      [expectInt(SamplePreludeRunCount) toBe: 1];
      
//      [expect(mutableString) toBeEqualTo: @"wrongvalue"];
    });
    
  });
}

@interface SamplePrelude : NSObject <SKPrelude>
@end

@implementation SamplePrelude

- (void) run {
  SamplePreludeRunCount++;
}

@end
