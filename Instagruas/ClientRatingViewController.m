//
//  ClientRatingViewController.m
//  Instagruas
//
//  Created by Mudassar on 09/02/2017.
//  Copyright © 2017 Narsun. All rights reserved.
//

#import "ClientRatingViewController.h"
#import "HCSStarRatingView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SessionViewController.h"

@interface ClientRatingViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *clientImage;
@property (strong, nonatomic) IBOutlet UILabel *clientNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *clientRating;
@property (strong, nonatomic) IBOutlet HCSStarRatingView *clientRatingStar;
@property (strong, nonatomic) IBOutlet HCSStarRatingView *clientGivenRatingStar;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;


@end

@implementation ClientRatingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    self.clientGivenRatingStar.value=0;
    NSString * Image = [[NSUserDefaults standardUserDefaults]stringForKey:@"DisplayPicture"];
    NSString * Name = [[NSUserDefaults standardUserDefaults]stringForKey:@"Name"];
    NSString * RateNumber = [[NSUserDefaults standardUserDefaults]stringForKey:@"Rating"];
    
    self.clientNameLabel.text=Name;
    self.clientRating.text = RateNumber;
    
    
    SDWebImageDownloader * downloader = [SDWebImageDownloader sharedDownloader];
    [downloader downloadImageWithURL:[NSURL URLWithString:Image] options:0 progress:^(NSInteger reciveSize , NSInteger expectedSize){} completed:^(UIImage *image ,NSData *data ,NSError * error,BOOL finished){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (Image && finished) {
                self.clientImage.image= [UIImage imageWithData:data];
                self.clientImage.layer.cornerRadius=self.clientImage.frame.size.width/2;
                self.clientImage.clipsToBounds=YES;
            }else{
                self.clientImage.image = [UIImage imageNamed:@"Image3"];
            
            }
        
        });
    
    }];
    [self checkRatingValue];
}
#pragma Marks check it wethar client give the value on rating or not.


-(void)checkRatingValue {
    
    float ratingValue = self.clientGivenRatingStar.value;
    if (ratingValue<=0) {
        self.submitButton.enabled=NO;
    }
    else{
        self.submitButton.enabled=YES;
    }
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didSelectHistoryButton:(id)sender {
    
    SessionViewController * SEV = [self.storyboard instantiateViewControllerWithIdentifier:@"SessionViewController"];
    [self presentViewController:SEV animated:YES completion:nil];
}
- (IBAction)sumbitButton:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    _tabBarController = [storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
    
    [self presentViewController:self.tabBarController animated:YES completion:nil];
    
    
    
    
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
