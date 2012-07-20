#import <UIKit/UIApplication.h>
#import "SpecKit.h"

@interface SpecKitEntryPoint : NSObject
@end

@implementation SpecKitEntryPoint

- (void) applicationDidFinishLaunching:(UIApplication*)app {
  exit(SpecKitRunAllTests());
}

@end

int main(int argc, char * argv[]) {
  @autoreleasepool {
    UIApplicationMain(argc, argv, nil, NSStringFromClass([SpecKitEntryPoint self]));
  }
  return 0;
}
