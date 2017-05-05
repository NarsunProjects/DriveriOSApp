//
//  IGAlertView.m
//  Instagruas
//
//  Created by Syed Qamar Abbas on 02/01/2017.
//  Copyright © 2017 NARSUN-MAC-01. All rights reserved.
//

#import "IGAlertView.h"
#import "AppDelegate.h"
static IGAlertView *sharedView;

@implementation IGAlertView

-(instancetype)init{
    if (!sharedView) {
        self = (IGAlertView *)[[[NSBundle mainBundle] loadNibNamed:@"IGAlertView" owner:self options:nil] objectAtIndex:0];
    }
    return self;
}

+(instancetype)sharedAlertView{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedView = [[IGAlertView alloc] init];
    });
    return sharedView;
}
-(void)showAlertWithAnimation{
    sharedView.frame = [[UIScreen mainScreen] bounds];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:sharedView];
    [UIView animateWithDuration:0.4 animations:^{
        [sharedView.activityIndicator startAnimating];
    }];
}
-(void)removeAlertWithAnimation{
    [UIView animateWithDuration:0.4 animations:^{
        [sharedView.activityIndicator stopAnimating];
    
    } completion:^(BOOL finished){
        [sharedView removeFromSuperview];
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
