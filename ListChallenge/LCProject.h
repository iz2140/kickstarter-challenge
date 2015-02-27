//
//  LCProject.h
//  ListChallenge
//
//  Created by Iris Zhang on 2/26/15.
//  Copyright (c) 2015 Kickstarter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCProject : NSObject

@property (nonatomic, strong) NSString *display_name;
@property (nonatomic, strong) NSNumber *backers;
@property (nonatomic, strong) NSNumber *pledge_amount;
@property (nonatomic, strong) NSString *percent_funded;
@property (nonatomic, strong) NSString *creator_name;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *city_state;
@property (nonatomic, strong) NSString *blurb;

-(id)initWithSlug: (NSString *)pslug; //designated initialzer
@end
