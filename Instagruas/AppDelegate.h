//
//  AppDelegate.h
//  Instagruas
//
//  Created by NARSUN-MAC-01 on 20/12/2016.
//  Copyright © 2016 NARSUN-MAC-01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "IGUser.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (assign, nonatomic) BOOL isSpanishLanguage;
@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) IGUser *userObject;
@property (assign, nonatomic) BOOL haveAnyRequestNow;
- (void)saveContext;
-(void)userDidLoggedIn;
-(void)userDidLoggedOut;
@end

