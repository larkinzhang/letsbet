//
//  showDetailsViewController.m
//  ShowDetails
//
//  Created by 张亦弛 on 14-5-25.
//  Copyright (c) 2014年 Larkin. All rights reserved.
//

#import "ShowDetailsViewController.h"



@implementation ShowDetailsViewController
    

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
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.numberOfLines = 0;
    
    self.sideATitleLabel.text = [NSString stringWithFormat:@"%@%ld%@",@"红方",self.sideAPopulation, @"人"];
    self.sideATitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.sideATitleLabel.numberOfLines = 0;
    self.sideBTitleLabel.text = [NSString stringWithFormat:@"%@%ld%@",@"蓝方",self.sideBPopulation, @"人"];
    self.sideBTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.sideBTitleLabel.numberOfLines = 0;


    self.sideALabel.text = self.sideAString;
    self.sideALabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.sideALabel.numberOfLines = 0;
    self.sideBLabel.text = self.sideBString;
    self.sideBLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.sideBLabel.numberOfLines = 0;
    self.sideADetailsLabel.text = self.sideADetailString;
    self.sideADetailsLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.sideADetailsLabel.numberOfLines = 0;
    self.sideBDetailsLabel.text = self.sideBDetailString;
    self.sideBDetailsLabel.lineBreakMode = NSLineBreakByWordWrapping;
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

    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否确认加入红方？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    myAlertView.tag = 0;
    [myAlertView show];
    
}

- (IBAction)sideBJoinButton:(id)sender {
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否确认加入蓝方？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    myAlertView.tag = 1;
    [myAlertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"clickButtonAtSide:%ld",alertView.tag + 'A');
    NSLog(@"clickButtonAtIndex:%ld",(long)buttonIndex);
    
    if (buttonIndex == 1) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *userName = [userDefaults stringForKey:@"username"];
        
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        
        NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8888/UserJoinBet"];
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
        NSString *params = [NSString stringWithFormat:@"name=%@&idBets=%ld&party=%ld", userName, (long)self.idBets, alertView.tag + 1];
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
