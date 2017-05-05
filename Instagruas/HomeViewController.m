//
//  HomeViewController.m
//  Instagruas
//
//  Created by NARSUN-MAC-01 on 28/12/2016.
//  Copyright © 2016 NARSUN-MAC-01. All rights reserved.
//

#import "HomeViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "RSSliderView.h"
#import "Constants.h"
#import "HCSStarRatingView.h"
#import "SessionViewController.h"
#import "AFNetworking.h"
#import "ModelDataForSessionTable.h"
#import "IGNetworkManager.h"
#import "IGAlertView.h"



@import GoogleMaps;
@interface HomeViewController ()<CLLocationManagerDelegate,RSliderViewDelegate,GMSMapViewDelegate>{
    UIButton *onlineOflineButton;
    CLLocation *currentLocation;
    CLLocationManager *manager;
    BOOL isTouchesBegan;
    RSSliderView *startSlider;
    RSSliderView *completeSlider;
    NSTimer* timer;
    
}
@property (strong, nonatomic) IBOutlet UIView *sliderView;
@property (strong, nonatomic) IBOutlet GMSMapView *mapView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sliderWidth;
@property (strong, nonatomic) IBOutlet UILabel *sliderLabel;
@property (strong, nonatomic) IBOutlet UIView *sliderParentView;
@property (strong, nonatomic) IBOutlet UIView *sliderChildView;
@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;
@property (strong, nonatomic) IBOutlet UIView *requestView;
@property (strong, nonatomic) IBOutlet UILabel *timerLabel;
@property (strong, nonatomic) IBOutlet UIView *clientInfoView;
@property (strong, nonatomic) IBOutlet UIImageView *clientImage;
@property (strong, nonatomic) IBOutlet UILabel *clientName;
@property (strong, nonatomic) IBOutlet UILabel *clientNumber;
@property (strong, nonatomic) IBOutlet HCSStarRatingView *clientRating;
@property (strong, nonatomic) IBOutlet UILabel *clientRatingLabel;
@property (strong, nonatomic) IBOutlet UIButton *clientInfoCallButton;
@property (strong, nonatomic) IBOutlet UIView *addressBar;
@property (strong, nonatomic) IBOutlet UILabel *notificaionLabelName;
@property (weak, nonatomic) IBOutlet UIView *notificationView;
@property (weak, nonatomic) IBOutlet UIImageView *notoficationImage;




@end

/*
 State of This Screen
 1: Default Status with nothing on top Bar.
 2: Arrived a Notification and Appears a Accept Button With Timer
 3: If not accept then call cancel Api and go back to step 1
 4: If Accept the show user info with a path between driver and client and show address at TOP
 5: If Driver Enters in his fence then show the Slide to Start Ride Button
 6: If Driver Enters in Destination Fence then show the Slide to End Ride Button
 7: Show Review screen to the
 8: Go back to Step 1
 
 */
@implementation HomeViewController


- (IBAction)didSelectHistoryOption:(id)sender {
    SessionViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SessionViewController"];
    [self presentViewController:nextVC animated:YES completion:nil];
}



- (IBAction)didSelectClientInfoCallButton:(id)sender {
    
    
}
- (IBAction)didSelectAcceptButton:(id)sender {
    [self shouldHideAcceptRejectButton];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldStartAcceptRejectTimer) name:(NSString *)kNewRequestIsArrive object:nil];
    
    
    NSString *notificationName  = [[NSUserDefaults standardUserDefaults]stringForKey:@"Name"];
    NSString *customerID  = [[NSUserDefaults standardUserDefaults]stringForKey:@"CustomerID"];
    NSString * diplayImage = [[NSUserDefaults standardUserDefaults]stringForKey:@"DisplayPicture"];
    _notificaionLabelName.text =notificationName;
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:diplayImage]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.notoficationImage.image = [UIImage imageWithData:data];
            self.notoficationImage.layer.cornerRadius = self.notoficationImage.frame.size.width / 2;
            self.notoficationImage.clipsToBounds = YES;
        });
        
    });
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setOnlineOflineButton];
    [self setBasicUISettings];
    [self getNotificationJson];
    // Do any additional setup after loading the view.
    
    self.mapView.myLocationEnabled = YES;
    self.notificationView.hidden = YES;
    
    
}

