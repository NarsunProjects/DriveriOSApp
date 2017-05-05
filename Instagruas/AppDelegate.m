//
//  AppDelegate.m
//  Instagruas
//
//  Created by NARSUN-MAC-01 on 20/12/2016.
//  Copyright © 2016 NARSUN-MAC-01. All rights reserved.
//

#import "AppDelegate.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "IGNetworkManager.h"
#import <UserNotificationsUI/UserNotificationsUI.h>
#import <UserNotifications/UserNotifications.h>
#import <AudioToolbox/AudioToolbox.h>
#import "NotificationParsing.h"
@import GoogleMaps;
@import GooglePlaces;
@import FirebaseMessaging;
@import Firebase;
@interface AppDelegate ()<UNUserNotificationCenterDelegate,FIRMessagingDelegate>{
    BOOL isProd;
    BOOL isUpdated;
}

@end

@implementation AppDelegate

//com.Alberto.Instagruas.Drivers
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    isProd = NO;
    [self userDidLoggedOut];
    self.isSpanishLanguage = NO;
    [FIRApp configure];
    [GMSServices provideAPIKey:@"AIzaSyC0zGwDWpxDoR0e0Ml-ORLomyYBIk6rsg0"];
    BOOL shouldStart = [GMSPlacesClient provideAPIKey:@"AIzaSyC0zGwDWpxDoR0e0Ml-ORLomyYBIk6rsg0"];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        
    {
        
        [[UIApplication sharedApplication]
         registerUserNotificationSettings:[UIUserNotificationSettings
                                           settingsForTypes:(UIUserNotificationTypeSound |
                                                             UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                           categories:nil]];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
    }
    
    else
        
    {
        
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound |
          UIUserNotificationTypeAlert)];
        
    }
    
    // Override point for customization after application launch.
    return shouldStart;
}



