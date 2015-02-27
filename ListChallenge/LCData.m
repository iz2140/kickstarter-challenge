//
//  LCData.m
//  ListChallenge
//
//  Created by Iris Zhang on 2/20/15.
//  Copyright (c) 2015 Kickstarter. All rights reserved.
//

#import "LCData.h"

@interface LCData()

@property (strong, nonatomic) NSArray *projectList;

@end

@implementation LCData

//do not call init directly!!!
-(id)init{
    if (self = [super init]) {
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@kProjectData ofType:@"json"];
        
        NSError *error = nil;
        
        NSData *JSONData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error: &error];
        
        id JSONObject = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:&error];
        
        if (!JSONObject) {
            NSLog(@"Error parsing JSON");
        }else if ([JSONObject isKindOfClass:[NSDictionary class]]) {
            _data = JSONObject;
            _projectList = [self.data objectForKey: @"projects"];
        }
    }
    return self;
}


//singleton instance of LCData
//+(LCData *) sharedData {
//    static dispatch_once_t once;
//    static LCData *sharedDatabase = nil;
//    dispatch_once(&once, ^{
//        sharedDatabase = [[LCData alloc] init];
//    });
//    return sharedDatabase;
//}

-(NSDictionary *) dataForSlug: (NSString *) slug {
    NSDictionary *temp;
    for (NSDictionary *dictionary in self.projectList) {
        if ([[dictionary objectForKey: @"slug"] isEqualToString:slug]) {
            temp = dictionary;
        }
    }
    return temp;
}

//method used in the list view to retrieve names of projects
-(NSArray *) projectNamesforListView {
    NSMutableArray *names = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in self.projectList) {
        NSString *name = [dictionary objectForKey: @"name"];
        [names addObject: name];
    }
    return names;
}

//method used in the list view to retrieve locations of projects
-(NSArray *) countryNamesforListView {
    NSMutableArray *locations = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in self.projectList) {
        NSString *country =[dictionary objectForKey: @"country"];
        [locations addObject: country];
    }
    return locations;
}

-(NSArray *) pslugsforListView {
    NSMutableArray *locations = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in self.projectList) {
        NSString *country =[dictionary objectForKey: @"slug"];
        [locations addObject: country];
    }
    return locations;
}


@end
