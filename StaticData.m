//
//  StaticData.m
//  RYPLS
//
//  Created by Curiologix on 12/14/15.
//  Copyright © 2015 Curiologix. All rights reserved.
//

#import "StaticData.h"

@implementation StaticData

@synthesize deviceID, baseUrl, fb_id, Email,  mem_id, user_name ,EventCity,mem_password, user_type, serverTimeout, noInternetMessage, secureKey,EveCount,City,Address,State,mLat,mLon,isTrue,staff_name;

@synthesize mem_phone;

static StaticData *_instance;

- (id) init {
    if (self = [super init]) {
    }
    return self;
}

+ (StaticData *)instance {
    if (!_instance) {
        _instance = [[StaticData alloc] init];
    }
    return _instance;
}

+ (void)initStaticData {
    [StaticData instance].deviceID = @"";
    [StaticData instance].serverTimeout = 30 * 1000;
    //[StaticData instance].baseUrl = @"http://reeln.webdesigninhoustontexas.com/";
    [StaticData instance].baseUrl = @"http://rlyps.curiologix.com/public/";
    [StaticData instance].imageUrl = @"http://rlyps.curiologix.com/public/images/[image_name";
    [StaticData instance].noInternetMessage = @"Please check your internet connection!";
    [StaticData instance].secureKey = @"";
    
}


@end
