//
//  ModelDataForSessionTable.h
//  Instagruas
//
//  Created by Mudassar on 26/01/2017.
//  Copyright © 2017 Narsun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelDataForSessionTable : NSObject

@property (nonatomic, strong) NSString *StartAddress;
@property (nonatomic, strong) NSString *EndAddress;
@property (nonatomic, strong) NSString *Price;
@property (nonatomic, strong) NSString *Email;
@property (nonatomic, strong) NSString* Rate;
@property (nonatomic, strong) NSString* Distance;
@property (nonatomic, assign) NSString* BaseFareRate;
@property (nonatomic, assign) NSString* TotalAmount;
@property (nonatomic, assign) NSString* TotalKms;
@property (nonatomic, assign) NSString*TotalMinFareRate;
@property (nonatomic ,copy)   NSString* timeAndDate;
@property (nonatomic ,copy)   NSString* DP;




- (id)initWithStartAddress:(NSString *)SAddress andEndAddress:(NSString *)EAddress andPrice:(NSString *)pri andEmail:(NSString *)Eml andRate:(NSString*)Rat withDistance :(NSString*) distnc withBaseFareRate : (NSString*) baseRate withAmount : (NSString*) ttlamt withTotalKilomate : (NSString*) totlKms andTotalMisnFareAmount : (NSString*) totlminamount withtimeAndDate:(NSString*) timedate withDp : (NSString*) dp;

@end
