//
//  DetailViewController.m
//  ListChallenge
//
//  Created by Iris Zhang on 2/22/15.
//  Copyright (c) 2015 Kickstarter. All rights reserved.
//

#import "DetailViewController.h"
#import "LCData.h"
#import "PledgeViewController.h"

@interface DetailViewController ()

@property (strong,nonatomic) NSDictionary *details;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.rowHeight = 44; //necessary to suppress warning
    
    @try {
        NSDictionary *details = [[LCData sharedData] dataForSlug:self.pSlug];
        _details = details;
        
        
        self.projectName.text = [self getStringForData:[[LCData sharedData] getInfoForProjectEntry: self.details infoKey:@"name"]];
        
        self.pledged.text = [NSString stringWithFormat:@"%@%@ pledged",
                             [self getStringForData:[[LCData sharedData] getInfoForProjectEntry: self.details infoKey:@"currency_symbol"]],
                             [self getStringForData:[[LCData sharedData] getInfoForProjectEntry: self.details infoKey:@"pledged"]]];
        
#pragma mark - TO DO: get rid of or finish this
        self.funded.text = [NSString stringWithFormat:@"%@ funded",
                            [self getPercentFunded: [[[LCData sharedData] getInfoForProjectEntry:
                              self.details infoKey:@"pledged"] doubleValue]
                                              Goal: [[[LCData sharedData] getInfoForProjectEntry:
                              self.details infoKey:@"goal"] doubleValue]]];
        
        self.backers.text = [NSString stringWithFormat:@"%@ backed",
                             [self getStringForData:[[LCData sharedData] getInfoForProjectEntry: self.details infoKey:@"backers_count"]]];
        
        NSDictionary *creator = [[LCData sharedData] getSubDictionaryForProjectEntry:self.details dicKey:@"creator"];
        
        self.creator.text = [NSString stringWithFormat:@"Created by %@",
                             [self getStringForData:[[LCData sharedData] getInfoForProjectEntry: creator infoKey:@"name"]]];
        
        NSDictionary *location = [[LCData sharedData] getSubDictionaryForProjectEntry:self.details dicKey:@"location"];
        
        self.location.text = [self getStringForData:[[LCData sharedData] getInfoForProjectEntry: location infoKey:@"displayable_name"]];
        
        self.blurb.text = [self getStringForData:[[LCData sharedData] getInfoForProjectEntry: self.details infoKey:@"blurb"]];
        
        
    }@catch(NSException *e){
        NSLog(@"exception thrown in method viewDidLoad in DetailViewController; %@ %@", [e name], [e reason]);
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    if (section == 0)
        return 5;
    else if (section == 1)
        return 3;
    else if (section == 2)
        return 1;
    // Return the number of rows in the section.
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

//helper method to verify that data retrieved from details is a string, and if not, convert it
- (NSString *) getStringForData: (id)data {
    if (![data isKindOfClass:[NSString class]]){
        if ([data isKindOfClass:[NSNumber class]]){
            //NSLog(@"converting string from %@", data);
            
            NSString *temp =[data stringValue];
            //NSLog(@"returning %@", temp);
            return temp;
        } else
            return nil;
    }
    return data;
}

-(NSString *) getPercentFunded: (double) pledged Goal: (double) goal {
    double percent = pledged/goal;
    NSLog(@"pledged - %ld", (long)pledged);
    NSLog(@"goal - %ld", (long)goal);
    NSLog(@"percent - %f", percent);
    NSString *str = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithDouble:percent] numberStyle:NSNumberFormatterPercentStyle];
    NSLog(@"percent funded: %@", str);
    return str;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString: @"Submit Pledge"]) { //text is potentially unsafe, just checks that we are using the right segue
        if ([segue.destinationViewController isKindOfClass: [PledgeViewController class]]) { //check that our destination is the PledgeViewController

            NSString *projectName = self.projectName.text;
            PledgeViewController *temp = segue.destinationViewController;
            NSLog(@"I am sending %@", projectName);
            temp.projectName.text=projectName;
        }
        
    }

}


@end
