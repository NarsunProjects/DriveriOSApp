//
//  LoginViewController.m
//  Instagruas
//
//  Created by NARSUN-MAC-01 on 20/12/2016.
//  Copyright © 2016 NARSUN-MAC-01. All rights reserved.
//

#import "LoginViewController.h"
#import "InstagruasStrings.h"
#import "AppDelegate.h"
#import "IGNetworkManager.h"
#import "IGAlertView.h"
#import "AFNetworking.h"
#import "Constants.h"
#import "ParserLoginData.h"
#import "AccountViewController.h"

@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property(strong,nonatomic) ParserLoginData * pl;
@property(strong,nonatomic) ParserLoginData * pld;



@end

@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
}

-(void)setStringForAllViews{
    [_loginButton setTitle:[InstagruasStrings getLoginString] forState:UIControlStateNormal];
    [_loginButton setTitle:[InstagruasStrings getLoginString] forState:UIControlStateSelected];
    
   
    _emailTextField.placeholder = [InstagruasStrings getEmailString];
    _passwordTextField.placeholder = [InstagruasStrings getPasswordString];
}
-(void)setBasicUISettings{
    _emailTextField.text = @"betatest@gmail.com";
    _passwordTextField.text = @"123456";
    _loginButton.layer.cornerRadius = 25;
    _loginButton.clipsToBounds = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStringForAllViews];
    [self setBasicUISettings];
   // [self getJasonData];
    
    _pl = [[ParserLoginData alloc]init];
    _pld = [[ParserLoginData alloc]init];
    
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getJasonData{
    _email = _emailTextField.text;
    _password = _passwordTextField.text;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"email" : self.email,
                             @"password": self.password};
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:@"http://narsun.pk/InstaGruas/public/api/login" parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        
        NSLog(@"JSON: %@", responseObject);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            
            NSArray * responseArray = responseObject;
        }else if ([responseObject isKindOfClass:[NSDictionary class]]){
        
            NSDictionary * responseDictionary = (NSDictionary *) responseObject;
            [self parserResponse:responseDictionary];
            [[IGAlertView sharedAlertView] removeAlertWithAnimation];
            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            IGUser * userObj;
            delegate.userObject = userObj;
            [delegate userDidLoggedIn];
        
        }
    }
          failure:^(NSURLSessionTask *operation, NSError *error) {
              
              
              [[IGAlertView sharedAlertView] removeAlertWithAnimation];
              UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Instagruas - Driver" message:@"Threr is Problem with Internet or Server" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
              [alertView show];
              NSLog(@"Error: %@", error);
          }];
}


- (IBAction)didSelectLoginButton:(id)sender {
    
    
    if (_emailTextField.text.length == 0) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Instagruas - Driver" message:@"Please Enter your email." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    if (_emailTextField.text.length == 0) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Instagruas - Driver" message:@"Please Enter your password." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    [[IGAlertView sharedAlertView] showAlertWithAnimation];
    

    _email = _emailTextField.text;
    _password = _passwordTextField.text;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"email" : self.email,
                             @"password": self.password};
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:@"http://narsun.pk/InstaGruas/public/api/login" parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        
        NSLog(@"JSON: %@", responseObject);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            
            NSArray * responseArray = responseObject;
        }else if ([responseObject isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * responseDictionary = (NSDictionary *) responseObject;
            [self parserResponse:responseDictionary];
            [[IGAlertView sharedAlertView] removeAlertWithAnimation];
            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            IGUser * userObj;
            delegate.userObject = userObj;
            [delegate userDidLoggedIn];
            
        }
    }
          failure:^(NSURLSessionTask *operation, NSError *error) {
              
              
              [[IGAlertView sharedAlertView] removeAlertWithAnimation];
              UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Instagruas - Driver" message:@"Failed To Establish Connection" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
              [alertView show];
              NSLog(@"Error: %@", error);
          }];
    

//    [IGNetworkManager driverRequestLogInWithParam:@{@"email":_emailTextField.text , @"password":_passwordTextField.text} success:^(IGUser *userObj){
//        [[IGAlertView sharedAlertView] removeAlertWithAnimation];
//        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        delegate.userObject = userObj;
//        [delegate userDidLoggedIn];
//    } failure:^(NSString *failure){
//        [[IGAlertView sharedAlertView] removeAlertWithAnimation];
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Instagruas - Driver" message:failure delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
//        [alertView show];
//    
//    } apiFailure:^(NSError *error){
//        [[IGAlertView sharedAlertView] removeAlertWithAnimation];
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Instagruas - Driver" message:@"Failed to estabilish a connection" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
//        [alertView show];
//    }];
    
}

