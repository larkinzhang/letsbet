//
//  showDetailsViewController.m
//  ShowDetails
//
//  Created by Zhengjie Miao on 14-5-25.
//  Copyright (c) 2014年 Zhengjie Miao. All rights reserved.
//

#import "showDetailsViewController.h"



@implementation showDetailsViewController
    

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleLabel.text = self.titleString;
    self.titleLabel.textAlignment = UITextAlignmentCenter;
    self.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.titleLabel.numberOfLines = 0;
    
    self.sideATitleLabel.text = [NSString stringWithFormat:@"%@%ld%@",@"已有",self.sideAPopulation, @"人加入正方"];
    self.sideATitleLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.sideATitleLabel.numberOfLines = 0;
    self.sideBTitleLabel.text = [NSString stringWithFormat:@"%@%ld%@",@"已有",self.sideBPopulation, @"人加入反方"];
    self.sideBTitleLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.sideBTitleLabel.numberOfLines = 0;


    self.sideALabel.text = self.sideAString;
    self.sideALabel.lineBreakMode = UILineBreakModeWordWrap;
    self.sideALabel.numberOfLines = 0;
    self.sideBLabel.text = self.sideBString;
    self.sideBLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.sideBLabel.numberOfLines = 0;
    self.sideADetailsLabel.text = @"吃翔三斤";
    self.sideADetailsLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.sideADetailsLabel.numberOfLines = 0;
    self.sideBDetailsLabel.text = @"吃翔三斤";
    self.sideBDetailsLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.sideBDetailsLabel.numberOfLines = 0;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sideAJoinButton:(id)sender {

    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否确认加入正方:" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    myAlertView.tag = 0;
    [myAlertView show];
    
    

}

- (IBAction)sideBJoinButton:(id)sender {
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否确认加入正方:" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    myAlertView.tag = 1;
    [myAlertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"clickButtonAtSide:%d",alertView.tag + 'A' - 1);
    NSLog(@"clickButtonAtIndex:%d",buttonIndex);
}

@end
