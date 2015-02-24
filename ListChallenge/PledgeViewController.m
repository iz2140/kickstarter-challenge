//
//  PledgeViewController.m
//  ListChallenge
//
//  Created by Iris Zhang on 2/23/15.
//  Copyright (c) 2015 Kickstarter. All rights reserved.
//

#import "PledgeViewController.h"

@interface PledgeViewController ()

@property (strong, nonatomic) NSString* tempPledge;
@property (strong, nonatomic) NSString* tempBacker;
@property (strong, nonatomic) NSString* tempCcNum;
@property (strong, nonatomic) NSString* tempSCode;
@property (strong, nonatomic) NSString* tempMonth;
@property (strong, nonatomic) NSString* tempYear;

@property (strong, nonatomic) NSMutableString* alertMsg;

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

#pragma mark TO DO - change this to use tags

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSLog(@"whaat");
    
    if ([textField.accessibilityLabel isEqualToString:@"name"]) {
        _tempBacker = textField.text;
    }
    else if ([textField.accessibilityLabel isEqualToString:@"pledge"]) {
        _tempPledge = textField.text;
    }
    else if ([textField.accessibilityLabel isEqualToString:@"ccnum"]) {
        _tempCcNum = textField.text;
    }
    else if ([textField.accessibilityLabel isEqualToString:@"scode"]) {
        _tempSCode = textField.text;
    }
    else if ([textField.accessibilityLabel isEqualToString:@"mm"]) {
        _tempMonth = textField.text;
        
    }
    else if ([textField.accessibilityLabel isEqualToString:@"yy"]) {
        _tempYear = textField.text;
    }
}


- (IBAction)submit:(id)sender {
    
    NSLog(@"%@ pledged %@ to the project. their cc number is %@.", self.tempBacker, self.tempPledge, self.tempCcNum);
    
#pragma mark TODO - add all checks
    if (!([self pledgeCheck:self.tempPledge] &&
          [self luhnCheck:self.tempCcNum] &&
          [self dateCheckWithMonth:self.tempMonth Year:self.tempYear])){
        
        NSLog(@"sending alert");
    
    }
    
}

-(BOOL) dateCheckWithMonth: (NSString *) mm Year: (NSString *)yyyy {
    if (([mm length] == 0) || ([yyyy length] == 0))  {
        return false;
    }
    NSInteger month = [mm intValue];
    NSInteger year = [yyyy intValue];
    
    if ( month < 1 || month > 12 || year < 2015 || year > 9999 )
        return false;
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:month];
    [comps setYear:year];
    
    NSDate *exp = [[NSCalendar currentCalendar] dateFromComponents:comps];
    NSDate *today = [NSDate date];
    
    return [exp laterDate:today] == exp;
    
}

-(BOOL) stringEmpty: (NSString*) string {
   return [string length] == 0;
}

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

-(BOOL) pledgeCheck: (NSString *) str {
    if ([str length] == 0){
        
        return false;
    }
    NSInteger pledge = [str intValue];
    return (pledge >= 1 && pledge <= 10000);
}

-(NSMutableString *)alertMsg{
    if (!_alertMsg) {
        _alertMsg = [[NSMutableString alloc]init];
        [_alertMsg stringByAppendingString:@"Please fix the following errors:"];
    }
    return _alertMsg;
}

-(void)updateAlertMsg: (NSString *) alert {
    [self.alertMsg stringByAppendingString:alert];
}

#pragma mark TBD - change to iOS 8 configs
-(void)showUIAlert{
    UIAlertView *removeSuccessFulAlert=[[UIAlertView alloc]initWithTitle:@"Form Submission Error" message:self.alertMsg delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
    [removeSuccessFulAlert show];
    
}
@end
