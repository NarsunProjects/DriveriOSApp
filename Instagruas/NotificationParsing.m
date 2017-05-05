//
//  NotificationParsing.m
//  Instagruas
//
//  Created by Mudassar on 02/02/2017.
//  Copyright © 2017 Narsun. All rights reserved.
//

#import "NotificationParsing.h"

@implementation NotificationParsing

-(instancetype) init{

    self=[super init];
    if (self) {
        
        self.NotificationCustomerID = @"";
        self.Description = @"";
        self.DisplayPicture=@"";
        self.Distance=@"";
        self.EndAddress = @"";
        self.Mark = @"";
        self.Model = @"";
        self.Name=@"";
        self.Phone=@"";
        self.Rating=@"";
        self.RequesrID=@"";
        self.StartAddress=@"";
        self.TOR=@"";
        self.Year=@"";
        self.end_latitude=@"";
        self.end_longitude=@"";
        self.latitude=@"";
        self.longitude=@"";
    }

    return self;

}

@end
