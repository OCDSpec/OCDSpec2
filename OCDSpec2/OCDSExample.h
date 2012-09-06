#import <Foundation/Foundation.h>

@interface OCDSExample : NSObject

@property (readwrite, retain) NSString* name;
@property (readwrite, copy) void(^block)(void);

@end
