#import "SKArrayExpectation.h"

@implementation SKArrayExpectation

- (SKArrayExpectation*(^)(NSArray*)) withArray {
  return [[^SKArrayExpectation*(NSArray *a){
    self.array = a;
    return self;
  } copy] autorelease];
}

- (void) toContain:(id)obj {
  if (![self.array containsObject: obj]) {
    NSString *rawLine = [NSString stringWithFormat:@"Want array %@ to contain %@",
                         self.array,
                         obj];
    
    int i = 0;
    for (NSString *rawStringLine in [rawLine componentsSeparatedByString:@"\n"]) {
      [self.failureReporter reportFailure:rawStringLine
                                   inFile:self.file
                                   atLine:self.line + i];
      i++;
    }
  }
}

@end
