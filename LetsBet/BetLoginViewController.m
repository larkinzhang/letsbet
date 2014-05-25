//
//  BetLoginViewController.m
//  LetsBet
//
//  Created by 张亦弛 on 14-5-19.
//  Copyright (c) 2014年 Larkin. All rights reserved.
//

#import "BetLoginViewController.h"

@interface BetLoginViewController ()

@end

@implementation BetLoginViewController

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

- (IBAction)login:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
