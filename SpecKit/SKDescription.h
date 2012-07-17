#import <Foundation/Foundation.h>

@interface SKDescription : NSObject

@property (readwrite, retain) NSString* name;
@property (readwrite, retain) NSArray *examples;

@property (readwrite, copy) void (^beforeEachBlock)(void);
@property (readwrite, copy) void (^afterEachBlock)(void);

@end
