//
//  LCProject.m
//  ListChallenge
//
//  Created by Iris Zhang on 2/26/15.
//  Copyright (c) 2015 Kickstarter. All rights reserved.
//

#import "LCProject.h"
#import "LCData.h"

@interface LCProject()
@property (nonatomic, readonly) NSDictionary *creatorInfo;
@property (nonatomic, readonly) NSDictionary *locationInfo;

@end

@implementation LCProject

-(id)initWithSlug: (NSString*) pslug{
    if (self = [super init]){
        LCData *model = [[LCData alloc] init];
        NSDictionary *raw = [model dataForSlug:pslug];
        
        [self setDisplay_name:[raw objectForKey:@"name"]];
        [self setPledge_amount:[raw objectForKey:@"pledged"]];
        [self setBlurb:[raw objectForKey:@"blurb"]];
        [self setCountry:[raw objectForKey:@"country"]];
        [self setBackers:[raw objectForKey:@"backers_count"]];
        
        NSDictionary *creator = [self getSubDictionaryForProjectEntry:raw dicKey:@"creator"];
        
        [self setCreator_name:[creator objectForKey:@"name"]];
        
        NSDictionary *location = [self getSubDictionaryForProjectEntry:raw dicKey:@"location"];
        
        [self setCity_state: [location objectForKey:@"displayable_name"]];
        
        [self setPercent_funded:[self getPercentFunded:[[raw objectForKey:@"pledged"]doubleValue] Goal: [[raw objectForKey:@"goal"]doubleValue]]];
        
        
    }
    return self;
}

-(NSDictionary *) getSubDictionaryForProjectEntry: (NSDictionary *) entry dicKey: (NSString *) dicKey {
    id temp;
    if (!entry) {
        NSLog(@"Entry does not exist.");
        return nil;
    }
    
    temp = [entry objectForKey: dicKey];
    if (![temp isKindOfClass: [NSDictionary class]]) {
        NSLog(@"Entry is not of type NSDictionary.");
        return nil;
    }
    return temp;
}

-(NSString *) getPercentFunded: (double) pledged Goal: (double) goal {
    double percent = pledged/goal;
//    NSLog(@"pledged - %ld", (long)pledged);
//    NSLog(@"goal - %ld", (long)goal);
//    NSLog(@"percent - %f", percent);
    NSString *str = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithDouble:percent] numberStyle:NSNumberFormatterPercentStyle];
    NSLog(@"percent funded: %@", str);
    return str;
}

@end
