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
#import <objc/runtime.h>
#import <objc/message.h>

static BOOL _startedWithNotification = NO;
static NSDictionary *_notification = nil;
static UILocalNotification *_localNotification = nil;
static FREContext myCtx = nil;

@implementation StarterNotificationChecker

// hack, this is called before UIApplicationDidFinishLaunching
+ (void)load
{
    NSLog(@"Start load");
    Class applicationClass = UIApplication.class;
    NSString *newAppName = [NSString stringWithFormat:@"Custom_%@", NSStringFromClass(applicationClass)];
    Class customApplication = NSClassFromString(newAppName);
    
    if(customApplication == nil){
        customApplication = objc_allocateClassPair(applicationClass, [newAppName UTF8String], 0);
        
        SEL selectorToOverrideApp = @selector(setApplicationIconBadgeNumber:);
        SEL selectorToOverrideAppCustom = @selector(setApplicationBadgeNumberCustom:);
        
        Method mApp = class_getInstanceMethod(applicationClass, selectorToOverrideApp);
        
        class_addMethod(applicationClass, selectorToOverrideAppCustom, (IMP)setApplicationBadgeNumberCustom, method_getTypeEncoding(mApp));
        
        Method mCustom = class_getInstanceMethod(applicationClass, selectorToOverrideAppCustom);
        
        method_exchangeImplementations(mApp, mCustom);
        
        objc_registerClassPair(customApplication);
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createStarterNotificationChecker:)
                                                 name:@"UIApplicationDidFinishLaunchingNotification" object:nil];
    
}

+ (void) setCtx:(FREContext) ctx {
    myCtx = ctx;
}

+ (void)createStarterNotificationChecker:(NSNotification *)notification
{
    NSDictionary *launchOptions = [notification userInfo] ;
    
    // This code will be called immediately after application:didFinishLaunchingWithOptions:.
    NSDictionary *remoteNotif = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
    //UILocalNotification *remoteNotif = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    UILocalNotification *localNotif = [launchOptions objectForKey: UIApplicationLaunchOptionsLocalNotificationKey];
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
    
    //NSInteger badgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber + 3;
    //[[UIApplication sharedApplication] setApplicationIconBadgeNumber: badgeNumber];
    
}

+(BOOL) applicationStartedWithNotification
{
    return _startedWithNotification;
}

+(NSDictionary*) getStarterNotification
{
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

void setApplicationBadgeNumberCustom(id self, SEL _cmd, UIApplication* application,NSInteger *badgeNumber){
    
}
