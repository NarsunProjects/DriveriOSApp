//
//  SessionsTableViewCell.h
//  AppTutor
//
//  Created by NARSUN-MAC-01 on 25/11/2016.
//  Copyright © 2016 Syed Qamar Abbas. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMaps;
#import "HCSStarRatingView.h"

@interface SessionsTableViewCell : UITableViewCell




@property (strong, nonatomic) IBOutlet UIImageView *userImageView;
@property (strong, nonatomic) IBOutlet HCSStarRatingView *ratingView;
@property (strong, nonatomic) IBOutlet UILabel *amount;
@property (strong, nonatomic) IBOutlet UILabel *emailCell;
@property (strong, nonatomic) IBOutlet UILabel *startAdrCell;
@property (strong, nonatomic) IBOutlet UILabel *endAdrCell;


@end
