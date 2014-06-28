//
//  BetAddTableViewController.h
//  LetsBet
//
//  Created by 张亦弛 on 14-6-28.
//  Copyright (c) 2014年 Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BetAddTableViewCell.h"
#import "BetAddSwitchTableViewCell.h"

@interface BetAddTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sendButton;

@property (weak, nonatomic) IBOutlet UITextField *betNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *sideATextField;
@property (weak, nonatomic) IBOutlet UITextField *sideBTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl1;
@property (weak, nonatomic) IBOutlet UITextField *renrenTextField1;
@property (weak, nonatomic) IBOutlet UITextField *renrenTextField2;



@end
