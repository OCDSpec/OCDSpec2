#import <SenTestingKit/SenTestingKit.h>
#import <libgen.h>

#import <SpecKit/SpecKit.h>

extern int SamplePreludeRunCount;

@interface SpecKitAcceptanceTest : SenTestCase
@end

@implementation SpecKitAcceptanceTest

- (void)testExample {
  NSPipe *pipe = [NSPipe pipe];
  
  [SKContext runAllTestsUsingOutput:[pipe fileHandleForWriting]];
  [[pipe fileHandleForWriting] closeFile];
  
  NSData *stderrData = [[pipe fileHandleForReading] readDataToEndOfFile];
  NSString *stderrOutput = [[[NSString alloc] initWithData:stderrData encoding:NSUTF8StringEncoding] autorelease];
  
  NSString *file = [NSString stringWithFormat:@"%s/AcceptanceTestSpec.m", dirname(__FILE__)];
  
  NSMutableString *expectedOutput = [NSMutableString string];
  
  [expectedOutput appendFormat:@"%@:12: error: Want A, got a\n", file];
  [expectedOutput appendFormat:@"%@:13: error: Want B, got b\n", file];
  [expectedOutput appendFormat:@"%@:15: error: Want false, got true\n", file];
  [expectedOutput appendFormat:@"%@:16: error: Want 4, got 3\n", file];
  [expectedOutput appendFormat:@"%@:18: error: Want 2, got 1.23\n", file];
  [expectedOutput appendFormat:@"%@:20: error: Want \"*stop*\", got \"good morning\"\n", file];
  [expectedOutput appendFormat:@"%@:21: error: Want \"stop*\", got \"good morning\"\n", file];
  [expectedOutput appendFormat:@"%@:23: error: Want array (\n", file];
  [expectedOutput appendFormat:@"%@:24: error:     hi\n", file];
  [expectedOutput appendFormat:@"%@:25: error: ) to contain hello\n", file];
  
  [expectedOutput appendFormat:@"%@:57: error: Want false, got true\n", file];
  
  [expectedOutput appendFormat:@"%@:78: error: Want beforetest, got test\n", file];
  [expectedOutput appendFormat:@"%@:93: error: Want wrongvalue, got beforetest\n", file];
  [expectedOutput appendFormat:@"%@:99: error: Want wrongvalue, got before\n", file];
  [expectedOutput appendFormat:@"%@:108: error: Want false, got true\n", file];
  
  STAssertEquals(SamplePreludeRunCount, 1, nil);
  STAssertEqualObjects(expectedOutput, stderrOutput, nil);
}

@end
