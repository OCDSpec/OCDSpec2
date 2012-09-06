#import <Foundation/Foundation.h>

@protocol SKFailureReporter <NSObject>

- (void) reportFailure:(NSString*)msg inFile:(NSString*)file atLine:(int)line;
- (void) reportWarning:(NSString*)msg inFile:(NSString*)file atLine:(int)line;

@end
