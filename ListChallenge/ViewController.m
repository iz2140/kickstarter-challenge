//
//  ViewController.m
//  ListChallenge
//
//  Created by Iris Zhang on 2/15/15.
//  Copyright (c) 2015 Kickstarter. All rights reserved.
//

#import "ViewController.h"
#import "LCData.h"

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
    
    
    
}

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
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [self.projectNames objectAtIndex:indexPath.row];
    return cell;
}
@end
