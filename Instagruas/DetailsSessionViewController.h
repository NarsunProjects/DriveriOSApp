//
//  DetailsSessionViewController.h
//  Instagruas
//
//  Created by Mudassar on 26/01/2017.
//  Copyright © 2017 Narsun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SessionsTableViewCell.h"
#import "ModelDataForSessionTable.h"


@interface DetailsSessionViewController : UIViewController

@property(strong,nonatomic) ModelDataForSessionTable * data;

@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *email;
@property (strong, nonatomic) IBOutlet UILabel *startAddress;
@property (strong, nonatomic) IBOutlet UILabel *endAddress;
@property (strong, nonatomic) IBOutlet UILabel *distance;
@property (strong, nonatomic) IBOutlet UILabel *baseFareRate;
@property (strong, nonatomic) IBOutlet UILabel *totalDistanceRate;
@property (strong, nonatomic) IBOutlet UILabel *timeRate;
@property (strong, nonatomic) IBOutlet UILabel *total;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *Date;
@property (strong, nonatomic) IBOutlet HCSStarRatingView *rateView;


@end
