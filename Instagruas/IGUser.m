//
//  IGUser.m
//  Instagruas
//
//  Created by NARSUN-MAC-01 on 04/01/2017.
//  Copyright © 2017 Narsun. All rights reserved.
//

#import "IGUser.h"
#import "AppDelegate.h"
@implementation IGUser
-(void)fetchDataFromDictionary:(NSDictionary *)dictionary{

    _userName = [dictionary objectForKey:@"Name"];
    _userCURP = [dictionary objectForKey:@"CURP"];
    _userPhone = [dictionary objectForKey:@"Phone"];
    _userAddress = [dictionary objectForKey:@"Address"];
    _userEmail = [dictionary objectForKey:@"Email"];
    _userDisplay = [dictionary objectForKey:@"DisplayPicture"];
    if ([_userDisplay isKindOfClass:[NSNull class]]) {
        _userDisplay = @"";
    }
    _userGender = [dictionary objectForKey:@"Gender"];
    _userDOB = [dictionary objectForKey:@"dob"];
    _userLiscenseNo = [dictionary objectForKey:@"liscenseno"];
    _userID = [dictionary objectForKey:@"DriverId"];
    _userRFC = [dictionary objectForKey:@"RFC"];
    _userStatus = [dictionary objectForKey:@"status"];
    _userRating = [dictionary objectForKey:@"rating"];
    NSArray *array = [dictionary objectForKey:@"request"];
    
    
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (array == nil || array.count == 0) {
        delegate.haveAnyRequestNow = NO;
    }else{
        delegate.haveAnyRequestNow = YES;
        _request = [[IGRequest alloc]init];
        [_request fetchDataFromDictionaryLoginResponse:(NSDictionary *)[array objectAtIndex:0]];
        
    }
}
@end
