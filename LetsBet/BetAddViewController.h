//
//  BetAddViewController.h
//  LetsBet
//
//  Created by 张亦弛 on 14-5-25.
//  Copyright (c) 2014年 Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BetAddViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate, UIAlertViewDelegate>

@property(nonatomic, weak) IBOutlet UIScrollView * myScrollView;
@property(nonatomic) CGFloat oldContentOffsetValue;

@property(nonatomic, weak) IBOutlet UISegmentedControl *segmentedControl1;

@property(nonatomic, weak) IBOutlet UITextField *renrenTextField1;
@property(nonatomic, weak) IBOutlet UITextField *renrenTextField2;

@property(nonatomic, weak) IBOutlet UITextField *betNameTextField;

@property(nonatomic, weak) IBOutlet UITextField *sideATextField;
@property(nonatomic, weak) IBOutlet UITextField *sideBTextField;

@property(nonatomic) BOOL keyboardShown;
@property(nonatomic) BOOL isNeedSetOffset;

@property (nonatomic,retain) UITextField * activeField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sendButton;


- (IBAction)toggleControls1:(id)sender;
- (IBAction)pushCancel:(id)sender;
- (IBAction)startBet:(id)sender;

@end
