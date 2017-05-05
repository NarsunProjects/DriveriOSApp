//
//  SessionViewController.h
//  AppTutor
//
//  Created by NARSUN-MAC-01 on 25/11/2016.
//  Copyright © 2016 Syed Qamar Abbas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SessionViewController : UIViewController<UITableViewDelegate , UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *loadingView;

@end
