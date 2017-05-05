//
//  ViewController.m
//  Instagruas
//
//  Created by NARSUN-MAC-01 on 20/12/2016.
//  Copyright © 2016 NARSUN-MAC-01. All rights reserved.
//

#import "ViewController.h"
#import "InstagruasStrings.h"
#import "LoginViewController.h"
@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *signUpButton;

@end

@implementation ViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"transparent.png"] forBarMetrics:UIBarMetricsDefault];
}
-(void)setStringsToAllViews{
    [_loginButton setTitle:[InstagruasStrings getLoginString] forState:UIControlStateNormal];
    [_loginButton setTitle:[InstagruasStrings getLoginString] forState:UIControlStateSelected];
    
    [_signUpButton setTitle:[InstagruasStrings getSingUpString] forState:UIControlStateNormal];
    [_signUpButton setTitle:[InstagruasStrings getSingUpString] forState:UIControlStateSelected];
}
-(void)setBasicUISettings{
    _loginButton.layer.cornerRadius = 25;
    [_loginButton setClipsToBounds:YES];
    
    _signUpButton.layer.cornerRadius = 25;
    [_signUpButton setClipsToBounds:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStringsToAllViews];
    [self setBasicUISettings];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)didSelectLoginButton:(id)sender {
    LoginViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.navigationController pushViewController:nextVC animated:YES];
}
- (IBAction)didSelectSignUpButton:(id)sender {
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
