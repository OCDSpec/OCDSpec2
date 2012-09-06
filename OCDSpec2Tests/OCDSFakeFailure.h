#import <Foundation/Foundation.h>

@interface OCDSFakeFailure : NSObject

@property (assign) NSString* report;
@property (assign) NSString* inFile;
@property int atLine;

@end
