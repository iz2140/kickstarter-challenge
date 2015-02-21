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

//only access singleton. Do not create any new instances of LCData
+(LCData *)sharedData;

@end
