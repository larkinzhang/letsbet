//
//  SignUpViewController.m
//  LetsBet
//
//  Created by PlutoShe on 8/12/14.
//  Copyright (c) 2014 Larkin. All rights reserved.
//

#import "SignUpViewController.h"

extern NSString *server, *port;

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



extern NSString *LoginSuccessNotification;


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


/*对于注册操作连接对应的post请求的网址*/
- (IBAction)Create:(id)sender {
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    if ([self.accountField.text isEqualToString: @""] || [self.passwordField.text isEqualToString: @""]) {
                    UIAlertView *alert;
        alert = [[UIAlertView alloc] initWithTitle:nil message:@"用户名或密码为空！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }
        
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@/CreateUser", server, port]];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *params = [NSString stringWithFormat:@"name=%@&password=%@&rrname=%@&rrpassword=%@", self.accountField.text,self.passwordField.text,self.RRaccountField.text,self.RRpasswordField.text];
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
                    alert = [[UIAlertView alloc] initWithTitle:nil message:@"用户名已存在！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                } else {
                    [self.view removeFromSuperview];
                }
            });
        } else {
            UIAlertView *alert;
            alert = [[UIAlertView alloc] initWithTitle:nil message:@"连接服务器失败！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        
    }];
    [dataTask resume];
    
    
}

- (IBAction)cancel:(id)sender {
    [self.view removeFromSuperview];
}

- (void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.accountField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    [self.RRaccountField resignFirstResponder];
    [self.RRpasswordField resignFirstResponder];
    
}

- (IBAction)RRpasswordEndEditing:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)passwordEndEditing:(id)sender {
    [self.RRaccountField becomeFirstResponder];
}

- (IBAction)accountEndEditing:(id)sender {
    [self.passwordField becomeFirstResponder];
}

- (IBAction)RRaccountEndEditing:(id)sender {
    [self.RRpasswordField becomeFirstResponder];
}


@end
