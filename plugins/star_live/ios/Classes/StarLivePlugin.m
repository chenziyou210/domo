#import "StarLivePlugin.h"
#if __has_include(<star_live/star_live-Swift.h>)
#import <star_live/star_live-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "star_live-Swift.h"
#endif

@implementation StarLivePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftStarLivePlugin registerWithRegistrar:registrar];
}
@end
