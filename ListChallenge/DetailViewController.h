//
//  DetailViewController.h
//  ListChallenge
//
//  Created by Iris Zhang on 2/22/15.
//  Copyright (c) 2015 Kickstarter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString *pSlug;
@property (weak, nonatomic) IBOutlet UILabel *projectName;
@property (weak, nonatomic) IBOutlet UILabel *funded;
@property (weak, nonatomic) IBOutlet UILabel *pledged;
@property (weak, nonatomic) IBOutlet UILabel *backers;
@property (weak, nonatomic) IBOutlet UILabel *creator;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *blurb;
@property (weak, nonatomic) IBOutlet UIImage *image;
@end
