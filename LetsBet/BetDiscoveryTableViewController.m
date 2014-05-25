//
//  BetDiscoveryTableViewController.m
//  LetsBet
//
//  Created by 张亦弛 on 14-5-19.
//  Copyright (c) 2014年 Larkin. All rights reserved.
//

#import "BetDiscoveryTableViewController.h"

NSString* const LoginSuccessNotification = @"LoginSuccess";

@interface BetDiscoveryTableViewController ()

@end

@implementation BetDiscoveryTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.betList = [[NSMutableArray alloc] init];
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
    
    /*
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(loginSuccess:) name:LoginSuccessNotification object:nil];
    */
    
    BetLoginViewController *view = [[BetLoginViewController alloc] initWithNibName:@"BetLoginViewController" bundle:nil];
    [self presentViewController:view animated:YES completion:nil];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.betList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiscoveryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[DiscoveryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
    }
    
    // Configure the cell...
    NSInteger row = [indexPath row];
    BetInfo *curBet = [self.betList objectAtIndex:row];
    cell.titleLabel.text = curBet.betName;
    cell.starterLabel.text = [NSString stringWithFormat:@"发起人: %@", curBet.starter];
    cell.numberLabel.text = [NSString stringWithFormat:@"参与人数: %ld", curBet.sumA + curBet.sumB];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)getBetFromInternet
{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8888/QueryActiveBets"];
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
                    
                    self.betList = [[NSMutableArray alloc] init];
                    for (NSDictionary *bet in betArr) {
                        BetInfo *tmp = [[BetInfo alloc] init];
                        tmp.betName = [bet valueForKey:@"BetName"];
                        tmp.intro = [bet valueForKey:@"Introduction"];
                        tmp.voteA = [bet valueForKey:@"PenaltyA"];
                        tmp.voteB = [bet valueForKey:@"PenaltyB"];
                        tmp.sumA = [[bet valueForKey:@"SumA"] integerValue];
                        tmp.sumB = [[bet valueForKey:@"SumB"] integerValue];
                        tmp.starter = [bet valueForKey:@"Sponsorer"];
                        tmp.penaltyA = [bet valueForKey:@"RRMesA"];
                        tmp.penaltyB = [bet valueForKey:@"RRMesB"];
                        tmp.idBets = [[bet valueForKey:@"idBets"] integerValue];
                        
                        [self.betList addObject:tmp];
                    }
                    
                    [self.tableView reloadData];
                    [self.refreshControl endRefreshing];
                });
            }
    }];
    
    [dataTask resume];
}

- (IBAction)refresh:(id)sender {
    NSLog(@"refreshing discovery...");
    [self getBetFromInternet];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    BetInfo *curBet = [self.betList objectAtIndex:row];
    
    showDetailsViewController *view = [[showDetailsViewController alloc] initWithNibName:@"showDetailsViewController" bundle:nil];
    view.title = curBet.betName;
    view.titleString = curBet.intro;
    view.sideAString = curBet.voteA;
    view.sideBString = curBet.voteB;
    view.sideAPopulation = curBet.sumA;
    view.sideBPopulation = curBet.sumB;
    view.idBets = curBet.idBets;
//    view.sideADetailString = curBet.penaltyA;
//    view.sideBDetailString = curBet.penaltyB;
    
    [self.navigationController pushViewController:view animated:YES];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    UIViewController *vc = (UIViewController *) segue.destinationViewController;
    DiscoveryTableViewCell *cell = (DiscoveryTableViewCell *) sender;
    
    vc.title = cell.titleLabel.text;
}
- (IBAction)postBet:(id)sender {
    BetAddViewController *view = [[BetAddViewController alloc] initWithNibName:@"BetAddViewController" bundle:nil];
    [self presentViewController:view animated:YES completion:nil];
}

- (void)loginSuccess:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    self.userName = [userInfo objectForKey:@"username"];
    
    NSLog(@"%@", self.userName);

    
    [self refresh:nil];
}

@end
