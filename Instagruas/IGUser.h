//
//  IGUser.h
//  Instagruas
//
//  Created by NARSUN-MAC-01 on 04/01/2017.
//  Copyright © 2017 Narsun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGRequest.h"
@interface IGUser : NSObject

@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *userCURP;
@property (strong, nonatomic) NSString *userPhone;
@property (strong, nonatomic) NSString *userAddress;
@property (strong, nonatomic) NSString *userGender;
@property (strong, nonatomic) NSString *userEmail;
@property (strong, nonatomic) NSString *userDisplay;
@property (strong, nonatomic) NSString *userDOB;
@property (strong, nonatomic) NSString *userLiscenseNo;
@property (strong, nonatomic) NSNumber *userID;
@property (strong, nonatomic) NSString *userRFC;
@property (strong, nonatomic) NSNumber *userStatus;
@property (strong, nonatomic) NSNumber *userRating;
@property (strong, nonatomic) IGRequest *request;
-(void)fetchDataFromDictionary:(NSDictionary *)dictionary;

@end
