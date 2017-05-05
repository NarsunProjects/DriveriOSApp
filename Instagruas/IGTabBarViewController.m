//
//  IGTabBarViewController.m
//  Instagruas
//
//  Created by NARSUN-MAC-01 on 05/01/2017.
//  Copyright © 2017 Narsun. All rights reserved.
//

#import "IGTabBarViewController.h"
#import "AppDelegate.h"
@interface IGTabBarViewController ()

@end

@implementation IGTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (delegate.haveAnyRequestNow) {
        
    }else{
        
    }
    // Do any additional setup after loading the view.
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
