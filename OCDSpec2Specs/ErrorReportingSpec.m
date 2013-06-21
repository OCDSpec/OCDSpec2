#import <OCDSpec2/OCDSpec2.h>

OCDSpec2Context(ErrorReportingSpec) {
  
  Describe(@"-someBehavior", ^{

    It(@"reports to an output file", ^{
      NSPipe *pipe = [NSPipe pipe];
      
      OCDSContext *context = [[[OCDSContext alloc] init] autorelease];
      context.reportOutputFile = [pipe fileHandleForWriting];
      [context reportFailure:@"this is\n a test!" inFile:@"file1" atLine:73];
      
      [[pipe fileHandleForWriting] closeFile];
      
      NSFileHandle *handle = [pipe fileHandleForReading];
      NSString *str = [[[NSString alloc] initWithData:[handle readDataToEndOfFile]
                                             encoding:NSUTF8StringEncoding] autorelease];
  
      [ExpectObj(str) toBeEqualTo: @"file1:73: error: this is\n a test!\n"];
    });
    
    It(@"keeps the error count", ^{
      OCDSContext *context = [[[OCDSContext alloc] init] autorelease];
      
      NSPipe *pipe = [NSPipe pipe];
      context.reportOutputFile = [pipe fileHandleForWriting];
      
      [ExpectInt(context.errorCount) toBe:0];
      
      [context reportFailure:@"this" inFile:@"that" atLine:23];
      [ExpectInt(context.errorCount) toBe:1];
      
      [context reportFailure:@"another error" inFile:@"somefile" atLine:45];
      [ExpectInt(context.errorCount) toBe:2];
    });
    
  });
  
}
