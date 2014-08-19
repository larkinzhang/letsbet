//
//  BetLoginViewController.m
//  LetsBet
//
//  Created by 张亦弛 on 14-5-19.
//  Copyright (c) 2014年 Larkin. All rights reserved.
//

#import "BetLoginViewController.h"
#import "SignUpViewController.h"
extern NSString *LoginSuccessNotification;

@interface BetLoginViewController ()

@end

@implementation BetLoginViewController

SignUpViewController *sub1;

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
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    recognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:recognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signUp:(id)sender {
    
    sub1 = [[SignUpViewController alloc] initWithNibName:@"SignUpViewController" bundle:nil];
    
    [self.view addSubview:sub1.view];
}

/*对于login操作，进行连接服务器对应的地址*/
- (IBAction)login:(id)sender {
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8888/Login"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *params = [NSString stringWithFormat:@"name=%@&password=%@", self.accountField.text,self.passwordField.text];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"Response:%@ %@\n", response, error);
        
        if (!error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSString *ans = [dict valueForKey:@"ans"];
                NSLog(@"!!!!%@", ans);
                
                if ([ans isEqualToString:@"0"]) {
                    UIAlertView *alert;
                    alert = [[UIAlertView alloc] initWithTitle:nil message:@"密码或用户名错误！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                } else {
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    [userDefaults setObject:self.accountField.text forKey:@"username"];
                    [userDefaults setObject:self.passwordField.text forKey:@"password"];
                    [userDefaults synchronize];
                    
                    [self dismissViewControllerAnimated:YES completion:nil];

                }
            });
        } else {
            UIAlertView *alert;
            alert = [[UIAlertView alloc] initWithTitle:nil message:@"连接服务器错误！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];

        }
        
    }];
    
    [dataTask resume];
    
    
}

- (void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.accountField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

- (IBAction)passwordEndEditing:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)accountEndEditing:(id)sender {
    [self.passwordField becomeFirstResponder];
}

@end
