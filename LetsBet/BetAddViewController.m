//
//  BetAddViewController.m
//  LetsBet
//
//  Created by 张亦弛 on 14-5-25.
//  Copyright (c) 2014年 Larkin. All rights reserved.
//

#import "BetAddViewController.h"


@implementation BetAddViewController

- (IBAction)toggleControls1:(id)sender {
    NSInteger selectedSegment = [sender selectedSegmentIndex];
    NSLog(@"Segment %ld selected\n", (long)selectedSegment);
   
    if (selectedSegment == 0) {
        self.renrenTextField1.placeholder = @"请输入人人状态的内容。";
        self.renrenTextField2.placeholder = @"请输入人人状态的内容。";
    } else {
        self.renrenTextField1.placeholder = @"请输入惩罚内容。";
        self.renrenTextField2.placeholder = @"请输入惩罚内容。";
    }
}

- (void)pushCancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)startBet:(id)sender {
    self.cancelButton.enabled = NO;
    self.sendButton.enabled = NO;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userDefaults stringForKey:@"username"];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8888/CreateBetAndJoin"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *params = [NSString stringWithFormat:@"name=%@&penaltyA=%@&penaltyB=%@&introduction=%@&RRS=%ld&UserName=%@&RRmesA=%@&RRmesB=%@", self.betNameTextField.text, self.sideATextField.text, self.sideBTextField.text, self.betNameTextField.text, 1 - self.segmentedControl1.selectedSegmentIndex, userName, self.renrenTextField1.text, self.renrenTextField2.text];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"Response:%@ %@\n", response, error);
        
        if (!error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert;
                alert = [[UIAlertView alloc] initWithTitle:nil message:@"发起成功！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.cancelButton.enabled = YES;
                self.sendButton.enabled = YES;
            });
        }
        
    }];
    
    [dataTask resume];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.myScrollView.contentSize = CGSizeMake(self.myScrollView.frame.size.width, 1400.0f);
    self.myScrollView.scrollEnabled = YES;
    self.myScrollView.delegate = self;
    self.betNameTextField.delegate = self;
    self.sideATextField.delegate = self;
    self.sideBTextField.delegate = self;
    self.renrenTextField1.delegate = self;
    self.renrenTextField2.delegate = self;
    self.keyboardShown = NO;
    [self performSelector:@selector(registerForKeyboardNotifications)];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    recognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:recognizer];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeField = textField;
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeField = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerForKeyboardNotifications
{
    //添加自己做为观察者，以获取键盘显示时的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    //添加自己做为观察者，以获取键盘隐藏时的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasHidden:)
                                                 name:UIKeyboardDidHideNotification object:nil];
}


// 键盘出现时调用此方法
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    //如果键盘是显示状态，不用做重复的操作
    if (self.keyboardShown) return;
    
    //获得键盘通知的用户信息字典
    NSDictionary* info = [aNotification userInfo];
    
    // 取得键盘尺寸.
    NSValue* aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    /*
     // 重新设置scrollView的size
     CGRect viewFrame = [myScrollView frame];
     viewFrame.size.height -= keyboardSize.height;
     myScrollView.frame = viewFrame;
     
     
     // 把当前被挡住的text field滚动到view中适当的可见位置.
     
     CGRect textFieldRect = [activeField frame];
     [myScrollView scrollRectToVisible:textFieldRect animated:YES];
     */
    
    //记录当前textField的偏移量，方便隐藏键盘时，恢复textField到原来位置
    self.oldContentOffsetValue = [self.myScrollView contentOffset].y;
    
    //计算textField滚动到的适当位置
    NSLog(@"%f", self.activeField.frame.origin.y);
    NSLog(@"%f", self.activeField.frame.size.height);
    NSLog(@"%f", self.myScrollView.frame.origin.y);
    NSLog(@"%f", self.myScrollView.frame.size.height);
    NSLog(@"%f", self.view.frame.size.height);
    NSLog(@"%f", keyboardSize.height);
    // keyboardSize.height/2);)
    CGFloat value = (self.activeField.frame.origin.y
                     //        +myScrollView.frame.origin.y
                     + self.activeField.frame.size.height
                     - self.view.frame.size.height
                     + keyboardSize.height);
    
    NSLog(@"%f", value);
    value += 80;
    //value>0则表示需要滚动，小于0表示当前textField没有被挡住，不需要滚动
    if (value > 0) {
        //使textField滚动到适当位置
        [self.myScrollView setContentOffset:CGPointMake(0, value) animated:YES];
        
        self.isNeedSetOffset = YES;//更改状态标志为需要滚动
    }
    else
        self.isNeedSetOffset = NO;
//    self.keyboardShown = YES;

    
}

// 键盘隐藏时调用此方法
- (void)keyboardWasHidden:(NSNotification*)aNotification
{
    
    
    NSDictionary* info = [aNotification userInfo];
    
    // Get the size of the keyboard.
    NSValue* aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    
    // Reset the height of the scroll view to its original value
    CGRect viewFrame = [self.myScrollView frame];
    viewFrame.size.height += keyboardSize.height;
    self.myScrollView.frame = viewFrame;
    
    //如果状态标志为需要滚动，则要执行textFiled复位操作
    if (self.isNeedSetOffset) {
        //oldContentOffsetValue记录了textField原来的位置，复位即可
        [self.myScrollView setContentOffset:CGPointMake(0, self.oldContentOffsetValue) animated:YES];
    }
    
    //复位状态标志
    self.isNeedSetOffset = NO;
    self.keyboardShown = NO;
}

- (void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.renrenTextField1 resignFirstResponder];
    [self.renrenTextField2 resignFirstResponder];
    [self.betNameTextField resignFirstResponder];
    [self.sideATextField resignFirstResponder];
    [self.sideBTextField resignFirstResponder];
}

@end