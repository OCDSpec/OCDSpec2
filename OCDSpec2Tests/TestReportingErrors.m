#import <SenTestingKit/SenTestingKit.h>

#import "SKContext.h"

@interface TestReportingErrors : SenTestCase
@end
@implementation TestReportingErrors

- (void) testReportingToOutputFile {
  NSPipe *pipe = [NSPipe pipe];
  
  SKContext *ctx = [[[SKContext alloc] init] autorelease];
  ctx.reportOutputFile = [pipe fileHandleForWriting];
  [ctx reportFailure:@"this is\n a test!" inFile:@"file1" atLine:73];
  
  [[pipe fileHandleForWriting] closeFile];
  
  NSFileHandle *handle = [pipe fileHandleForReading];
  NSString *str = [[[NSString alloc] initWithData:[handle readDataToEndOfFile]
                                         encoding:NSUTF8StringEncoding] autorelease];
  
  STAssertTrue([str isEqualToString: @"file1:73: error: this is\n a test!\n"], nil);
}

- (void) testKeepingErrorCount {
  SKContext *ctx = [[[SKContext alloc] init] autorelease];
  
  NSPipe *pipe = [NSPipe pipe];
  ctx.reportOutputFile = [pipe fileHandleForWriting];
  
  STAssertTrue(ctx.errorCount == 0, nil);
  
  [ctx reportFailure:@"this" inFile:@"that" atLine:23];
  STAssertTrue(ctx.errorCount == 1, nil);
  
  [ctx reportFailure:@"another error" inFile:@"somefile" atLine:45];
  STAssertTrue(ctx.errorCount == 2, nil);
}

@end
