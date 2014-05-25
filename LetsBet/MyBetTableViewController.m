//
//  MyBetTableViewController.m
//  LetsBet
//
//  Created by 张亦弛 on 14-5-19.
//  Copyright (c) 2014年 Larkin. All rights reserved.
//

#import "MyBetTableViewController.h"

@interface MyBetTableViewController ()

@end

@implementation MyBetTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.userName = [userDefaults stringForKey:@"username"];
    
    [self refresh:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return ([self.userList count] > 0) + ([self.confirmList count] > 0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if ([self.userList count] > 0 && section == 0) {
        return [self.userList count];
    } else {
        return [self.confirmList count];
    }
}

- (void)getBetFromInternet
{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8888/QueryUserBets"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *params = [NSString stringWithFormat:@"name=%@", self.userName];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"Response:%@ %@\n", response, error);
        if(error == nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSArray *betArr = [dict valueForKey:@"result"];
                NSLog(@"%@", betArr);
                
                self.userList = [[NSMutableArray alloc] init];
                for (NSDictionary *bet in betArr) {
                    BetInfo *tmp = [[BetInfo alloc] init];
                    tmp.betName = [bet valueForKey:@"BetName"];
                    tmp.intro = [bet valueForKey:@"Introduction"];
                    tmp.voteA = [bet valueForKey:@"PenaltyA"];
                    tmp.voteB = [bet valueForKey:@"PenaltyB"];
                    tmp.sumA = [[bet valueForKey:@"SumA"] integerValue];
                    tmp.sumB = [[bet valueForKey:@"SumB"] integerValue];
                    tmp.starter = [bet valueForKey:@"Sponsorer"];
                    
                    [self.userList addObject:tmp];
                }
                
                [self.tableView reloadData];
                [self.refreshControl endRefreshing];
            });
        }
    }];
    
    [dataTask resume];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyBetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mybetcellIdentifier" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[MyBetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mybetcellIdentifier"];
    }
    
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    BetInfo *curBet = nil;
    
    if ([self.userList count] > 0 && section == 0) {
        curBet = [self.userList objectAtIndex:row];
    } else {
        curBet = [self.confirmList objectAtIndex:row];
    }
    
    // Configure the cell...
    cell.titleLabel.text = curBet.betName;
    cell.starterLabel.text = [NSString stringWithFormat:@"发起人: %@", curBet.starter];
    cell.numberLabel.text = [NSString stringWithFormat:@"参与人数: %ld", curBet.sumA + curBet.sumB];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"正在进行";
    }
    return @"已完成";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)refresh:(id)sender {
    NSLog(@"refreshing mybet...");
    [self getBetFromInternet];
}

@end
