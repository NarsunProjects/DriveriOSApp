//
//  IGNetworkManager.h
//  Instagruas
//
//  Created by NARSUN-MAC-01 on 29/12/2016.
//  Copyright © 2016 Narsun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import <AFNetworking/AFNetworking.h>
#import "IGUser.h"
@interface IGNetworkManager : NSObject
typedef void (^LoginSuccess)(IGUser *user);
typedef void (^StatusSuccess)(NSString *success);
typedef void (^StatusFailure)(NSString *failure);
typedef void (^HttpFailure)(NSError *error);
//HttpFailure
/*!
 Params are email = "Email" and password = "Password"
 */
+(void)driverRequestLogInWithParam:(NSDictionary *)param success:(LoginSuccess)success failure:(StatusFailure)failure apiFailure:(HttpFailure)apiFailure;
+(void)updateGCMWithParam:(NSDictionary *)param success:(StatusSuccess)success failure:(StatusFailure)failure apiFailure:(HttpFailure)apiFailure;



@end
