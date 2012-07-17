#import <Foundation/Foundation.h>

@interface SKExample : NSObject

@property (readwrite, retain) NSString* name;
@property (readwrite, copy) void(^block)(void);

@end
