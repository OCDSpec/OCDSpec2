#import <UIKit/UIKit.h>

#import <OCDSpec2/OCDSpec2.h>

@interface OCDSpec2AppDelegate :NSObject <UIApplicationDelegate>
@end

@implementation OCDSpec2AppDelegate
@end

@interface OCDSpec2ApplicationRunner : UIApplication
@end

@implementation OCDSpec2ApplicationRunner

-(id) init {
  if (self = [super init]) {
    if (OCDSpec2RunAllTests() > 0) {
      [NSException raise:NSGenericException format:@""];
    }
  }
  
  return self;
}
@end

int main(int argc, char * argv[])
{
  @autoreleasepool {
    return UIApplicationMain(argc, argv, NSStringFromClass([OCDSpec2ApplicationRunner class]), @"OCDSpec2AppDelegate");
  }
}