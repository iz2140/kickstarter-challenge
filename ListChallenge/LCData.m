//
//  LCData.m
//  ListChallenge
//
//  Created by Iris Zhang on 2/20/15.
//  Copyright (c) 2015 Kickstarter. All rights reserved.
//

#import "LCData.h"

@interface LCData()

@property (nonatomic, strong) NSArray *projects;

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
        }
    }
    return self;
}


//singleton instance of LCData
+(LCData *) sharedData {
    static dispatch_once_t once;
    static LCData *sharedDatabase = nil;
    dispatch_once(&once, ^{
        sharedDatabase = [[LCData alloc] init];
    });
    return sharedDatabase;
}

-(NSArray *) projects {
    if (!_projects) {
        _projects = [self.data objectForKey: @"projects"];
    }
    return _projects;
}

//generic method to grab an entry from a dictionary given the dictionary and key
//type checking and parsing should happen elsewhere
-(id) getInfoForProjectEntry: (NSDictionary *)entry infoKey: (NSString *) infoKey {
    id temp;
    if (!entry) {
        NSLog(@"Entry does not exist.");
        exit(1);
    }
    temp = [entry objectForKey: infoKey];
    return temp;
}

//helper method to grab a subdictionary entry from a dictionary given the dictionary and subdictionary key
-(NSDictionary *) getSubDictionaryForProjectEntry: (NSDictionary *) entry dicKey: (NSString *) dicKey {
    id temp;
    if (!entry) {
        NSLog(@"Entry does not exist.");
        exit(1);
    }
    
    temp = [entry objectForKey: dicKey];
    if (![temp isKindOfClass: [NSDictionary class]]) {
        NSLog(@"Entry is not of type NSDictionary.");
        exit(1);
    }
    return temp;
}

//helper method to return a project's dictionary entry given its slug
/* this would probably not be optimal with a large number of entries in the project array */
-(NSDictionary *) dataForSlug: (NSString *) slug {
    NSDictionary *temp;
    for (NSDictionary *dictionary in self.projects) {
        if ([[dictionary objectForKey: @"slug"] isEqualToString:slug]) {
            temp = dictionary;
        }
    }
    return temp;
}

//generic method used to retrieve array of info for listView -- exception may occur if given wrong argument
-(NSArray *) arrayforListViewForInfo: (NSString *) key {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    @try {
        for (NSDictionary *dictionary in self.projects) {
            [array addObject: [dictionary objectForKey: key]];
        }
    }@catch(NSException *e){
        NSLog(@"exception thrown in method arrayForListViewForInfo; %@ %@", [e name], [e reason]);
    }
    return array;
}

//method used in the list view to retrieve names of projects
-(NSArray *) projectNamesforListView {
    NSMutableArray *names = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in self.projects) {
        [names addObject: [dictionary objectForKey: @"name"]];
    }
    return names;
}

//method used in the list view to retrieve locations of projects
-(NSArray *) locationsforListView {
    NSMutableArray *locations = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in self.projects) {
        [locations addObject: [dictionary objectForKey: @"country"]];
    }
    return locations;
}
@end
