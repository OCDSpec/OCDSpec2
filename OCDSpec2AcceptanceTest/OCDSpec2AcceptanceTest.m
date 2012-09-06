#import <SenTestingKit/SenTestingKit.h>
#import <libgen.h>

#import <OCDSpec2/OCDSpec2.h>

extern int SamplePreludeRunCount;

@interface OCDSpec2AcceptanceTest : SenTestCase
@end

@implementation OCDSpec2AcceptanceTest

- (void)testExample {
  NSPipe *pipe = [NSPipe pipe];
  
  [OCDSContext runAllTestsUsingOutput:[pipe fileHandleForWriting]];
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
  
  [expectedOutput appendFormat:@"%@:63: error: Want 3.14, got 3\n", file];
  
  [expectedOutput appendFormat:@"%@:86: error: Want beforetest, got test\n", file];
  [expectedOutput appendFormat:@"%@:101: error: Want wrongvalue, got beforetest\n", file];
  [expectedOutput appendFormat:@"%@:107: error: Want wrongvalue, got before\n", file];
  
  [expectedOutput appendFormat:@"%@:116: error: Want false, got true\n", file];
  
  [expectedOutput appendFormat:@"%@:124: error: Want (\n", file];
  [expectedOutput appendFormat:@"%@:125: error:     b\n", file];
  [expectedOutput appendFormat:@"%@:126: error: ), got (\n", file];
  [expectedOutput appendFormat:@"%@:127: error:     a\n", file];
  [expectedOutput appendFormat:@"%@:128: error: )\n", file];
  
  [expectedOutput appendFormat:@"%@:132: error: Want no exception, but got one anyway: NSInternalInconsistencyException: aww\n", file];
  [expectedOutput appendFormat:@"%@:141: error: Want no exception, but got one anyway: NSInternalInconsistencyException: AWW!\n", file];
  
  [expectedOutput appendFormat:@"%@:150: warning: Pending\n", file];
  [expectedOutput appendFormat:@"%@:151: warning: Pending: dunno\n", file];
  
  [expectedOutput appendFormat:@"FAIL: 23 errors\n"];
  
  STAssertEquals(SamplePreludeRunCount, 1, nil);
  STAssertEqualObjects(expectedOutput, stderrOutput, nil);
}

@end
