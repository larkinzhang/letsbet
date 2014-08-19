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
    
<<<<<<< HEAD
    self.sideATitleLabel.text = [NSString stringWithFormat:@"%@%ld%@",@"已有",(long)self.sideAPopulation, @"人加入正方"];
    self.sideATitleLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.sideATitleLabel.numberOfLines = 0;
    self.sideBTitleLabel.text = [NSString stringWithFormat:@"%@%ld%@",@"已有",(long)self.sideBPopulation, @"人加入反方"];
=======
    self.sideATitleLabel.text = [NSString stringWithFormat:@"%@%ld%@",@"红方",self.sideAPopulation, @"人"];
    self.sideATitleLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.sideATitleLabel.numberOfLines = 0;
    self.sideBTitleLabel.text = [NSString stringWithFormat:@"%@%ld%@",@"蓝方",self.sideBPopulation, @"人"];
>>>>>>> 6cd7a67de808d530e8021e81b5ea2719f1a22f67
    self.sideBTitleLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.sideBTitleLabel.numberOfLines = 0;


    self.sideALabel.text = self.sideAString;
    self.sideALabel.lineBreakMode = UILineBreakModeWordWrap;
    self.sideALabel.numberOfLines = 0;
    self.sideBLabel.text = self.sideBString;
    self.sideBLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.sideBLabel.numberOfLines = 0;
    self.sideADetailsLabel.text = self.sideADetailString;
    self.sideADetailsLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.sideADetailsLabel.numberOfLines = 0;
    self.sideBDetailsLabel.text = self.sideBDetailString;
    self.sideBDetailsLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.sideBDetailsLabel.numberOfLines = 0;
    
    if (self.needHidden) {
        self.sideAJoin.hidden = YES;
        self.sideBJoin.hidden = YES;
    }
    
    [self.statusBar setImage:[BetSupportStatusBar drawStatusBar:self.sideAPopulation and:self.sideBPopulation]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sideAJoinButton:(id)sender {

    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否确认加入正方？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    myAlertView.tag = 0;
    [myAlertView show];
    
    

}

- (IBAction)sideBJoinButton:(id)sender {
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否确认加入反方？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    myAlertView.tag = 1;
    [myAlertView show];
}

- (IBAction)share:(id)sender {
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"53842e1d56240be56a0b083d" shareText:@"Hello world!" shareImage:nil shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina, UMShareToWechatSession, UMShareToRenren, nil] delegate:nil];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"clickButtonAtSide:%c",alertView.tag + 'A');
    NSLog(@"clickButtonAtIndex:%d",buttonIndex);
    
    
    if (buttonIndex == 1) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *userName = [userDefaults stringForKey:@"username"];
        
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        
        NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8888/UserJoinBet"];
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
        NSString *params = [NSString stringWithFormat:@"name=%@&idBets=%ld&party=%d", userName, (long)self.idBets, alertView.tag + 1];
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSLog(@"Response:%@ %@\n", response, error);
            
            if (!error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
            
        }];
        
        [dataTask resume];
    }

}

@end