-(void)userDidLoggedIn{
    
    [self registerForRemoteNotification];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    _tabBarController = [storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
    
     [self.window setRootViewController:_tabBarController];
    
}

-(void)userDidLoggedOut{
//    InitialNavigationController
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    _navigationController = [storyboard instantiateViewControllerWithIdentifier:@"InitialNavigationController"];
    
    [self.window setRootViewController:_navigationController];
}

- (void)tokenRefreshNotification:(NSNotification *)notification {
    // Note that this callback will be fired everytime a new token is generated, including the first
    // time. So if you need to retrieve the token as soon as it is available this is where that
    // should be done.
    NSString *refreshedToken = [[FIRInstanceID instanceID] token];
    NSLog(@"InstanceID token: %@", refreshedToken);
    
        [self connectToFCM];
    // Connect to FCM since connection may have failed when attempted before having a token.
    
    // TODO: If necessary send token to application server.
}
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:(UIUserNotificationSettings
                                     *)notificationSettings // NS_AVAILABLE_IOS(8_0);

{
    
    [application registerForRemoteNotifications];
    
}



-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    if (!isProd) {
        [[FIRInstanceID instanceID] setAPNSToken:deviceToken
                                            type:FIRInstanceIDAPNSTokenTypeSandbox];
    }else{
        [[FIRInstanceID instanceID] setAPNSToken:deviceToken
                                            type:FIRInstanceIDAPNSTokenTypeProd];
    }
    
    NSString *refreshedToken = [[FIRInstanceID instanceID] token];
    

    
    if (isUpdated) {
        return;
    }
    NSLog(@"Fuck You:");
    NSLog(@"InstanceID token: %@", refreshedToken);
    [[NSUserDefaults standardUserDefaults]setValue:refreshedToken forKey:@"Token"];
    
    if (refreshedToken == nil) {
        [self registerForRemoteNotification];
        return;
    }
    [self updateTutorTokenWithTokenID:refreshedToken];
}
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
}
-(void)connectToFCM{
    [[FIRMessaging messaging] connectWithCompletion:^(NSError  *error){
        
        if (error==nil) {
            NSLog(@"Not an Error\n");
        }else{
            NSLog(@"An Error\n");
        }
        
    }];
}
-(void)applicationReceivedRemoteMessage:(FIRMessagingRemoteMessage *)remoteMessage{
   
}
-(void)updateTutorTokenWithTokenID:(NSString *)token{
    NSDictionary *param = @{@"did":[NSNumber numberWithInteger:self.userObject.userID.integerValue], @"gcm":token};
    [IGNetworkManager updateGCMWithParam:param success:^(NSString *success){
        
        isUpdated = YES;
    
    } failure:^(NSString *failure){
    
        [self updateTutorTokenWithTokenID:token];
    } apiFailure:^(NSError *error){
        
        [self updateTutorTokenWithTokenID:token];
    
    }];
}
-(void)registerForRemoteNotification{
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_9_x_Max) {
        UIUserNotificationType allNotificationTypes =
        (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        // iOS 10 or later
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
        UNAuthorizationOptions authOptions =UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:authOptions completionHandler:^(BOOL granted, NSError *error){
            
            
            
        }];
        
        // For iOS 10 display notification (sent via APNS)
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        // For iOS 10 data message (sent via FCM)
        [FIRMessaging messaging].remoteMessageDelegate = self;
#endif
    }
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}
-(void)fetchNotificationDetail:(NSDictionary *)dictionary{
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"notification" ofType:@"mp3"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundPath], &soundID);
    AudioServicesPlaySystemSound(soundID);
    [[NSNotificationCenter defaultCenter] postNotificationName:(NSString *)kNewRequestIsArrive object:nil];
    [self.userObject.request fetchDataFromDictionaryNotificationResponse:dictionary];
  
    
    [[NSUserDefaults standardUserDefaults]setValue:[dictionary valueForKey:@"CustomerID"] forKey:@"CustomerID"];
    [[NSUserDefaults standardUserDefaults]setValue:[dictionary valueForKey:@"Description"] forKey:@"Description"];
    [[NSUserDefaults standardUserDefaults]setValue:[dictionary valueForKey:@"DisplayPicture"] forKey:@"DisplayPicture"];
    [[NSUserDefaults standardUserDefaults]setValue:[dictionary valueForKey:@"Distance"] forKey:@"Distance"];
     [[NSUserDefaults standardUserDefaults]setValue:[dictionary valueForKey:@"EndAddress"] forKey:@"EndAddress"];
     [[NSUserDefaults standardUserDefaults]setValue:[dictionary valueForKey:@"Maker"] forKey:@"Maker"];
     [[NSUserDefaults standardUserDefaults]setValue:[dictionary valueForKey:@"Model"] forKey:@"Model"];
     [[NSUserDefaults standardUserDefaults]setValue:[dictionary valueForKey:@"Name"] forKey:@"Name"];
     [[NSUserDefaults standardUserDefaults]setValue:[dictionary valueForKey:@"Phone"] forKey:@"Phone"];
    [[NSUserDefaults standardUserDefaults]setValue:[dictionary valueForKey:@"Rating"] forKey:@"Rating"];
    [[NSUserDefaults standardUserDefaults]setValue:[dictionary valueForKey:@"RequestId"] forKey:@"RequestId"];
    [[NSUserDefaults standardUserDefaults]setValue:[dictionary valueForKey:@"StartAddress"] forKey:@"StartAddress"];
    [[NSUserDefaults standardUserDefaults]setValue:[dictionary valueForKey:@"TOR"] forKey:@"TOR"];
     [[NSUserDefaults standardUserDefaults]setValue:[dictionary valueForKey:@"Year"] forKey:@"Year"];
    [[NSUserDefaults standardUserDefaults]setValue:[dictionary valueForKey:@"end_latitude"] forKey:@"end_latitude"];
     [[NSUserDefaults standardUserDefaults]setValue:[dictionary valueForKey:@"end_longitude"] forKey:@"end_longitude"];
    [[NSUserDefaults standardUserDefaults]setValue:[dictionary valueForKey:@"latitude"] forKey:@"latitude"];
    
     [[NSUserDefaults standardUserDefaults]setValue:[dictionary valueForKey:@"longitude"] forKey:@"longitude"];

    
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    NSLog(@"%@",userInfo);
    
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    NSString *notificationStr = [userInfo objectForKey:@"gcm.notification.info"];
    NSError *jsonError;
    NSData *objectData = [notificationStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *notification = [NSJSONSerialization JSONObjectWithData:objectData
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:&jsonError];
    
    if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive ||[UIApplication sharedApplication].applicationState == UIApplicationStateBackground) {
        
        [self performSelectorInBackground:@selector(fetchNotificationDetail:) withObject:notification];
    }else{
        
        [self performSelector:@selector(fetchNotificationDetail:) withObject:notification afterDelay:0];
        //        [self performSelectorInBackground:@selector(fetchNotificationDetail:) withObject:notification];
    }
    completionHandler(UIBackgroundFetchResultNoData);
}
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        
    }else{
        
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Instagruas"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}






@end
