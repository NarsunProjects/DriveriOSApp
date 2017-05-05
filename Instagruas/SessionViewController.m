//
//  SessionViewController.m
//  AppTutor
//
//  Created by NARSUN-MAC-01 on 25/11/2016.
//  Copyright © 2016 Syed Qamar Abbas. All rights reserved.
//

#import "SessionViewController.h"
#import "AppDelegate.h"
#import "SessionsTableViewCell.h"
#import <DGActivityIndicatorView/DGActivityIndicatorView.h>
#import "AFNetworking.h"
#import "ModelDataForSessionTable.h"
#import "DetailsSessionViewController.h"
#import "HomeViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SessionViewController ()

@property (strong, nonatomic) NSMutableArray *arrayOfSessions;
@property (strong, nonatomic)DGActivityIndicatorView *activityIndicatorView;
@end

@implementation SessionViewController
- (IBAction)didSelectCloseButton:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Sessions";
    [self basicUISettings];
    [self getJsonDataForTableView];
    // Do any additional setup after loading the view.
}
-(void)basicUISettings{
    
}
-(void)showLoading{
    [UIView animateWithDuration:0.4 animations:^{
        self.loadingView.alpha = 1.0;
        [_activityIndicatorView startAnimating];
    }];
}

-(void)hideLoading{
    [UIView animateWithDuration:0.4 animations:^{
        self.loadingView.alpha = 0.0;
        [_activityIndicatorView stopAnimating];
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)getJsonDataForTableView{
    
    self.arrayOfSessions = [[NSMutableArray alloc]init];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://narsun.pk/UberTruck/GetCustomerHistory.php?cemail=test10@gmail.com" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        for(NSMutableDictionary *dict in [responseObject objectForKey:@"titles"]){
            
            NSString *SAddress = [dict valueForKey:@"StartAddress"];
            NSString *EAddress = [dict valueForKey:@"EndAddress"];
            NSString *pri = [dict valueForKey:@"Payment"];
            NSString *Eml = [dict valueForKey:@"DName"];
            
            
            NSString* Rat ;
            if([NSNull null] != [dict objectForKey:@"Rate"]) {
                Rat = [dict objectForKey:@"Rate"];
                
            }
            
            
            NSString *distnc = [dict valueForKey:@"Distance"];
            NSString* baseRate =    [dict objectForKey:@"base_fare_amount"];
            NSString* ttlamt =    [dict objectForKey:@"total_amount"];
            NSString* totlKms =    [dict objectForKey:@"total_kms_fare_amount"];
            NSString* totlminamount =    [dict objectForKey:@"total_mins_fare_amount"];
            NSString* timedate = [dict valueForKey:@"DateTimeRequested"];
            NSString * dp = [dict valueForKey:@"DP"];
            
            
            
           ModelDataForSessionTable *myData = [[ModelDataForSessionTable alloc]initWithStartAddress:(NSString *)SAddress andEndAddress:(NSString *)EAddress andPrice:(NSString *)pri andEmail:(NSString *)Eml andRate:(NSString *) Rat withDistance :(NSString*) distnc withBaseFareRate : (NSString*) baseRate withAmount : (NSString*) ttlamt withTotalKilomate : (NSString*) totlKms andTotalMisnFareAmount : (NSString*) totlminamount withtimeAndDate:(NSString*) timedate withDp : (NSString*) dp ] ;
            
            [self.arrayOfSessions addObject:myData];
            
        }
        
        [_tableView reloadData];
        
        NSLog(@"JSON: %@", responseObject);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
       
        NSLog(@"Error: %@", error);
    }];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.arrayOfSessions count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SessionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell==nil){
        cell = [[[SessionsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"]init];
    }
    
    ModelDataForSessionTable * dat = [self.arrayOfSessions objectAtIndex:indexPath.row];
    
    cell.amount.text = dat.Price;
    cell.emailCell.text=dat.Email;
    cell.endAdrCell.text=dat.EndAddress;
    cell.startAdrCell.text=dat.StartAddress;
    
    
    NSString * rate = dat.Rate;
    float fRate = [rate floatValue];
    cell.ratingView.value = fRate;
    
    
//    NSLog(@"%@",dat.DP);
//    NSString * myImage = dat.DP;
//    SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
//    [downloader downloadImageWithURL:[NSURL URLWithString:dat.DP]
//                             options:0
//                            progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//                                // progression tracking code
//                            }
//                           completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
//
//                    
//
//                               dispatch_async(dispatch_get_main_queue(), ^{
//
//                                   if (image && finished) {
//                                       
//                                       cell.userImageView.image = [UIImage imageWithData:data];
//                                       // do something with image
//                                   }else{
//                                       cell.userImageView.image = [UIImage imageNamed:@"Image3"];
//                                   }
//                                   
//                               });
//                               
//                           }];
//
//   
  
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSString *dp = dat.DP;
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:dat.DP]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            cell.userImageView.image = [UIImage imageWithData:data];
            cell.userImageView.layer.cornerRadius = cell.userImageView.frame.size.width / 2;
            cell.userImageView.clipsToBounds = YES;
        });
        
    });
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:fRate forKey:@"rate"];
    [defaults synchronize];
   
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    DetailsSessionViewController * DsVC = segue.destinationViewController;
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:sender];
    
    DsVC.data = [self.arrayOfSessions objectAtIndex:indexPath.row];
    
    
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
