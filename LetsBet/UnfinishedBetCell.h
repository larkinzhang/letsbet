//
//  UnfinishedBetCell.h
//  LetsBet
//
//  Created by PlutoShe on 8/10/14.
//  Copyright (c) 2014 Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>
/*创建关于未完成列表的表单单元*/
@interface UnfinishedBetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *partyLabel;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;
@property (weak, nonatomic) IBOutlet UILabel *remain;
@property (weak, nonatomic) IBOutlet UILabel *penalty;

@end
