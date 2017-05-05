//
//  StaticData.h
//  RYPLS
//
//  Created by Curiologix on 12/14/15.
//  Copyright © 2015 Curiologix. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StaticData : NSObject{

}



@property (nonatomic, retain) NSString *fb_id;
@property (nonatomic, retain) NSString *deviceID;

@property (nonatomic, retain) NSString *baseUrl;
@property (nonatomic, retain) NSString *imageUrl;
@property (nonatomic, retain) NSString *Email;

@property (nonatomic, retain) NSString *user_type;

@property (nonatomic, retain) NSString *mem_id;

@property (nonatomic, retain) NSString *user_name;
@property (nonatomic, retain) NSString *venueID;
@property (nonatomic, retain) NSString *EventDate;
@property (nonatomic, retain) NSString *EventCity;
@property (nonatomic, retain) NSString *EveCount;

@property (nonatomic, retain) NSString *mem_phone;
@property (nonatomic, retain) NSString *mem_password;

@property (nonatomic, assign) NSInteger serverTimeout;
@property (nonatomic, retain) NSString *noInternetMessage;
@property (nonatomic, retain) NSString *secureKey;
@property (nonatomic, retain) NSString *Address;
@property (nonatomic, retain) NSString *City;
@property (nonatomic, retain) NSString *State;
@property (nonatomic, retain) NSString *staff_name;
@property (nonatomic, retain) NSString *Tokenn;
@property  BOOL isTrue;

@property  double mLat;

@property  double mLon;


+ (StaticData *)instance;
+ (void)initStaticData;

@end
