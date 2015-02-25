//
//  ViewModel.m
//  ListChallenge
//
//  Created by Iris Zhang on 2/24/15.
//  Copyright (c) 2015 Kickstarter. All rights reserved.
//

#import "DetailViewModel.h"
#import "LCData.h"

@interface DetailViewModel ()
@property (strong,nonatomic) NSDictionary *details;
@end

@implementation DetailViewModel

//designated initializer
-(id)initWithPSlug: (NSString *) pSlug{
    if (self = [super init]){
        NSDictionary *details = [[LCData sharedData] dataForSlug:pSlug];
        _details = details;
        
        
        self.projectName = [self getStringForData:[[LCData sharedData] getInfoForProjectEntry: self.details infoKey:@"name"]];
        self.currency = [self getStringForData:[[LCData sharedData] getInfoForProjectEntry: self.details infoKey:@"currency_symbol"]];
        self.pledged = (long)[[LCData sharedData] getInfoForProjectEntry: self.details infoKey:@"pledged"];
        self.goal = (long)[[LCData sharedData] getInfoForProjectEntry: self.details infoKey:@"goal"];
        
#pragma mark - TO DO: get rid of or finish this
        //NSNumber *funded = (NSNumber *)[[LCData sharedData] getInfoForProjectEntry: self.details infoKey:@"pledged"] / (NSNumber *)[[LCData sharedData] getInfoForProjectEntry: self.details infoKey:@"goal"];
        
        self.backers = (long)[[LCData sharedData] getInfoForProjectEntry: self.details infoKey:@"backers_count"];
        
        NSDictionary *creator = [[LCData sharedData] getSubDictionaryForProjectEntry:self.details dicKey:@"creator"];
        
        self.creator = [NSString stringWithFormat:@"Created by %@",
                             [self getStringForData:[[LCData sharedData] getInfoForProjectEntry: creator infoKey:@"name"]]];
        
        NSDictionary *location = [[LCData sharedData] getSubDictionaryForProjectEntry:self.details dicKey:@"location"];
        
        self.location = [self getStringForData:[[LCData sharedData] getInfoForProjectEntry: location infoKey:@"displayable_name"]];
        
        self.blurb = [self getStringForData:[[LCData sharedData] getInfoForProjectEntry: self.details infoKey:@"blurb"]];
        
    }
    return self;
}

//helper method to verify that data retrieved from details is a string, and if not, convert it
- (NSString *) getStringForData: (id)data {
    if (![data isKindOfClass:[NSString class]]){
        if ([data isKindOfClass:[NSNumber class]]){
            NSLog(@"converting string from %@", data);
            
            NSString *temp =[data stringValue];
            NSLog(@"returning %@", temp);
            return temp;
        }
    }
    return data;
}

//calculate percentfunded
- (double) calcPercentageFunded: (NSInteger) pledged Goal: (NSInteger) goal{
    return pledged / goal;
}

-(NSString *) percentFundedString: (double) percentage {
    return [NSNumberFormatter localizedStringFromNumber:[NSNumber  numberWithDouble:percentage] numberStyle:NSNumberFormatterPercentStyle];
}

//-(RACSignal *) pledgedUpdateSignal{
//    return RACObserve(<#TARGET#>, <#KEYPATH#>)
//}
//-(RACSignal *) backersUpdateSignal{
//}
//-(RACSignal *) fundedUpdateSignal{
//}

@end
