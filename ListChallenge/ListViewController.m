//
//  ViewController.m
//  ListChallenge
//
//  Created by Iris Zhang on 2/15/15.
//  Copyright (c) 2015 Kickstarter. All rights reserved.
//

#import "ListViewController.h"

//model
#import "LCData.h"

//views
#import "CustomTableViewCell.h"
#import "DetailViewController.h"

@interface ListViewController ()


@property (nonatomic, strong) NSArray *projectNames; //Project names to display for ListView
@property (nonatomic, strong) NSArray *pledges;
@property (nonatomic, strong) NSArray *locations; //Project countries to display for ListView
@property (nonatomic, strong) NSArray *pSlugs; //Project id array

@end

@implementation ListViewController: UIViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    LCData *data = [[LCData alloc] init];
    
    NSArray *projectNames = [data projectNamesforListView];
    if (projectNames)
        _projectNames = projectNames;
    
    NSArray *locations = [data countryNamesforListView];
    if (locations)
        _locations = locations;

//    NSArray *pledges = [[LCData sharedData] arrayforListViewForInfo: @"pledged"];
//    if (pledges && [[pledges firstObject] isKindOfClass:[NSString class]]){
//        NSLog(@"hi");
//    } else {
//        NSLog(@"hrm");
//    }
    
    NSArray *pslugs = [data pslugsforListView];
    if (pslugs)
        _pSlugs = pslugs;
    
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
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SimpleCell"];
    
    cell.projectName.text = [self.projectNames objectAtIndex:indexPath.row];
    cell.location.text = [self.locations objectAtIndex: indexPath.row];
    //cell.pledged.text = [self.pledges objectAtIndex: indexPath.row];
    
    return cell;
}

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

//get the pslug for a project cell
-(NSString *) pslugForIndexPath: (NSIndexPath *) path {
    if (!([self.pSlugs count] == 0) )
        return [self.pSlugs objectAtIndex:path.row];
    return nil;
}

@end
