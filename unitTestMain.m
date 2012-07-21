#if TARGET_OS_IPHONE == 1

#import <UIKit/UIApplication.h>
#import <SpecKit/SpecKit.h>

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

#else

#import <SpecKit/SpecKit.h>

int main(int argc, char * argv[]) {
  @autoreleasepool {
    exit(SpecKitRunAllTests());
  }
  return 0;
}

#endif