-(void)setOnlineOflineButton{
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    CGFloat width = self.view.frame.size.width/3;
    
    onlineOflineButton = [[UIButton alloc]initWithFrame:CGRectMake(width, 10, width, self.navigationController.navigationBar.frame.size.height-10)];
    
    onlineOflineButton.layer.cornerRadius = onlineOflineButton.frame.size.height/2;
    onlineOflineButton.clipsToBounds = YES;
    [self setOnline];
    [onlineOflineButton addTarget:self action:@selector(didSelectOnlineOflineButton) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:onlineOflineButton];
    onlineOflineButton.center = CGPointMake(self.view.frame.size.width/2, self.navigationController.navigationBar.frame.size.height/2);
    
    
    
}
-(void)shouldStartAcceptRejectTimer{
    [self.tabBarController setSelectedIndex:0];
    [UIView animateWithDuration:0.3 animations:^{
        self.requestView.alpha = 1.0;
        self.sliderParentView.alpha = 1.0;
    }];
    
    [self performSelector:@selector(timerIsStartedWithTime:) withObject:[NSNumber numberWithInteger:10] afterDelay:0];
    self.notificationView.hidden = NO;
}
-(void)timerIsStartedWithTime:(NSNumber *)time{
    
    if (time.integerValue < 0) {
        [self shouldHideAcceptRejectButton];
        [self callRejectAPI];
        return;
    }else{
        _timerLabel.text = [NSString stringWithFormat:@"%ld",time.integerValue];
        [self performSelector:@selector(timerIsStartedWithTime:) withObject:[NSNumber numberWithInteger:(time.integerValue - 1)] afterDelay:1];
    }
}
-(void)shouldHideAcceptRejectButton{
    self.notificationView.hidden=YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.requestView.alpha = 0.0;
        self.sliderParentView.alpha = 0.0;
    }];
    
    //Call Reject API
}
-(void)callRejectAPI{
    
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    return CGRectContainsPoint(self.sliderParentView.frame, point);
}
-(void)setOffline{
    
    onlineOflineButton.tag = 1;
      [timer invalidate];
    
    [onlineOflineButton setBackgroundColor:[UIColor whiteColor]];
    [onlineOflineButton setTitle:@"Offline" forState:UIControlStateNormal];
    [onlineOflineButton setTitle:@"Offline" forState:UIControlStateSelected];
    [onlineOflineButton setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    [onlineOflineButton setTitleColor:self.view.tintColor forState:UIControlStateSelected];
    
    if (onlineOflineButton.tag == 1 ) {
        
    }
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
    
    if ([onlineOflineButton tag] == 0){
        
        
        NSString * apiUrl = [NSString stringWithFormat:@"http://narsun.pk/UberTruck/UpdateDriverLocation.php"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:apiUrl]];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet
                                                             setWithObject:@"application/json"];
        
        
        NSString * latitude=[[NSUserDefaults standardUserDefaults]stringForKey:@"driverLatitude1"];
        NSString* logitude = [[NSUserDefaults standardUserDefaults]stringForKey:@"driverLongtitude1"];
        NSString * driverId = [[NSUserDefaults standardUserDefaults]stringForKey:@"DriverId"];
        
        if(latitude.length==0&&logitude.length==0){
            
            latitude = @"32.746087";
            logitude = @"75.2345";
            
        }
        
        NSMutableDictionary* postParameter = @{@"id": driverId, @"lat":latitude,@"lon":logitude,@"avail" : @"1"};
        
        [manager POST:apiUrl parameters:postParameter progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            
            NSLog(@"JSON: %@", responseObject);
            if ([responseObject isKindOfClass:[NSArray class]]) {
                
                
                NSArray * responseArray = responseObject;
            }else if ([responseObject isKindOfClass:[NSDictionary class]]){
                
                NSDictionary * responseDictionary = (NSDictionary *) responseObject;
                
                NSString* suceful = [responseDictionary valueForKey:@"Status"];
                
                NSLog(@"%@",suceful);
                
                if ([suceful isEqualToString:@"Success"]){
                    
                 timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(performBackGround) userInfo:nil repeats:YES];
                    
                }
            }
        }
              failure:^(NSURLSessionTask *operation, NSError *error) {
                  NSLog(@"Error: %@", error);
              }];
    }
    
    
}
-(void)performBackGround{
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Do background work
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showMarkerForDriverThisLocation:currentLocation];
            
        });
    });
}