-(void)parserResponse :(NSDictionary*) responseDictionary{
    
    
    
    id dataArray = [responseDictionary valueForKey:@"data"];
    
    
    NSLog(@"%@",dataArray);
    
    //  ParserLoginData * pl = [[ParserLoginData alloc]init];
    
    _pl.h_Address = [dataArray valueForKey:@"Address"];
    _pl.h_CURP = [dataArray valueForKey:@"CURP"];
    _pl.h_dataDisplayPicture = [dataArray valueForKey:@"DisplayPicture"];
    _pl.h_DriverId = [dataArray valueForKey:@"DriverId"];
    _pl.h_Email = [dataArray valueForKey:@"Email"];
    _pl.h_Gender = [dataArray valueForKey:@"Gender"];
    _pl.h_dataName = [dataArray valueForKey:@"Name"];
    _pl.h_dataPhone = [dataArray valueForKey:@"Phone"];
    _pl.h_RFC = [dataArray valueForKey:@"RFC"];
    _pl.h_dob = [dataArray valueForKey:@"dob"];
    _pl.h_liscenseno = [dataArray valueForKey:@"liscenseno"];
    _pl.h_datarating = [dataArray valueForKey:@"rating"];
    _pl.h_status = [dataArray valueForKey:@"status"];
    _pl.h_updated_at = [dataArray valueForKey:@"updated_at"];
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:self.pl.h_DriverId forKey:@"DriverId"];
    
    
    NSArray *request = [responseDictionary valueForKey:@"request"];
    
    for (int i=0; i<request.count; i++) {
        
        id req1 = [request objectAtIndex:i];
        
        // ParserLoginData * pld1 = [[ParserLoginData alloc]init];
        
        
        _pld.h_CustomerID = [req1 valueForKey:@"CustomerID"];
        _pld.h_Description = [req1 valueForKey:@"Description"];
        _pld.h_reqDisplayPicture = [req1 valueForKey:@"DisplayPicture"];
        _pld.h_Distance = [req1 valueForKey:@"Distance"];
        _pld.h_EndAddress = [req1 valueForKey:@"EndAddress"];
        _pld.h_Maker = [req1 valueForKey:@"Maker"];
        _pld.h_Model = [req1 valueForKey:@"Model"];
        _pld.h_reqName  = [req1 valueForKey:@"Name "];
        _pld.h_reqPhone = [req1 valueForKey:@"Phone"];
        _pld.h_reqRating = [req1 valueForKey:@"Rating"];
        _pld.h_RequestId = [req1 valueForKey:@"RequestId"];
        _pld.h_RequestStatus = [req1 valueForKey:@"RequestStatus"];
        _pld.h_StartAddress = [req1 valueForKey:@"StartAddress"];
        _pld.h_TOR = [req1 valueForKey:@"TOR"];
        _pld.h_Year = [req1 valueForKey:@"Year"];
        _pld.h_end_latitude = [req1 valueForKey:@"end_latitude"];
        _pld.h_end_longitude = [req1 valueForKey:@"end_longitude"];
        _pld.h_latitude = [req1 valueForKey:@"latitude"];
        _pld.h_longitude = [req1 valueForKey:@"longitude"];
        
        
        NSLog(@"%@",[req1 valueForKey:@"end_latitude"]);
        NSLog(@"%@",_pld.h_Distance);
        
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        
        [userDefaults setObject:self.pld.h_reqPhone forKey:@"reqPhn"];
        [userDefaults setObject:self.pl.h_liscenseno forKey:@"LiscenseNo"];
        [userDefaults setObject:self.pl.h_dataName forKey:@"Name"];
        [userDefaults setObject:self.pl.h_Email forKey:@"Email"];
        [userDefaults setInteger:self.pld.h_reqRating forKey:@"Rating"];
        [userDefaults setObject:self.pld.h_CustomerID forKey:@"Customer"];
        [userDefaults setObject:_pld.h_end_latitude forKey:@"latitude"];
        [userDefaults setObject:_pld.h_end_longitude forKey:@"longtiude"];
        
        [userDefaults synchronize];
        
        
    }
    
    NSLog(@"%@",_pld.h_reqPhone);
    
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
