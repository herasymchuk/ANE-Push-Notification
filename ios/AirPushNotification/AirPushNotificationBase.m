//
//  AirPushNotificationBase.m
//  AirPushNotification
//
//  Created by Admin on 28.08.15.
//
//

#import "AirPushNotificationBase.h"

@implementation AirPushNotificationBase



- (void)applicationDidFinishLaunching:(UIApplication *)application{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(applicationDidFinishLaunching:)]) {
        [_delegate applicationDidFinishLaunching:application];
    }
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(application:willFinishLaunchingWithOptions:)]) {
        return [_delegate application:application willFinishLaunchingWithOptions:launchOptions];
    }
    return NO;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)]) {
        return [_delegate application:application didFinishLaunchingWithOptions:launchOptions];
    }
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(applicationDidBecomeActive:)]) {
        [_delegate applicationDidBecomeActive:application];
    }
}
- (void)applicationWillResignActive:(UIApplication *)application{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(applicationWillResignActive:)]) {
        [_delegate applicationWillResignActive:application];
    }
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(application: handleOpenURL:)]) {
        return [_delegate application:application handleOpenURL:url];
    }
    return NO;
}  // Will be deprecated at some point, please replace with application:openURL:sourceApplication:annotation:
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(application: openURL: sourceApplication: annotation:)]) {
        return [_delegate application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    }
    return NO;
} // no equiv. notification. return NO if the application can't open for some reason

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(applicationDidReceiveMemoryWarning:)]) {
        [_delegate applicationDidReceiveMemoryWarning:application];
    }
}      // try to clean up as much memory as possible. next step is to terminate app
- (void)applicationWillTerminate:(UIApplication *)application{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(applicationWillTerminate:)]) {
        [_delegate applicationWillTerminate:application];
    }
}
- (void)applicationSignificantTimeChange:(UIApplication *)application{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(applicationSignificantTimeChange:)]) {
        [_delegate applicationSignificantTimeChange:application];
    }
}        // midnight, carrier time update, daylight savings time change

- (void)application:(UIApplication *)application willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(application: willChangeStatusBarOrientation: duration:)]) {
        [_delegate application:application willChangeStatusBarOrientation:newStatusBarOrientation duration:duration];
    }
}
- (void)application:(UIApplication *)application didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(application: didChangeStatusBarOrientation:)]) {
        [_delegate application:application didChangeStatusBarOrientation:oldStatusBarOrientation];
    }
}

- (void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(application: willChangeStatusBarFrame:)]) {
        [_delegate application:application willChangeStatusBarFrame:newStatusBarFrame];
    }
}   // in screen coordinates
- (void)application:(UIApplication *)application didChangeStatusBarFrame:(CGRect)oldStatusBarFrame{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(application: didChangeStatusBarFrame:)]) {
        [_delegate application:application didChangeStatusBarFrame:oldStatusBarFrame];
    }
}

// This callback will be made upon calling -[UIApplication registerUserNotificationSettings:]. The settings the user has granted to the application will be passed in as the second argument.
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(application: didRegisterUserNotificationSettings:)]) {
        [_delegate application:application didRegisterUserNotificationSettings:notificationSettings];
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    if (_delegate != nil && [_delegate respondsToSelector:@selector(application: didRegisterForRemoteNotificationsWithDeviceToken:)]) {
//        [_delegate application:application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken];
//    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
//    if (_delegate != nil && [_delegate respondsToSelector:@selector(application: didFailToRegisterForRemoteNotificationsWithError:)]) {
//        [_delegate application:application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error];
//    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
//    if (_delegate != nil && [_delegate respondsToSelector:@selector(application: didReceiveRemoteNotification:)]) {
//        [_delegate application:application didReceiveRemoteNotification:(NSDictionary *)userInfo];
//    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
//    if (_delegate != nil && [_delegate respondsToSelector:@selector(application: didReceiveLocalNotification:)]) {
//        [_delegate application:application didReceiveLocalNotification:(UILocalNotification *)notification];
//    }
}

// Called when your app has been activated by the user selecting an action from a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling the action.
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(application: handleActionWithIdentifier: forLocalNotification: completionHandler:)]) {
        [_delegate application:application handleActionWithIdentifier:identifier forLocalNotification:notification completionHandler:completionHandler];
    }
}

// Called when your app has been activated by the user selecting an action from a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling the action.
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(application: handleActionWithIdentifier: forRemoteNotification: completionHandler:)]) {
        [_delegate application:application handleActionWithIdentifier:identifier forRemoteNotification:userInfo completionHandler:completionHandler];
    }
}

/*! This delegate method offers an opportunity for applications with the "remote-notification" background mode to fetch appropriate new data in response to an incoming remote notification. You should call the fetchCompletionHandler as soon as you're finished performing that operation, so the system can accurately estimate its power and data cost.
 
 This method will be invoked even if the application was launched or resumed because of the remote notification. The respective delegate methods will be invoked first. Note that this behavior is in contrast to application:didReceiveRemoteNotification:, which is not called in those cases, and which will not be invoked if this method is implemented. !*/
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler{
}

/// Applications with the "fetch" background mode may be given opportunities to fetch updated content in the background or when it is convenient for the system. This method will be called in these situations. You should call the fetchCompletionHandler as soon as you're finished performing that operation, so the system can accurately estimate its power and data cost.
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(application: performFetchWithCompletionHandler:)]) {
        [_delegate application:application performFetchWithCompletionHandler:completionHandler];
    }
}

