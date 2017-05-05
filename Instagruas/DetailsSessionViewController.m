//
//  DetailsSessionViewController.m
//  Instagruas
//
//  Created by Mudassar on 26/01/2017.
//  Copyright © 2017 Narsun. All rights reserved.
//

#import "DetailsSessionViewController.h"

@interface DetailsSessionViewController ()

@end

@implementation DetailsSessionViewController
@synthesize price,email,endAddress,startAddress,data,distance;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    price.text = data.Price;
    email.text = data.Email;
    endAddress.text = data.EndAddress;
    startAddress.text = data.StartAddress;
    distance.text = data.Distance;
   // distance.text = [NSString stringWithFormat:@"%lf",data.Distance];
    self.baseFareRate.text = data.BaseFareRate;
    self.totalDistanceRate.text= data.TotalAmount;
    self.timeRate.text = data.TotalKms;
    self.total.text = data.TotalMinFareRate;
    
    NSString* dateAndTIme = data.timeAndDate;
    NSArray* dateArray = [dateAndTIme componentsSeparatedByString: @" "];
    NSString* dateString = [dateArray objectAtIndex: 0];
    NSString * timeString = [dateArray objectAtIndex:1];
    
    
    self.time.text = timeString;
    self.Date.text = dateString;
    
    NSString * rate = data.Rate;
    float frate = [rate floatValue];
    
    _rateView.value = frate;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancleButton:(id)sender {
    
   [self dismissViewControllerAnimated:YES completion:nil];
    
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
