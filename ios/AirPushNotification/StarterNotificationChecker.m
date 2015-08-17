//
//  StarterNotificationChecker.m
//  AirPushNotification
//
//  Created by Thibaut on 13/12/12.
//
//

#import "StarterNotificationChecker.h"

#import "FlashRuntimeExtensions+Private.h"
#import "AirPushNotification.h"

static BOOL _startedWithNotification = NO;
static NSDictionary *_notification = nil;
static UILocalNotification *_localNotification = nil;
static FREContext myCtx = nil;

@implementation StarterNotificationChecker

// hack, this is called before UIApplicationDidFinishLaunching
+ (void)load
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createStarterNotificationChecker:)
                                                 name:@"UIApplicationDidFinishLaunchingNotification" object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(ADEPDidReceiveLocalNotification:)
//                                                 name:(NSString *)FRPE_ApplicationDidReceiveLocalNotification
//                                               object:nil];
}

+ (void) setCtx:(FREContext) ctx {
    myCtx = ctx;
}

//+(void) ADEPDidReceiveLocalNotification :(NSNotification*)notification
//{
//    NSLog(@"ADEPDidReceiveLocalNotification");
//    
//    UILocalNotification *localNotification = [[notification userInfo] valueForKey:(NSString*)FRPE_ApplicationDidReceiveLocalNotificationKey];
//    NSDictionary *notificationUserInfo = [localNotification userInfo];
//
//    NSString *stringInfo = [AirPushNotification convertToJSonString:notificationUserInfo];
//    if ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive || [UIApplication sharedApplication].applicationState == UIApplicationStateBackground)
//    {
//        NSLog(@"ADEPDidReceiveLocalNotification 2");
//        FREDispatchStatusEventAsync(myCtx, (uint8_t*)"APP_BROUGHT_TO_FOREGROUND_FROM_NOTIFICATION", (uint8_t*)[stringInfo UTF8String]);
//    }
//}

+ (void)createStarterNotificationChecker:(NSNotification *)notification
{
    NSDictionary *launchOptions = [notification userInfo] ;
    
    // This code will be called immediately after application:didFinishLaunchingWithOptions:.
    NSDictionary *remoteNotif = [launchOptions objectForKey: @"UIApplicationLaunchOptionsRemoteNotificationKey"];
    //UILocalNotification *remoteNotif = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    UILocalNotification *localNotif = [launchOptions objectForKey: @"UIApplicationLaunchOptionsLocalNotificationKey"];
    NSLog(@"StarterNotificationChecker remote: %@, local: %@", remoteNotif, localNotif);
    if (remoteNotif) {
        _notification = remoteNotif;
        _localNotification = nil;
    }
    if (localNotif) {
        _localNotification = localNotif;
    }
    if (remoteNotif || localNotif)
    {
        _startedWithNotification = YES;
    }
    else
    {
        _startedWithNotification = NO;
    }
    NSInteger badgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber + 3;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: badgeNumber];
    
}

+(BOOL) applicationStartedWithNotification
{
    return _startedWithNotification;
}

+(NSDictionary*) getStarterNotification
{
    NSLog(@"getStarterNotification");
    if(_localNotification) {
        _notification = _localNotification.userInfo;
    }
    NSLog(@"getStarterNotification %@", _notification);
    return _notification;
}

+ (void) deleteStarterNotification
{
    _notification = nil;
}

@end
