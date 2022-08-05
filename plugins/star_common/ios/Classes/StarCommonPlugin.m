#import "StarCommonPlugin.h"
#if __has_include(<star_common/star_common-Swift.h>)
#import <star_common/star_common-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "star_common-Swift.h"
#endif

@implementation StarCommonPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftStarCommonPlugin registerWithRegistrar:registrar];
}
@end
