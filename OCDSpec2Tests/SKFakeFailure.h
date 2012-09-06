#import <Foundation/Foundation.h>

@interface SKFakeFailure : NSObject

@property (assign) NSString* report;
@property (assign) NSString* inFile;
@property int atLine;

@end
