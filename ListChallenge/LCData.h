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

@property (strong, nonatomic, readonly) NSString *databaseName;
@property (nonatomic, strong, getter=getData) NSDictionary *data;

+(LCData *)sharedData; //only access singleton. Do not create any new instances of LCData
//-(NSArray *) projectNamesforListView;
//-(NSArray *) locationsforListView;
-(NSArray *) arrayforListViewForInfo: (NSString *) key;
-(NSDictionary *) dataForSlug: (NSString *) slug;
-(id) getInfoForProjectEntry: (NSDictionary *)entry infoKey: (NSString *) infoKey;
-(NSDictionary *) getSubDictionaryForProjectEntry: (NSDictionary *) entry dicKey: (NSString *)dicKey;

@end
