//
//  NotificationParsing.h
//  Instagruas
//
//  Created by Mudassar on 02/02/2017.
//  Copyright © 2017 Narsun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationParsing : NSObject

@property (nonatomic, strong) NSString *NotificationCustomerID;
@property (nonatomic, strong) NSString *Description;
@property (nonatomic, strong) NSString *DisplayPicture;
@property (nonatomic, strong) NSString *Distance;
@property (nonatomic, strong) NSString* EndAddress;
@property (nonatomic, strong) NSString* Mark;
@property (nonatomic, assign) NSString* Model;
@property (nonatomic, assign) NSString* Name;
@property (nonatomic, assign) NSString* Phone;
@property (nonatomic, assign) NSString* Rating;
@property (nonatomic ,copy)   NSString* RequesrID;
@property (nonatomic ,copy)   NSString* StartAddress;
@property (nonatomic ,copy)   NSString* TOR;
@property (nonatomic ,copy)   NSString* Year;
@property (nonatomic ,copy)   NSString* end_latitude;
@property (nonatomic ,copy)   NSString* end_longitude;
@property (nonatomic ,copy)   NSString* latitude;
@property (nonatomic ,copy)   NSString* longitude;

@end
