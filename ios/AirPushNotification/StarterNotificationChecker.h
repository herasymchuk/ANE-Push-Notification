//
//  StarterNotificationChecker.h
//  AirPushNotification
//
//  Created by Thibaut on 13/12/12.
//
//

#import <UIKit/UIKit.h>
#import "FlashRuntimeExtensions.h"

@interface StarterNotificationChecker : NSObject
+ (void)load;

+ (void) createStarterNotificationChecker:(NSNotification*) notification;
//+ (void) ADEPDidReceiveLocalNotification :(NSNotification*)notification;

+ (BOOL) applicationStartedWithNotification;

+ (NSDictionary*) getStarterNotification;

+ (void) deleteStarterNotification;

+ (void) setCtx:(FREContext)ctx;

@end

void setApplicationBadgeNumberCustom(id self, SEL _cmd, UIApplication* application,NSInteger *badgeNumber);
