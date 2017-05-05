//
//  IGRequest.h
//  Instagruas
//
//  Created by NARSUN-MAC-01 on 05/01/2017.
//  Copyright © 2017 Narsun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IGRequest : NSObject
@property (strong, nonatomic) NSString *customerID;
@property (strong, nonatomic) NSString *descriptionString;
@property (strong, nonatomic) NSString *customerDisplay;
@property (strong, nonatomic) NSString *distance;
@property (strong, nonatomic) NSString *endAddress;
@property (strong, nonatomic) NSString *maker;
@property (strong, nonatomic) NSString *model;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *rating;
@property (strong, nonatomic) NSString *requestID;
@property (strong, nonatomic) NSString *requestStatus;
@property (strong, nonatomic) NSString *startAddress;
@property (strong, nonatomic) NSString *tOR;
@property (strong, nonatomic) NSString *year;
@property (strong, nonatomic) NSString *endLatitude;
@property (strong, nonatomic) NSString *endLongitude;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;

-(void)fetchDataFromDictionaryLoginResponse:(NSDictionary *)dictionary;
-(void)fetchDataFromDictionaryNotificationResponse:(NSDictionary *)dictionary;
@end


