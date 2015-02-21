//
//  CustomTableViewCell.m
//  ListChallenge
//
//  Created by Iris Zhang on 2/21/15.
//  Copyright (c) 2015 Kickstarter. All rights reserved.
//

#import "CustomTableViewCell.h"



@implementation CustomTableViewCell
@synthesize projectName, location;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
