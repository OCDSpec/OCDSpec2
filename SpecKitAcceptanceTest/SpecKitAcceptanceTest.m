#import <SenTestingKit/SenTestingKit.h>
#import <libgen.h>

#import <SpecKit/SpecKit.h>

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
  
  [expectedOutput appendFormat:@"%@:8: error: Want A, got a\n", file];
  [expectedOutput appendFormat:@"%@:9: error: Want B, got b\n", file];
  [expectedOutput appendFormat:@"%@:11: error: Want false, got true\n", file];
  [expectedOutput appendFormat:@"%@:12: error: Want 4, got 3\n", file];
  [expectedOutput appendFormat:@"%@:14: error: Want 2, got 1.23\n", file];
  [expectedOutput appendFormat:@"%@:16: error: Want \"*stop*\", got \"good morning\"\n", file];
  [expectedOutput appendFormat:@"%@:17: error: Want \"stop*\", got \"good morning\"\n", file];
  [expectedOutput appendFormat:@"%@:19: error: Want array (\n", file];
  [expectedOutput appendFormat:@"%@:20: error:     hi\n", file];
  [expectedOutput appendFormat:@"%@:21: error: ) to contain hello\n", file];
  
  [expectedOutput appendFormat:@"%@:49: error: Want false, got true\n", file];
  
//  [expectedOutput appendFormat:@"%@:68: error: Want beforetest, got test\n", file];
//  [expectedOutput appendFormat:@"%@:81: error: Want wrongvalue, got beforetest\n", file];
//  [expectedOutput appendFormat:@"%@:85: error: Want wrongvalue, got before\n", file];
  
//  NSLog(@"IT IS THIS %@", stderrOutput);
  
  STAssertEqualObjects(expectedOutput, stderrOutput, nil);
}

@end
