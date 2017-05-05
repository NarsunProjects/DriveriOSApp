//
//  NotificationAccpectViewController.m
//  Instagruas
//
//  Created by Mudassar on 03/02/2017.
//  Copyright © 2017 Narsun. All rights reserved.
//

#import "NotificationAccpectViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "HCSStarRatingView.h"
#import "SessionViewController.h"
#import "AFNetworking.h"
#import "RSSliderView.h"
#import "RSSliderViewTwo.h"
#import "RatingViewController.h"
#import "ClientRatingViewController.h"
@import GoogleMaps;

@interface NotificationAccpectViewController ()<CLLocationManagerDelegate,GMSMapViewDelegate>{
    UIButton *onlineOflineButton;
    CLLocation *currentLocation;
    CLLocationManager *manager;
    RSSliderView* startSlider ;
    RSSliderViewTwo * compSlider;
    
}

@property (strong, nonatomic) IBOutlet GMSMapView *mapView;
@property (strong, nonatomic) IBOutlet UILabel *adressLabel;
@property (strong, nonatomic) IBOutlet UIImageView *notificationImage;
@property (strong, nonatomic) IBOutlet UILabel *notificationName;
@property (strong, nonatomic) IBOutlet UILabel *notificationNumber;
@property (strong, nonatomic) IBOutlet UILabel *notoficationRate;
@property (strong, nonatomic) IBOutlet HCSStarRatingView *rateingView;
@property (strong, nonatomic) IBOutlet UIView *notificationParentView;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) IBOutlet UIView *driverDetailsView;



@end

@implementation NotificationAccpectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setOnlineOflineButton];
    [self setGoogleMap];
    //[self setSlider];
    // [self shouldStartSlider];// this funcation should call when the driver and client destenation same.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    NSString * Address = [[NSUserDefaults standardUserDefaults]stringForKey:@"StartAddress"];
    NSString * Image = [[NSUserDefaults standardUserDefaults]stringForKey:@"DisplayPicture"];
    NSString * Name = [[NSUserDefaults standardUserDefaults]stringForKey:@"Name"];
    NSString * Number = [[NSUserDefaults standardUserDefaults]stringForKey:@"Phone"];
    NSString * RateNumber = [[NSUserDefaults standardUserDefaults]stringForKey:@"Rating"];
    
    self.adressLabel.text = Address;
    self.notificationName.text = Name;
    self.notificationNumber.text = Number;
    self.notoficationRate.text=RateNumber;
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:Image]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.notificationImage.image = [UIImage imageWithData:data];
            self.notificationImage.layer.cornerRadius = self.notificationImage.frame.size.width / 2;
            self.notificationImage.clipsToBounds = YES;
        });
        
    });
}