// Applications using an NSURLSession with a background configuration may be launched or resumed in the background in order to handle the
// completion of tasks in that session, or to handle authentication. This method will be called with the identifier of the session needing
// attention. Once a session has been created from a configuration object with that identifier, the session's delegate will begin receiving
// callbacks. If such a session has already been created (if the app is being resumed, for instance), then the delegate will start receiving
// callbacks without any action by the application. You should call the completionHandler as soon as you're finished handling the callbacks.
- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(application: handleEventsForBackgroundURLSession: completionHandler:)]) {
        [_delegate application:application handleEventsForBackgroundURLSession:identifier completionHandler:completionHandler];
    }
}

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void(^)(NSDictionary *replyInfo))reply{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(application: handleWatchKitExtensionRequest: reply:)]) {
        [_delegate application:application handleWatchKitExtensionRequest:userInfo reply:reply];
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(applicationDidEnterBackground:)]) {
        [_delegate applicationDidEnterBackground:application];
    }
}
- (void)applicationWillEnterForeground:(UIApplication *)application{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(applicationWillEnterForeground:)]) {
        [_delegate applicationWillEnterForeground:application];
    }
}

- (void)applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(applicationProtectedDataWillBecomeUnavailable:)]) {
        [_delegate applicationProtectedDataWillBecomeUnavailable:application];
    }
}
- (void)applicationProtectedDataDidBecomeAvailable:(UIApplication *)application {
    if (_delegate != nil && [_delegate respondsToSelector:@selector(applicationProtectedDataDidBecomeAvailable:)]) {
        [_delegate applicationProtectedDataDidBecomeAvailable:application];
    }
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(application: supportedInterfaceOrientationsForWindow:)]) {
        return [_delegate application:application supportedInterfaceOrientationsForWindow:window];
    }
    return 0;
}

// Applications may reject specific types of extensions based on the extension point identifier.
// Constants representing common extension point identifiers are provided further down.
// If unimplemented, the default behavior is to allow the extension point identifier.
- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(NSString *)extensionPointIdentifier{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(application: shouldAllowExtensionPointIdentifier:)]) {
        return [_delegate application:application shouldAllowExtensionPointIdentifier:extensionPointIdentifier];
    }
    return NO;
}

#pragma mark -- State Restoration protocol adopted by UIApplication delegate --

- (UIViewController *) application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(application: viewControllerWithRestorationIdentifierPath: coder:)]) {
        return [_delegate application:application viewControllerWithRestorationIdentifierPath:identifierComponents coder:coder];
    }
    return nil;
}
- (BOOL) application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder{
    if (_delegate != nil && [_delegate respondsToSelector:@selector( application: shouldSaveApplicationState:)]) {
        return [_delegate application:application shouldSaveApplicationState:coder];
    }
    return NO;
}
- (BOOL) application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder{
    if (_delegate != nil && [_delegate respondsToSelector:@selector( application: shouldRestoreApplicationState:)]) {
        return [_delegate application:application shouldRestoreApplicationState:coder];
    }
    return NO;
}
- (void) application:(UIApplication *)application willEncodeRestorableStateWithCoder:(NSCoder *)coder{
    if (_delegate != nil && [_delegate respondsToSelector:@selector( application: willEncodeRestorableStateWithCoder:)]) {
        [_delegate application:application willEncodeRestorableStateWithCoder:coder];
    }
}
- (void) application:(UIApplication *)application didDecodeRestorableStateWithCoder:(NSCoder *)coder{
    if (_delegate != nil && [_delegate respondsToSelector:@selector( application: didDecodeRestorableStateWithCoder:)]) {
        [_delegate application:application didDecodeRestorableStateWithCoder:coder];
    }
}

#pragma mark -- User Activity Continuation protocol adopted by UIApplication delegate --

// Called on the main thread as soon as the user indicates they want to continue an activity in your application. The NSUserActivity object may not be available instantly,
// so use this as an opportunity to show the user that an activity will be continued shortly.
// For each application:willContinueUserActivityWithType: invocation, you are guaranteed to get exactly one invocation of application:continueUserActivity: on success,
// or application:didFailToContinueUserActivityWithType:error: if an error was encountered.
- (BOOL)application:(UIApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(application: willContinueUserActivityWithType:)]) {
        return [_delegate application:application willContinueUserActivityWithType:userActivityType];
    }
    return NO;
}

// Called on the main thread after the NSUserActivity object is available. Use the data you stored in the NSUserActivity object to re-create what the user was doing.
// You can create/fetch any restorable objects associated with the user activity, and pass them to the restorationHandler. They will then have the UIResponder restoreUserActivityState: method
// invoked with the user activity. Invoking the restorationHandler is optional. It may be copied and invoked later, and it will bounce to the main thread to complete its work and call
// restoreUserActivityState on all objects.
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray *restorableObjects))restorationHandler{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(application: continueUserActivity: restorationHandler:)]) {
        return [_delegate application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
    }
    return NO;
}

// If the user activity cannot be fetched after willContinueUserActivityWithType is called, this will be called on the main thread when implemented.
- (void)application:(UIApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(application: didFailToContinueUserActivityWithType: error:)]) {
        [_delegate application:application didFailToContinueUserActivityWithType:userActivityType error:error];
    }
}

// This is called on the main thread when a user activity managed by UIKit has been updated. You can use this as a last chance to add additional data to the userActivity.
- (void)application:(UIApplication *)application didUpdateUserActivity:(NSUserActivity *)userActivity{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(application: didUpdateUserActivity:)]) {
        [_delegate application:application didUpdateUserActivity:userActivity];
    }
}


@end