-(void)didSelectOnlineOflineButton{
    if (onlineOflineButton.tag == 0) {
        [self setOffline];
    }
    else{
        [self setOnline];
    }
}
/*
 -(void)didSelectPanGesture:(UIPanGestureRecognizer *)pan{
 [self.view setNeedsLayout];
 [self.view layoutIfNeeded];
 CGPoint point = [pan translationInView:_sliderView];
 if (point.x > 60 && point.x < (self.sliderView.frame.size.width/4 *3)) {
 _sliderWidth.constant = point.x;
 [self.view layoutIfNeeded];
 }
 if (point.x > (self.sliderView.frame.size.width/4 *3)) {
 [UIView animateWithDuration:0.25 animations:^{
 _sliderWidth.constant = self.sliderView.frame.size.width;
 [self.view layoutIfNeeded];
 
 }];
 }
 if ([pan state] == UIGestureRecognizerStateEnded) {
 
 if (point.x > (self.view.frame.size.width/4 *3)) {
 //
 [_sliderView setUserInteractionEnabled:NO];
 _sliderView.alpha = 0;
 }
 }
 }
 */
-(void)sliderValueChanged:(RSSliderView *)sender{
    
}
-(void)sliderValueChangeEnded:(RSSliderView *)sender{
    
}
-(void)setBasicUISettings{
    //    41.564788, -104.532048
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    startSlider = [[RSSliderView alloc] initWithFrame:CGRectMake(10, 10, self.sliderParentView.frame.size.width-20, 60) andOrientation:Horizontal];
    startSlider.delegate = self;
    [startSlider setColorsForBackground:[UIColor colorWithRed:27.0/255.0 green:28.0/255.0 blue:37.0/255.0 alpha:1.0]
                             foreground:[UIColor colorWithRed:0.0 green:106.0/255.0 blue:95.0/255.0 alpha:1.0]
                                 handle:[UIColor colorWithRed:0.0 green:205.0/255.0 blue:184.0/255.0 alpha:1.0]
                                 border:[UIColor colorWithRed:0.0 green:205.0/255.0 blue:184.0/255.0 alpha:1.0]];
    startSlider.label.text = @"Slide to start ride";
    // default font is Helvetica, size 24, so set font only if you need to change it.
    startSlider.label.font = [UIFont fontWithName:@"Helvetica" size:17];
    startSlider.label.textColor = [UIColor colorWithRed:0.0 green:205.0/255.0 blue:184.0/255.0 alpha:1.0];
    [self.sliderParentView addSubview:startSlider];
    
    completeSlider = [[RSSliderView alloc] initWithFrame:CGRectMake(10, 10, self.sliderParentView.frame.size.width-20, 60) andOrientation:Horizontal];
    completeSlider.delegate = self;
    [completeSlider setColorsForBackground:[UIColor colorWithRed:27.0/255.0 green:28.0/255.0 blue:37.0/255.0 alpha:1.0]
                                foreground:[UIColor colorWithRed:0.0 green:106.0/255.0 blue:95.0/255.0 alpha:1.0]
                                    handle:[UIColor colorWithRed:0.0 green:205.0/255.0 blue:184.0/255.0 alpha:1.0]
                                    border:[UIColor colorWithRed:0.0 green:205.0/255.0 blue:184.0/255.0 alpha:1.0]];
    completeSlider.label.text = @"Slide to start ride";
    // default font is Helvetica, size 24, so set font only if you need to change it.
    completeSlider.label.font = [UIFont fontWithName:@"Helvetica" size:17];
    completeSlider.label.textColor = [UIColor colorWithRed:0.0 green:205.0/255.0 blue:184.0/255.0 alpha:1.0];
    [self.sliderParentView addSubview:completeSlider];
    
    
    completeSlider.alpha = 0;
    startSlider.alpha = 0;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:CLLocationCoordinate2DMake(41.564788, -104.532048) zoom:4];
    _mapView.camera = camera;
    manager = [[CLLocationManager alloc]init];
    manager.delegate = self;
    manager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    manager.distanceFilter = 500; // meters
    
    if ([manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [manager requestWhenInUseAuthorization];
        
    }
    [manager startUpdatingLocation];
    
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    if (locations.count>0) {
        currentLocation = [locations objectAtIndex:0];
        
        NSString*  driverLatitude = [[NSString alloc]initWithFormat:@"%f",currentLocation.coordinate.latitude ];
        NSString*  driverLongtitude = [[NSString alloc]initWithFormat:@"%f",currentLocation.coordinate.longitude ];
        
        [[NSUserDefaults standardUserDefaults]setValue:driverLatitude forKey:@"driverLatitude1"];
        [[NSUserDefaults standardUserDefaults]setValue:driverLongtitude forKey:@"driverLongtitude1"];
        
        [self.mapView clear];
        [self showMarkerForDriverThisLocation:currentLocation];
        
    }
    
}

