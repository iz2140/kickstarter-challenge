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
#import "DetailViewController.h"

@interface ViewController ()


@property (nonatomic, strong) NSArray *projectNames; //Project names to display for ListView
@property (nonatomic, strong) NSArray *pledges;
@property (nonatomic, strong) NSArray *locations; //Project countries to display for ListView
@property (nonatomic, strong) NSArray *pSlugs; //Project id array

@end

@implementation ViewController: UIViewController

//add stuff to send model info to DetailViewController here
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString: @"Prepare Detail"]) { //text is potentially unsafe, just checks that we are using the right segue
        

        if ([segue.destinationViewController isKindOfClass: [DetailViewController class]]) { //check that our destination is the DetailViewController
            
            NSIndexPath *path = [self.tableView indexPathForSelectedRow];
            NSString *pSlug = [self pslugForIndexPath:path];
            //NSLog(@"pSlug being sent is %@", pSlug);
            [segue.destinationViewController setPSlug:pSlug];
        }
        
    }
}

-(NSString *) pslugForIndexPath: (NSIndexPath *) path {
    if (!([self.pSlugs count] == 0) )
        return [self.pSlugs objectAtIndex:path.row];
    return nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    self.tableView.estimatedRowHeight = 68.0;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;

    
    NSArray *projectNames = [[LCData sharedData] arrayforListViewForInfo: @"name"];
    if (projectNames)
        _projectNames = projectNames;
    
    NSArray *locations = [[LCData sharedData] arrayforListViewForInfo: @"country"];
    if (locations && [[locations firstObject] isKindOfClass:[NSString class]]) //check that array is not null and that they consist of string objects
        _locations = locations;
    
    NSArray *pledges = [[LCData sharedData] arrayforListViewForInfo: @"pledged"];
    if (pledges && [[pledges firstObject] isKindOfClass:[NSString class]]){
        NSLog(@"hi");
    } else {
        NSLog(@"hrm");
    }
    
    NSArray *pslugs = [[LCData sharedData] arrayforListViewForInfo:@"slug"];
    if (pslugs && [[pslugs firstObject] isKindOfClass:[NSString class]])
        _pSlugs = pslugs;
    
    
}

#pragma mark - TODO
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
