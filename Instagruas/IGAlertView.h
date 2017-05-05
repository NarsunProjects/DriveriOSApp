//
//  IGAlertView.h
//  Instagruas
//
//  Created by Syed Qamar Abbas on 02/01/2017.
//  Copyright © 2017 NARSUN-MAC-01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IGAlertView : UIView
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;



+(instancetype)sharedAlertView;
-(void)showAlertWithAnimation;
-(void)removeAlertWithAnimation;

@end
