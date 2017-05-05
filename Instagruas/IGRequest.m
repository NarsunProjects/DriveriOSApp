//
//  IGRequest.m
//  Instagruas
//
//  Created by NARSUN-MAC-01 on 05/01/2017.
//  Copyright © 2017 Narsun. All rights reserved.
//

#import "IGRequest.h"

@implementation IGRequest
-(void)fetchDataFromDictionaryLoginResponse:(NSDictionary *)dictionary{
    _customerID = [dictionary objectForKey:@"CustomerID"];
    _descriptionString = [dictionary objectForKey:@"Description"];
    _customerDisplay = [dictionary objectForKey:@"DisplayPicture"];
    _distance = [dictionary objectForKey:@"Distance"];
    _endAddress = [dictionary objectForKey:@"EndAddress"];
    _maker = [dictionary objectForKey:@"Maker"];
    _model = [dictionary objectForKey:@"Model"];
    _name = [dictionary objectForKey:@"Name"];
    _phone = [dictionary objectForKey:@"Phone"];
    _rating = [dictionary objectForKey:@"Rating"];
    _requestID = [dictionary objectForKey:@"RequestId"];
    _requestStatus = [dictionary objectForKey:@"RequestStatus"];
    _startAddress = [dictionary objectForKey:@"StartAddress"];
    _tOR = [dictionary objectForKey:@"TOR"];
    _year = [dictionary objectForKey:@"Year"];
    _endLatitude = [dictionary objectForKey:@"end_latitude"];
    _endLongitude = [dictionary objectForKey:@"end_longitude"];
    _latitude = [dictionary objectForKey:@"latitude"];
    _longitude = [dictionary objectForKey:@"longitude"];
}

-(void)fetchDataFromDictionaryNotificationResponse:(NSDictionary *)dictionary{
    
    _customerID = [dictionary objectForKey:@"CustomerID"];
    _descriptionString = [dictionary objectForKey:@"Description"];
    _customerDisplay = [dictionary objectForKey:@"DisplayPicture"];
    _distance = [dictionary objectForKey:@"Distance"];
    _endAddress = [dictionary objectForKey:@"EndAddress"];
    _maker = [dictionary objectForKey:@"Maker"];
    _model = [dictionary objectForKey:@"Model"];
    _name = [dictionary objectForKey:@"Name"];
    _phone = [dictionary objectForKey:@"Phone"];
    _rating = [dictionary objectForKey:@"Rating"];
    _requestID = [dictionary objectForKey:@"RequestId"];
   // _requestStatus = [dictionary objectForKey:@"RequestStatus"];
    _startAddress = [dictionary objectForKey:@"StartAddress"];
    _tOR = [dictionary objectForKey:@"TOR"];
    _year = [dictionary objectForKey:@"Year"];
    _endLatitude = [dictionary objectForKey:@"end_latitude"];
    _endLongitude = [dictionary objectForKey:@"end_longitude"];
    _latitude = [dictionary objectForKey:@"latitude"];
    _longitude = [dictionary objectForKey:@"longitude"];
}
@end
