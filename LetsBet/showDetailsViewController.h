//
//  showDetailsViewController.h
//  ShowDetails
//
//  Created by Zhengjie Miao on 14-5-25.
//  Copyright (c) 2014年 Zhengjie Miao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface showDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sideALabel;
@property (weak, nonatomic) IBOutlet UILabel *sideADetailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *sideBLabel;
@property (weak, nonatomic) IBOutlet UILabel *sideBDetailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *sideATitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sideBTitleLabel;

@property (nonatomic, strong) NSString *titleString, *sideAString, *sideBString, *sideADetailString, *sideBDetailString, *sideATitleString, *sideBTitleString;
@property (nonatomic) NSUInteger sideAPopulation;
@property (nonatomic) NSUInteger sideBPopulation;
@property (nonatomic) NSInteger idBets;

- (IBAction)sideAJoinButton:(id)sender;
- (IBAction)sideBJoinButton:(id)sender;

@end
