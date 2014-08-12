//
//  UnfinishedBetViewController.h
//  LetsBet
//
//  Created by PlutoShe on 8/10/14.
//  Copyright (c) 2014 Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BetInfo.h"
#import "UnfinishedBetCell.h"
#import "showDetailsViewController.h"


@interface UnfinishedBetViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>
- (IBAction)refresh:(id)sender;

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSMutableArray *userList, *confirmList;

@end
