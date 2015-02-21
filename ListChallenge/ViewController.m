//
//  ViewController.m
//  ListChallenge
//
//  Created by Iris Zhang on 2/15/15.
//  Copyright (c) 2015 Kickstarter. All rights reserved.
//

#import "ViewController.h"
#import "LCData.h"
#import "CustomTableViewCell.h"
#define NUMBER_OF_ROWS 15

@interface ViewController ()


@property (nonatomic, strong) NSArray *projectNames;
@property (nonatomic, strong) NSArray *pledges;


@end

@implementation ViewController: UIViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSDictionary *data = [[LCData sharedData] getData];
    
    NSArray *temp = [data objectForKey:@"projects"];
    
    NSDictionary *firstobj = [temp objectAtIndex:0];
    
    for (NSDictionary *project in temp ){
        NSLog( @"%@", [project objectForKey: @"name"]);
    }
    
    NSString* projname = [firstobj objectForKey: @"name"];
    
    NSLog(@"%@", projname);
    
//    NSArray *projectNames = [[LCData sharedData] projectNamesforListView];
//    if (projectNames)
//        _projectNames = projectNames;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return NUMBER_OF_ROWS;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SimpleCell"];
    
    cell.projectName.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    cell.location.text = [NSString stringWithFormat:@"%ld", NUMBER_OF_ROWS - indexPath.row];
    
    return cell;
}
@end
