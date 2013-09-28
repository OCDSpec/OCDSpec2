#import <Foundation/Foundation.h>
#import "OCDSLogger.h"

@interface FakeLogger : NSObject <OCDSLogger>

@property (strong, nonatomic) NSArray *messages;

@end
