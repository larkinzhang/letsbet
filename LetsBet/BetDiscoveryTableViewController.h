//
//  BetDiscoveryTableViewController.h
//  LetsBet
//
//  Created by 张亦弛 on 14-5-19.
//  Copyright (c) 2014年 Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BetLoginViewController.h"
#import "DiscoveryTableViewCell.h"
#import "BetLoginViewController.h"
#import "BetInfo.h"
#import "showDetailsViewController.h"

@interface BetDiscoveryTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *betList;
@property (nonatomic, strong) NSString *userName;

@end
