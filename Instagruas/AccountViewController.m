//
//  AccountViewController.m
//  Instagruas
//
//  Created by NARSUN-MAC-01 on 28/12/2016.
//  Copyright © 2016 NARSUN-MAC-01. All rights reserved.
//

#import "AccountViewController.h"
#import "AppDelegate.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SessionViewController.h"
#import "AFNetworking.h"

@interface AccountViewController (){
    UIButton *onlineOflineButton;
}
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UILabel *liscenceNumberLabel;
@property (strong, nonatomic) IBOutlet UIView *infoView;
@property (strong, nonatomic) IBOutlet UIButton *signoutButton;


@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setOnlineOflineButton];
    [self setBasicUISettings];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * reqPhn = [defaults objectForKey:@"reqPhn"];
    NSString * LiscenseNo = [defaults objectForKey:@"LiscenseNo"];
    NSString * Name = [defaults objectForKey:@"Name"];
    NSString * Email = [defaults objectForKey:@"Email"];
    
    NSLog(@"%@",reqPhn);
    NSLog(@"%@",LiscenseNo);
    NSLog(@"%@",Email);
    NSLog(@"%@",Name);

    
    self.nameLabel.text = Name;
    self.phoneNumberLabel.text = reqPhn;
    self.emailLabel.text = Email;
    self.liscenceNumberLabel.text =LiscenseNo;
    
    
}


- (IBAction)didSelectHistoryOption:(id)sender {
    SessionViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SessionViewController"];
    [self presentViewController:nextVC animated:YES completion:nil];
}

-(void)setBasicUISettings{
    
    _signoutButton.layer.cornerRadius = _signoutButton.frame.size.height/2;
    _signoutButton.clipsToBounds = YES;
    
    _imageView.layer.cornerRadius = 3;
    _imageView.clipsToBounds = YES;
    
    _infoView.layer.cornerRadius = 5;
    _infoView.clipsToBounds = YES;
    
    _infoView.layer.borderColor = self.navigationController.navigationBar.barTintColor.CGColor;
    _infoView.layer.borderWidth = 2.5;
    _imageView.layer.borderColor = self.navigationController.navigationBar.barTintColor.CGColor;
    _imageView.layer.borderWidth = 2.5;
    
    [self.signoutButton addTarget:self action:@selector(didSelectLoggedOutButton) forControlEvents:UIControlEventTouchUpInside];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _nameLabel.text = delegate.userObject.userName;
    _phoneNumberLabel.text = delegate.userObject.userPhone;
    _emailLabel.text = delegate.userObject.userEmail;
    _liscenceNumberLabel.text = delegate.userObject.userLiscenseNo;
    SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
    [downloader downloadImageWithURL:[NSURL URLWithString:delegate.userObject.userDisplay]
                             options:0
                            progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                // progression tracking code
                            }
                           completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                               
                               
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   
                                   if (image && finished) {
                                       
                                       self.imageView.image = image;
                                       // do something with image
                                   }else{
                                       self.imageView.image = [UIImage imageNamed:@"Studentparent.png"];
                                   }
                                   
                               });
                               
                               
                               
                           }];

}
-(void)didSelectLoggedOutButton{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate userDidLoggedOut];
}
-(void)setOnlineOflineButton{
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
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
