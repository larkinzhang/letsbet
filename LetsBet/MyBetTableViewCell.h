//
//  MyBetTableViewCell.h
//  LetsBet
//
//  Created by 张亦弛 on 14-5-25.
//  Copyright (c) 2014年 Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBetTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *starterLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIButton *VoteA;
@property (weak, nonatomic) IBOutlet UIButton *VoteB;

@end
