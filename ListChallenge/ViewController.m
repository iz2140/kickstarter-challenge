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
@property (nonatomic, strong) NSArray *locations;

@end

@implementation ViewController: UIViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    NSDictionary *data = [[LCData sharedData] getData];
//    
//    NSArray *temp = [data objectForKey:@"projects"];
//    
//    NSDictionary *firstobj = [temp objectAtIndex:0];
//    
//    for (NSDictionary *project in temp ){
//        NSLog( @"%@", [project objectForKey: @"name"]);
//    }
//    
//    NSString* projname = [firstobj objectForKey: @"name"];
//    
//    NSLog(@"%@", projname);
//    self.tableView.estimatedRowHeight = 68.0;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;

    
    NSArray *projectNames = [[LCData sharedData] arrayforListViewForInfo: @"name"];
    if (projectNames)
        _projectNames = projectNames;
    
    NSArray *locations = [[LCData sharedData] arrayforListViewForInfo: @"country"];
    if (locations && [[locations firstObject] isKindOfClass:[NSString class]])
        _locations = locations;
    
    NSArray *pledges = [[LCData sharedData] arrayforListViewForInfo: @"pledged"];
    if ( [[pledges firstObject] isKindOfClass:[NSString class]]){
        NSLog(@"hi");
    } else {
        NSLog(@"hrm");
    }
    
    
}

//need to write helper method in LCData that checks if returned objects are strings, bools, or numbers... have to display as strings.

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.projectNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SimpleCell"];
    
    cell.projectName.text = [self.projectNames objectAtIndex:indexPath.row];
    cell.location.text = [self.locations objectAtIndex: indexPath.row];
    //cell.pledged.text = [self.pledges objectAtIndex: indexPath.row];
    
    return cell;
}
@end
