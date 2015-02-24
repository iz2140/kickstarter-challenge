//
//  PledgeViewController.h
//  ListChallenge
//
//  Created by Iris Zhang on 2/23/15.
//  Copyright (c) 2015 Kickstarter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PledgeViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *pledgeAmount;
@property (weak, nonatomic) IBOutlet UITextField *backerName;
@property (weak, nonatomic) IBOutlet UITextField *ccNumber;
@property (weak, nonatomic) IBOutlet UITextField *secCode;
@property (weak, nonatomic) IBOutlet UITextField *expMonth;
@property (weak, nonatomic) IBOutlet UITextField *expYear;
- (IBAction)submit:(id)sender;

@end
