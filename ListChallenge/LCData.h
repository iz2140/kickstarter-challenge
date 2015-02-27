//
//  LCData.h
//  ListChallenge
//
//  Created by Iris Zhang on 2/20/15.
//  Copyright (c) 2015 Kickstarter. All rights reserved.
//

#import <Foundation/Foundation.h>

//static json db name
#define kProjectData "projectdata"

@interface LCData : NSObject

@property (nonatomic, readonly, getter=getData) NSDictionary *data;

-(id)init; //public init method
//+(LCData *)sharedData; //only access singleton. Do not create any new instances of LCData
-(NSArray *) projectNamesforListView;
-(NSArray *) countryNamesforListView;
-(NSArray *) pslugsforListView;
-(NSDictionary *) dataForSlug: (NSString *) slug;

@end
