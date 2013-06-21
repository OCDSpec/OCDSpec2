#import <SenTestingKit/SenTestingKit.h>

#import "OCDSContext.h"

@interface TestReportingErrors : SenTestCase
@end
@implementation TestReportingErrors

- (void) testReportingToOutputFile {
  NSPipe *pipe = [NSPipe pipe];
  
  OCDSContext *context = [[[OCDSContext alloc] init] autorelease];
  context.reportOutputFile = [pipe fileHandleForWriting];
  [context reportFailure:@"this is\n a test!" inFile:@"file1" atLine:73];
  
  [[pipe fileHandleForWriting] closeFile];
  
  NSFileHandle *handle = [pipe fileHandleForReading];
  NSString *str = [[[NSString alloc] initWithData:[handle readDataToEndOfFile]
                                         encoding:NSUTF8StringEncoding] autorelease];
  
  STAssertTrue([str isEqualToString: @"file1:73: error: this is\n a test!\n"], nil);
}

- (void) testKeepingErrorCount {
  OCDSContext *context = [[[OCDSContext alloc] init] autorelease];
  
  NSPipe *pipe = [NSPipe pipe];
  context.reportOutputFile = [pipe fileHandleForWriting];
  
  STAssertTrue(context.errorCount == 0, nil);
  
  [context reportFailure:@"this" inFile:@"that" atLine:23];
  STAssertTrue(context.errorCount == 1, nil);
  
  [context reportFailure:@"another error" inFile:@"somefile" atLine:45];
  STAssertTrue(context.errorCount == 2, nil);
}

@end
