//
//  ViewModel.h
//  ListChallenge
//
//  Created by Iris Zhang on 2/24/15.
//  Copyright (c) 2015 Kickstarter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>


@interface DetailViewModel : NSObject

//initial values
@property (nonatomic, assign) NSString *projectName;
@property (nonatomic, assign) NSString *currency;
@property(nonatomic, assign) NSInteger pledged;
@property(nonatomic, assign) NSInteger backers;
@property(nonatomic, assign) NSInteger goal;
@property (nonatomic, assign) NSString *creator;
@property (nonatomic, assign) NSString *location;
@property (nonatomic, assign) NSString *blurb;

//updated streams
//@property(nonatomic, readonly) NSNumber *percentFunded;
-(RACSignal *) pledgedUpdateSignal;
-(RACSignal *) backersUpdateSignal;
-(RACSignal *) fundedUpdateSignal;

@end
