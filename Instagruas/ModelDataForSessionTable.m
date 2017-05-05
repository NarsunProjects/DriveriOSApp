//
//  ModelDataForSessionTable.m
//  Instagruas
//
//  Created by Mudassar on 26/01/2017.
//  Copyright © 2017 Narsun. All rights reserved.
//

#import "ModelDataForSessionTable.h"

@implementation ModelDataForSessionTable

@synthesize StartAddress,EndAddress,Email,Rate,Price,Distance,BaseFareRate,TotalKms,TotalAmount,TotalMinFareRate;

- (id)initWithStartAddress:(NSString *)SAddress andEndAddress:(NSString *)EAddress andPrice:(NSString *)pri andEmail:(NSString *)Eml andRate:(NSString*)Rat withDistance :(NSString*) distnc withBaseFareRate : (NSString*) baseRate withAmount : (NSString*) ttlamt withTotalKilomate : (NSString*) totlKms andTotalMisnFareAmount : (NSString*) totlminamount withtimeAndDate:(NSString*) timedate withDp : (NSString*) dp{
    
    self = [super init];
    
    if (self) {
        
        StartAddress = SAddress;
        EndAddress = EAddress;
        Price = pri;
        Email = Eml;
        Rate = Rat;
        Distance = distnc;
        BaseFareRate = baseRate;
        TotalAmount=ttlamt;
        TotalKms=totlKms;
        TotalMinFareRate=totlminamount;
        _timeAndDate= timedate;
        _DP=dp;
        
        
    }
 
    return self;
}



@end
