//
//  UnfinishedBetViewController.m
//  LetsBet
//
//  Created by PlutoShe on 8/10/14.
//  Copyright (c) 2014 Larkin. All rights reserved.
//

#import "UnfinishedBetViewController.h"

@interface UnfinishedBetViewController ()

@end

@implementation UnfinishedBetViewController
NSInteger tmpBets;
NSMutableArray *MyBetArr;
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

/*得到关于此赌博的信息*/
- (void)getBetFromInternet
{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8888/QueryNeedConfirmBets"];
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
                MyBetArr = [NSMutableArray arrayWithArray:betArr];
                NSLog(@"%@", betArr);
                
                self.userList = [[NSMutableArray alloc] init];
                for (NSDictionary *bet in betArr) {
                    BetInfo *tmp = [[BetInfo alloc] init];
                    tmp.betName = [bet valueForKey:@"BetName"];
                    tmp.intro = [bet valueForKey:@"Introduction"];
                    tmp.sumA = [[bet valueForKey:@"Confirm"] integerValue];

                    tmp.idBets = [[bet valueForKey:@"idBets"] integerValue];
                    tmp.party = [[bet valueForKey:@"Party"] integerValue];
                    tmp.penaltyParty = [[bet valueForKey:@"PenaltyParty" ]integerValue];
                    
                    tmp.penaltyA = [bet valueForKey:@"RRMesA"];
                    tmp.penaltyB = [bet valueForKey:@"RRMesB"];
                    tmp.RRS = [[bet valueForKey:@"RRS"] integerValue];
                    
                    tmpBets = tmp.idBets;
                    [self.userList addObject:tmp];
                }
                
                [self.tableView reloadData];
                [self.refreshControl endRefreshing];
            });
        }
    }];
    
    [dataTask resume];
}

/*确定表单内容的显示*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UnfinishedBetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"unfinishBetCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UnfinishedBetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"unfinishBetCell"];
    }
    
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    BetInfo *curBet = nil;
    
    if ([self.userList count] > 0 && section == 0) {
        curBet = [self.userList objectAtIndex:row];
    } else {
        curBet = [self.confirmList objectAtIndex:row];
    }
    
    cell.titleLabel.text = curBet.betName;
    cell.finishButton.tag = indexPath.row * 10;

    if (curBet.party != curBet.penaltyParty) {
        cell.finishButton.hidden = YES;
        cell.partyLabel.text = [NSString stringWithFormat:@"所属方：败方"];
        
    }
    else {
        cell.finishButton.hidden = NO;
        cell.partyLabel.text = [NSString stringWithFormat:@"所属方：胜方"];
    }
    if (curBet.RRS == 1) {
        cell.penalty.text = @"人人状态惩罚";
    } else {
        if (curBet.penaltyParty == 0) {
            cell.penalty.text = curBet.penaltyA;
        } else {
            cell.penalty.text = curBet.penaltyB;
        }
    }
    
    cell.remain.text = [NSString stringWithFormat:@"剩余确认人数：%ld", (long)curBet.sumA];
    
    return cell;
}

- (IBAction)P2:(id)sender {
    NSInteger votes = ((UIButton*)sender).tag;
    NSDictionary *s1 = [MyBetArr objectAtIndex:votes/10];
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8888/UpdateUserConfirmation"];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    tmpBets = [[s1 valueForKey:@"idBets"] integerValue];
    [dictionary setValue:self.userName forKey:@"UserName"];
    [dictionary setValue:[NSString stringWithFormat:@"%ld", (long)tmpBets] forKey:@"Bets_idBets"];
    [dictionary setValue:@"1" forKey:@"confirm"];
    NSError *error = nil;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:self];
    [conn start];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"尚未完成惩罚";
    }
    return @"已完成";
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"OK!");
    [self refresh:nil];
}


- (IBAction)refresh:(id)sender {
    NSLog(@"refreshing mybet...");
    [self getBetFromInternet];
}

@end


