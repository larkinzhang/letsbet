//
//  BetAddViewController.h
//  LetsBet
//
//  Created by 张亦弛 on 14-5-25.
//  Copyright (c) 2014年 Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BetAddViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate>

@property(nonatomic, weak) IBOutlet UIScrollView * myScrollView;
@property(nonatomic) CGFloat oldContentOffsetValue;

@property(nonatomic, weak) IBOutlet UISegmentedControl *segmentedControl1;
@property(nonatomic, weak) IBOutlet UISegmentedControl *segmentedControl2;

@property(nonatomic, weak) IBOutlet UITextField *renrenTextField1;
@property(nonatomic, weak) IBOutlet UITextField *renrenTextField2;

@property(nonatomic, weak) IBOutlet UITextField *betNameTextField;

@property(nonatomic, weak) IBOutlet UITextField *sideATextField;
@property(nonatomic, weak) IBOutlet UITextField *sideBTextField;

@property(nonatomic) BOOL keyboardShown;
@property(nonatomic) BOOL isNeedSetOffset;

@property (nonatomic,retain) UITextField * activeField;

@property int size;
@property (copy) void(^callback)(NSMutableDictionary *value1);


- (IBAction)toggleControls1:(id)sender;
- (IBAction)toggleControls2:(id)sender;
- (IBAction)pushCancel:(id)sender;

@end
