//
//  CustomTableViewCell.h
//  ListChallenge
//
//  Created by Iris Zhang on 2/21/15.
//  Copyright (c) 2015 Kickstarter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *projectName;
@property (nonatomic, weak) IBOutlet UILabel *location;
@property (nonatomic, weak) IBOutlet UILabel *pledged;

@end
