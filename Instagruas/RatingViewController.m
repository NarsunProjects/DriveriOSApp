//
//  RatingViewController.m
//  Instagruas
//
//  Created by NARSUN-MAC-01 on 28/12/2016.
//  Copyright © 2016 NARSUN-MAC-01. All rights reserved.
//

#import "RatingViewController.h"
#import "HCSStarRatingView.h"
#import "AppDelegate.h"
#import "SessionViewController.h"
@interface RatingViewController (){
    UIButton *onlineOflineButton;
}
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet HCSStarRatingView *ratingView;
@property (strong, nonatomic) IBOutlet UIView *centerView;

@end

@implementation RatingViewController


- (IBAction)didSelectHistoryOption:(id)sender {
    SessionViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SessionViewController"];
    [self presentViewController:nextVC animated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setOnlineOflineButton];

    // Do any additional setup after loading the view.
}
-(void)setOnlineOflineButton{
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    
    _centerView.layer.cornerRadius = 5;
    _centerView.clipsToBounds = YES;
    _centerView.layer.borderColor = self.navigationController.navigationBar.barTintColor.CGColor;
    _centerView.layer.borderWidth = 2.5;
    
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (delegate.userObject.userRating.integerValue == 0) {
        _ratingView.tintColor = [UIColor darkGrayColor];
    }else{
        _ratingView.tintColor = _centerView.tintColor;
    }
    _nameLabel.text = delegate.userObject.userName;
    _ratingView.value = (CGFloat)delegate.userObject.userRating.integerValue;
    
    
    CGFloat width = self.view.frame.size.width/3;
    
    onlineOflineButton = [[UIButton alloc]initWithFrame:CGRectMake(width, 10, width, self.navigationController.navigationBar.frame.size.height-10)];
    onlineOflineButton.layer.cornerRadius = onlineOflineButton.frame.size.height/2;
    onlineOflineButton.clipsToBounds = YES;
    [onlineOflineButton setBackgroundColor:self.view.tintColor];
    [onlineOflineButton setTitle:@"Online" forState:UIControlStateNormal];
    [onlineOflineButton setTitle:@"Online" forState:UIControlStateSelected];
    [onlineOflineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [onlineOflineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    onlineOflineButton.tag = 0;
    [onlineOflineButton addTarget:self action:@selector(didSelectOnlineOflineButton) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:onlineOflineButton];
    onlineOflineButton.center = CGPointMake(self.view.frame.size.width/2, self.navigationController.navigationBar.frame.size.height/2);
    
}

-(void)setOffline{
    
    onlineOflineButton.tag = 1;
    
    [onlineOflineButton setBackgroundColor:[UIColor whiteColor]];
    [onlineOflineButton setTitle:@"Offline" forState:UIControlStateNormal];
    [onlineOflineButton setTitle:@"Offline" forState:UIControlStateSelected];
    [onlineOflineButton setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    [onlineOflineButton setTitleColor:self.view.tintColor forState:UIControlStateSelected];
}

-(void)setBusy{
    
    onlineOflineButton.tag = 2;
    
    [onlineOflineButton setBackgroundColor:[UIColor darkGrayColor]];
    [onlineOflineButton setTitle:@"Unavailable" forState:UIControlStateNormal];
    [onlineOflineButton setTitle:@"Unavailable" forState:UIControlStateSelected];
    [onlineOflineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [onlineOflineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
}
-(void)setOnline{
    
    onlineOflineButton.tag = 0;
    
    [onlineOflineButton setBackgroundColor:self.view.tintColor];
    [onlineOflineButton setTitle:@"Online" forState:UIControlStateNormal];
    [onlineOflineButton setTitle:@"Online" forState:UIControlStateSelected];
    [onlineOflineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [onlineOflineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
}

-(void)didSelectOnlineOflineButton{
    if (onlineOflineButton.tag == 0) {
        [self setOffline];
    }else if(onlineOflineButton.tag == 1){
        [self setBusy];
    }
    else{
        [self setOnline];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