-(void)showMarkerForDriverThisLocation:(CLLocation *)location {
    GMSMarker *marker = [[GMSMarker alloc]init];
    marker.position = location.coordinate;
    marker.icon = [UIImage imageNamed:@"Daala"];
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = _mapView;
    [_mapView animateToLocation:location.coordinate];
    [_mapView animateToZoom:15];
}


//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//
//     [self.mapView clear];
//
//    if([keyPath isEqualToString:@"myLocation"]){
//        CLLocation * location = [object myLocation];
//
//        CLLocationCoordinate2D target = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
//
//        GMSMarker * marker = [[GMSMarker alloc]init];
//        marker.position = target;
//        marker.title = @"current Location";
//        marker.icon = [UIImage imageNamed:@"dala1"];
//        marker.appearAnimation = kGMSMarkerAnimationPop;
//        marker.map = self.mapView;
//
//
//        [self.mapView animateToLocation:target];
//        [self.mapView animateToZoom:17];
//
//
//    }
//
//}

-(void) getNotificationJson{
    
    NSString * apiUrl = [NSString stringWithFormat:@"http://narsun.pk/UberTruck/AddUpdateDriverGCM.php"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:apiUrl]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet
                                                         setWithObject:@"application/json"];
    
    NSString *token =[[NSUserDefaults standardUserDefaults]
                      stringForKey:@"Token"];
    if (token.length==0) {
        token= @"fcm";
    }
    
    NSString * driverId = [[NSUserDefaults standardUserDefaults]stringForKey:@"DriverId"];
    NSMutableDictionary * psotParameter = @{@"did": driverId, @"gcm":token,@"d_type":@"iOS"};
    
    [manager POST:@"http://narsun.pk/UberTruck/AddUpdateDriverGCM.php" parameters:psotParameter progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        
        NSLog(@"JSON: %@", responseObject);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            
            
            NSArray * responseArray = responseObject;
        }else if ([responseObject isKindOfClass:[NSDictionary class]]){
            
            [[IGAlertView sharedAlertView] removeAlertWithAnimation];
            
            
        }
    }
          failure:^(NSURLSessionTask *operation, NSError *error) {
              
              [[IGAlertView sharedAlertView] removeAlertWithAnimation];
              
              UIAlertView *alertView = [[UIAlertView
                                         alloc]initWithTitle:@"Instagruas" message:@"Connect With Server" delegate:nil
                                        cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
              
              [alertView show];
              
              NSLog(@"Error: %@", error);
          }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