#pragma marks Button On the Top OF Every Screen
-(void)setOnlineOflineButton{
    
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


-(void)setGoogleMap{
    
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
        
#pragma marks Current Driver Location
        currentLocation = [locations objectAtIndex:0];
        CLLocationDegrees currentLat = currentLocation.coordinate.latitude;
        CLLocationDegrees currentLon = currentLocation.coordinate.longitude;
        CLLocationCoordinate2D cureentLocation = CLLocationCoordinate2DMake(currentLat, currentLon);
        [self.mapView clear];
        [self showMarkerForDriverThisLocation:currentLocation];
        
#pragma marks Client Location
        NSString * latClient = [[NSUserDefaults standardUserDefaults]stringForKey:@"latitude"];
        NSString * lonClient = [[NSUserDefaults standardUserDefaults]stringForKey:@"longitude"];
        CLLocation *detination = [[CLLocation alloc] initWithLatitude:[latClient doubleValue] longitude:[lonClient doubleValue]];
        CLLocationDegrees desLat = detination.coordinate.latitude;
        CLLocationDegrees desLog = detination.coordinate.longitude;
        CLLocationCoordinate2D clientDestion = CLLocationCoordinate2DMake(desLat, desLog);
        
#pragma marks show marks on Client Location
        GMSMarker *marker = [[GMSMarker alloc]init];
        marker.position = detination.coordinate;
        marker.icon = [UIImage imageNamed:@"orange"];
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.map = _mapView;
        [_mapView animateToLocation:detination.coordinate];
        
#pragma  marks Find distance b/w two location
       // [self findDistanceBetweenOrigin:cureentLocation andDestination:clientDestion];
        [self redSlider];
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

-(void)findDistanceBetweenOrigin:(CLLocationCoordinate2D)origin andDestination:(CLLocationCoordinate2D)destination{
    
    
    CLLocation *originLoc = [[CLLocation alloc]initWithLatitude:origin.latitude longitude:origin.longitude];
    CLLocation *destinationLoc = [[CLLocation alloc]initWithLatitude:destination.latitude longitude:destination.longitude];
    
    NSString *urlString =@"https://maps.googleapis.com/maps/api/directions/json";
    NSDictionary *dictParameters = @{@"origin" : [NSString stringWithFormat:@"%f,%f",originLoc.coordinate.latitude,originLoc.coordinate.longitude], @"destination" : [NSString stringWithFormat:@"%f,%f",destinationLoc.coordinate.latitude,destinationLoc.coordinate.longitude], @"mode":@"", @"key":@"AIzaSyD8vcL4XRu-66cj-CUZ8hEboqvnK_0BX3s"};
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [manager GET:urlString parameters:dictParameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        NSString * status = responseObject[@"status"];
        if (![status isEqualToString:@"OK"]) {
            
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"Instagruas" message:@"Fail to calculate distance. May be you have chosen the same address for destination and origin" delegate:nil cancelButtonTitle:@"Cancle" otherButtonTitles:nil, nil];
            [alertView show];
            return ;
        }
        
        NSDictionary *arr=responseObject[@"routes"][0][@"legs"];
        NSMutableArray * loc = [[NSMutableArray alloc]init];
        
        loc = [[arr valueForKey:@"start_location"]valueForKey:@"lat"];
        double oLat=[loc[0] doubleValue];
        
        loc=[[arr valueForKey:@"start_location"]valueForKey:@"lng"];
        double oLon=[loc[0] doubleValue];
        
        loc=[[arr valueForKey:@"end_location"]valueForKey:@"lat"];
        double dLat=[loc[0] doubleValue];
        
        loc=[[arr valueForKey:@"end_location"]valueForKey:@"lng"];
        double dLon=[loc[0] doubleValue];
        
        CLLocation *origLoc = [[CLLocation alloc]initWithLatitude:oLat longitude:oLon];
        CLLocation *destLoc = [[CLLocation alloc]initWithLatitude:dLat longitude:dLon];
        NSString *dis,*dur;
        loc=[[arr valueForKey:@"distance"]valueForKey:@"text"];
        dis=loc[0];
        
        loc=[[arr valueForKey:@"duration"]valueForKey:@"text"];
        dur=loc[0];
        
        NSLog(@"Distance = %@",dis);
        NSLog(@"Duration = %@",dur);
        NSString *sa,*da;
        loc=[arr valueForKey:@"start_address"];
        
        sa=loc[0];
        
        NSArray *array = [dis componentsSeparatedByString:@" "];
        NSString *distance = [array objectAtIndex:0];
        
        NSString *distanceFactor = [array objectAtIndex:1];
        loc=[arr valueForKey:@"end_address"];
        da=loc[0];
        
        
        NSString *baseUrl = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&sensor=false", origin, destination];
        
        NSURL *url = [NSURL URLWithString:[baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        NSLog(@"Url: %@", url);
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError *connectionError) {
            
            GMSMutablePath *path = [GMSMutablePath path];
            
            NSError *error = nil;
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            NSArray *routes = [result objectForKey:@"routes"];
            
            
            NSDictionary *firstRoute = [routes objectAtIndex:0];
            
            NSDictionary *leg =  [[firstRoute objectForKey:@"legs"] objectAtIndex:0];
            
            NSArray *steps = [leg objectForKey:@"steps"];
            
            int stepIndex = 0;
            
            CLLocationCoordinate2D stepCoordinates[1  + [steps count] + 1];
            
            for (NSDictionary *step in steps) {
                
                NSDictionary *start_location = [step objectForKey:@"start_location"];
                stepCoordinates[++stepIndex] = [self coordinateWithLocation:start_location];
                [path addCoordinate:[self coordinateWithLocation:start_location]];
                
                NSString *polyLinePoints = [[step objectForKey:@"polyline"] objectForKey:@"points"];
                GMSPath *polyLinePath = [GMSPath pathFromEncodedPath:polyLinePoints];
                for (int p=0; p<polyLinePath.count; p++) {
                    [path addCoordinate:[polyLinePath coordinateAtIndex:p]];
                }
                
                
                if ([steps count] == stepIndex){
                    NSDictionary *end_location = [step objectForKey:@"end_location"];
                    stepCoordinates[++stepIndex] = [self coordinateWithLocation:end_location];
                    [path addCoordinate:[self coordinateWithLocation:end_location]];
                }
            }
            
            GMSPolyline *polyline = nil;
            polyline = [GMSPolyline polylineWithPath:path];
            polyline.strokeColor = [UIColor redColor];
            polyline.strokeWidth = 4.f;
            polyline.map = self.mapView;
            
            // this is call when the distance less than 40 meters .
            //                    double distanceMeter =[distance intValue] * 1000;
            //                    if (distanceMeter<=40.00) {
            //                        [self setSlider];
            //                    }
            
            [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(performBackGround) userInfo:nil repeats:NO];
            
        }];
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
    
}
-(CLLocationCoordinate2D)coordinateWithLocation:(NSDictionary*)location
{
    double latitude = [[location objectForKey:@"lat"] doubleValue];
    double longitude = [[location objectForKey:@"lng"] doubleValue];
    
    return CLLocationCoordinate2DMake(latitude, longitude);
}
-(void)performBackGround{
    
    [self setSlider];
    
}

#pragma Marks it should be call when the driver and client destenation same.

-(void)setSlider {
    self.driverDetailsView.alpha=0;
    [self.mapView clear];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    startSlider = [[RSSliderView alloc] initWithFrame:CGRectMake(5, self.view.frame.size.width-115, self.view.frame.size.width-10, 80) andOrientation:Horizontal];
    startSlider.delegate = self;
    [startSlider setColorsForBackground:[UIColor colorWithRed:27.0/255.0 green:230.0/255.0 blue:100.0/255.0 alpha:1.0]
                             foreground:[UIColor colorWithRed:0.0 green:106.0/255.0 blue:95.0/255.0 alpha:1.0]
                                 handle:[UIColor colorWithRed:0.0 green:205.0/255.0 blue:184.0/255.0 alpha:1.0]
                                 border:[UIColor colorWithRed:0.0 green:205.0/255.0 blue:184.0/255.0 alpha:1.0]];
    startSlider.label.text = @"Start Slider";
    startSlider.labelTwo.text= @"You,ve Arrived Your Destination";
    // default font is Helvetica, size 24, so set font only if you need to change it.
    startSlider.label.font = [UIFont fontWithName:@"Helvetica" size:17];
    startSlider.labelTwo.font = [UIFont fontWithName:@"Helvetica" size:16];
    startSlider.label.textColor = [UIColor colorWithRed:0.0 green:205.0/255.0 blue:184.0/255.0 alpha:1.0];
    [self.view addSubview:startSlider];
    
}
-(void)sliderValueChanged:(RSSliderView *)sender {
    NSLog(@"Value Changed: %f", sender.value);
    
}

-(void)sliderValueChangeEnded:(RSSliderView *)sender {
    NSLog(@"Touсh ended: %f", sender.value);
    //call when find the current location of client and the location where client want to go .
    if (sender.value>=0.90){
        startSlider.alpha=0;
        [self clientCurrentPostionToArrivedPostion];
        
    }
#pragma Marks THis condition Take Back The Slider if value less then 90 .
    if (sender.value<=0.89) {
        [self setSlider];
    }
    
    
}

-(void)clientCurrentPostionToArrivedPostion{
    startSlider.alpha=0;
    
    //client Current location
    NSString * latClient = [[NSUserDefaults standardUserDefaults]stringForKey:@"latitude"];
    NSString * lonClient = [[NSUserDefaults standardUserDefaults]stringForKey:@"longitude"];
    CLLocation *detination = [[CLLocation alloc] initWithLatitude:[latClient doubleValue] longitude:[lonClient doubleValue]];
    CLLocationDegrees desLat = detination.coordinate.latitude;
    CLLocationDegrees desLog = detination.coordinate.longitude;
    CLLocationCoordinate2D clientDestion = CLLocationCoordinate2DMake(desLat, desLog);
    //show marker on client current position.
    [self showMarkerForDriverThisLocation:detination];
    
    // Postion Where Client Want To go .
    
    NSString * arrivedLat = [[NSUserDefaults standardUserDefaults]stringForKey:@"end_latitude"];
    NSString * arrivedLog = [[NSUserDefaults standardUserDefaults]stringForKey:@"end_longitude"];
    CLLocation *arriveLocation = [[CLLocation alloc]initWithLatitude:[arrivedLat doubleValue] longitude:[arrivedLog doubleValue]];
    CLLocationDegrees arrLat = arriveLocation.coordinate.latitude;
    CLLocationDegrees arrLog = arriveLocation.coordinate.longitude;
    CLLocationCoordinate2D arrivedDestion = CLLocationCoordinate2DMake(arrLat, arrLog);
    
    
    GMSMarker *marker = [[GMSMarker alloc]init];
    marker.position = arriveLocation.coordinate;
    marker.icon = [UIImage imageNamed:@"orange"];
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = _mapView;
    [_mapView animateToLocation:detination.coordinate];
    
    // call when to find distance between client current postion and the postion where client want to go .
    [self findDistanceBetweenclientAndDes:clientDestion andDestination:arrivedDestion];
    
    
}
-(void)findDistanceBetweenclientAndDes:(CLLocationCoordinate2D)origin andDestination:(CLLocationCoordinate2D)destination{
    
    
    CLLocation *originLoc = [[CLLocation alloc]initWithLatitude:origin.latitude longitude:origin.longitude];
    CLLocation *destinationLoc = [[CLLocation alloc]initWithLatitude:destination.latitude longitude:destination.longitude];
    
    NSString *urlString =@"https://maps.googleapis.com/maps/api/directions/json";
    NSDictionary *dictParameters = @{@"origin" : [NSString stringWithFormat:@"%f,%f",originLoc.coordinate.latitude,originLoc.coordinate.longitude], @"destination" : [NSString stringWithFormat:@"%f,%f",destinationLoc.coordinate.latitude,destinationLoc.coordinate.longitude], @"mode":@"", @"key":@"AIzaSyD8vcL4XRu-66cj-CUZ8hEboqvnK_0BX3s"};
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [manager GET:urlString parameters:dictParameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        NSString * status = responseObject[@"status"];
        if (![status isEqualToString:@"OK"]) {
            
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"Instagruas" message:@"Fail to calculate distance. May be you have chosen the same address for destination and origin" delegate:nil cancelButtonTitle:@"Cancle" otherButtonTitles:nil, nil];
            [alertView show];
            return ;
        }
        
        NSDictionary *arr=responseObject[@"routes"][0][@"legs"];
        NSMutableArray * loc = [[NSMutableArray alloc]init];
        
        loc = [[arr valueForKey:@"start_location"]valueForKey:@"lat"];
        double oLat=[loc[0] doubleValue];
        
        loc=[[arr valueForKey:@"start_location"]valueForKey:@"lng"];
        double oLon=[loc[0] doubleValue];
        
        loc=[[arr valueForKey:@"end_location"]valueForKey:@"lat"];
        double dLat=[loc[0] doubleValue];
        
        loc=[[arr valueForKey:@"end_location"]valueForKey:@"lng"];
        double dLon=[loc[0] doubleValue];
        
        CLLocation *origLoc = [[CLLocation alloc]initWithLatitude:oLat longitude:oLon];
        CLLocation *destLoc = [[CLLocation alloc]initWithLatitude:dLat longitude:dLon];
        NSString *dis,*dur;
        loc=[[arr valueForKey:@"distance"]valueForKey:@"text"];
        dis=loc[0];
        
        loc=[[arr valueForKey:@"duration"]valueForKey:@"text"];
        dur=loc[0];
        
        NSLog(@"Distance = %@",dis);
        NSLog(@"Duration = %@",dur);
        NSString *sa,*da;
        loc=[arr valueForKey:@"start_address"];
        
        sa=loc[0];
        
        NSArray *array = [dis componentsSeparatedByString:@" "];
        NSString *distance = [array objectAtIndex:0];
        
        NSString *distanceFactor = [array objectAtIndex:1];
        loc=[arr valueForKey:@"end_address"];
        da=loc[0];
        
        
        
        
        NSString *baseUrl = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&sensor=false", origin, destination];
        
        NSURL *url = [NSURL URLWithString:[baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        NSLog(@"Url: %@", url);
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError *connectionError) {
            
            GMSMutablePath *path = [GMSMutablePath path];
            
            NSError *error = nil;
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            NSArray *routes = [result objectForKey:@"routes"];
            
            
            NSDictionary *firstRoute = [routes objectAtIndex:0];
            
            NSDictionary *leg =  [[firstRoute objectForKey:@"legs"] objectAtIndex:0];
            
            NSArray *steps = [leg objectForKey:@"steps"];
            
            int stepIndex = 0;
            
            CLLocationCoordinate2D stepCoordinates[1  + [steps count] + 1];
            
            for (NSDictionary *step in steps) {
                
                NSDictionary *start_location = [step objectForKey:@"start_location"];
                stepCoordinates[++stepIndex] = [self coordinateWithLocation:start_location];
                [path addCoordinate:[self coordinateWithLocation:start_location]];
                
                NSString *polyLinePoints = [[step objectForKey:@"polyline"] objectForKey:@"points"];
                GMSPath *polyLinePath = [GMSPath pathFromEncodedPath:polyLinePoints];
                for (int p=0; p<polyLinePath.count; p++) {
                    [path addCoordinate:[polyLinePath coordinateAtIndex:p]];
                }
                
                
                if ([steps count] == stepIndex){
                    NSDictionary *end_location = [step objectForKey:@"end_location"];
                    stepCoordinates[++stepIndex] = [self coordinateWithLocation:end_location];
                    [path addCoordinate:[self coordinateWithLocation:end_location]];
                }
            }
            
            GMSPolyline *polyline = nil;
            polyline = [GMSPolyline polylineWithPath:path];
            polyline.strokeColor = [UIColor redColor];
            polyline.strokeWidth = 4.f;
            polyline.map = self.mapView;
            
            // this is call when the distance less than 40 meters .
            //                    double distanceMeter =[distance intValue] * 1000;
            //                    if (distanceMeter<=40.00) {
            //                        [self redSlider];
            //                    }
            
            [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(performBackGroundTWO) userInfo:nil repeats:NO];
            
        }];
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

-(void)performBackGroundTWO{
    [self redSlider];
}

-(void)redSlider{
    startSlider.alpha=0;
    [self.mapView clear];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    float Y_Co = self.view.frame.size.height - 115;
    
    compSlider = [[RSSliderViewTwo alloc] initWithFrame:CGRectMake(5,Y_Co, self.view.frame.size.width-10, 80) andOrientation:HorizontalOne];
    
    compSlider.delegate = self;
    [compSlider setColorsForBackground:[UIColor colorWithRed:253.0/255.0 green:23.0/255.0 blue:37.0/255.0 alpha:1.0]
                            foreground:[UIColor colorWithRed:0.0 green:106.0/255.0 blue:95.0/255.0 alpha:1.0]
                                handle:[UIColor colorWithRed:0.0 green:205.0/255.0 blue:184.0/255.0 alpha:1.0]
                                border:[UIColor colorWithRed:0.0 green:205.0/255.0 blue:184.0/255.0 alpha:1.0]];
    compSlider.label.text = @"Tap To Finish";
    compSlider.labelTwo.text = @"You,ve Arrived Your Destination";
    // default font is Helvetica, size 24, so set font only if you need to change it.
    compSlider.label.font = [UIFont fontWithName:@"Helvetica" size:17];
    compSlider.labelTwo.font = [UIFont fontWithName:@"Helvetica" size:16];
    compSlider.label.textColor = [UIColor colorWithRed:0.0 green:205.0/255.0 blue:184.0/255.0 alpha:1.0];
    [self.view addSubview:compSlider];
    
}
-(void)sliderValueChangedTwo:(RSSliderView *)sender {
    NSLog(@"Value Changed: %f", sender.value);
    
}

-(void)sliderValueChangeEndedTwo:(RSSliderView *)sender {
    NSLog(@"Value Changed: %f", sender.value);
    if (sender.value>=0.90) {
#pragma Marks When Ride Finsh .it takes to the Rating Screen.
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        _tabBarController = [storyboard instantiateViewControllerWithIdentifier:@"ClientRatingViewController"];
        [self.navigationController pushViewController:_tabBarController animated:YES];
      
        
    }else{
        
        [self redSlider];
    }
}




- (IBAction)didSelectHistoryOption:(id)sender {
    
    SessionViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SessionViewController"];
    [self presentViewController:nextVC animated:YES completion:nil];
}


- (IBAction)CallButton:(id)sender {
    
    
    NSString * Number = [[NSUserDefaults standardUserDefaults]stringForKey:@"Phone"];
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",Number]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Alert"
                                              message:@"Call facility is not available!!!"
                                              preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel action");
                                       }];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"OK action");
                                   }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}


@end
