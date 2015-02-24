//
//  PledgeViewController.m
//  ListChallenge
//
//  Created by Iris Zhang on 2/23/15.
//  Copyright (c) 2015 Kickstarter. All rights reserved.
//

#import "PledgeViewController.h"

@interface PledgeViewController ()

//@property (strong, nonatomic) NSNumber* pledge;
//@property (strong, nonatomic) NSString* backer;
@property (strong, nonatomic) NSNumber* ccNum;
@property (strong, nonatomic) NSNumber* sCode;
@property (strong, nonatomic) NSNumber* month;
@property (strong, nonatomic) NSNumber* year;

@property (strong, nonatomic) NSString* tempPledge;
@property (strong, nonatomic) NSString* tempBacker;
@property (strong, nonatomic) NSString* tempCcNum;
@property (strong, nonatomic) NSString* tempSCode;
@property (strong, nonatomic) NSString* tempMonth;
@property (strong, nonatomic) NSString* tempYear;


@end

@implementation PledgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //set UITextFieldDelegate for all textfields to self
    self.pledgeAmount.delegate = self;
    self.backerName.delegate = self;
    self.ccNumber.delegate = self;
    self.secCode.delegate = self;
    self.expMonth.delegate = self;
    self.expYear.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//tapping anywhere but a UITextField resigns first responder
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if (![[touch view] isKindOfClass:[UITextField class]]) {
        [self.view endEditing:YES];
    }
    [super touchesBegan:touches withEvent:event];
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSLog(@"whaat");
    
    if ([textField.accessibilityLabel isEqualToString:@"name"]) {
        //NSLog(@"am i getting called");
        _tempBacker = textField.text;
    }
    else if ([textField.accessibilityLabel isEqualToString:@"pledge"]) {
        //NSLog(@"am i getting called");
        _tempPledge = textField.text;
    }
    else if ([textField.accessibilityLabel isEqualToString:@"ccnum"]) {
        //NSLog(@"am i getting called");
        _tempCcNum = textField.text;
    }
    else if ([textField.accessibilityLabel isEqualToString:@"scode"]) {
        //NSLog(@"am i getting called");
        _tempSCode = textField.text;
    }
    else if ([textField.accessibilityLabel isEqualToString:@"mm"]) {
        //_tempMonth = textField.text;
        
    }
    else if ([textField.accessibilityLabel isEqualToString:@"yy"]) {
        //_tempYear = textField.text;
    }
}


- (IBAction)submit:(id)sender {
    
    NSLog(@"%@ pledged %@ to the project. their cc number is %@.", self.tempBacker, self.tempPledge, self.tempCcNum);
    
    [self luhnCheck:self.tempCcNum];
    
}

-(BOOL) stringNotEmpty: (NSString*) string {
    return ![string isEqualToString:@""];
}

//did not use characterAtIndex: method per Apple's guidelines for String Manipulation
-(BOOL) luhnCheck: (NSString*) str {
    if ([str length] == 0) {
        return false;
    }
    
    //convert string into a unichar buff
    int len = (int)[str length];
    unichar buffer[len+1];
    [str getCharacters:buffer range:NSMakeRange(0, len)];
    
    NSInteger sum = 0;
    //parse the string in reverse
    for (int i = len-1; i >= 0; i--){
        NSInteger num = buffer[i] - '0'; //convert to numbers
        if (num < 0 || num > 9){
            NSLog(@"ccNum not valid numbers");
            return false;
        }
        if (i % 2 == 0){ //for every odd number, multiply by 2
            num *= 2;
            if ( num > 9) //if greater than 9, then sum the two digits
                num -= 9;
        }
        sum += num;
    }
    return (sum != 0)&&(sum % 10 == 0);
}
@end
