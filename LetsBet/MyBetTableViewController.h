//
//  MyBetTableViewController.h
//  LetsBet
//
//  Created by 张亦弛 on 14-5-19.
//  Copyright (c) 2014年 Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BetInfo.h"
#import "MyBetTableViewCell.h"
#import "showDetailsViewController.h"

@interface MyBetTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
- (IBAction)refresh:(id)sender;

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSMutableArray *userList, *confirmList;

@end
