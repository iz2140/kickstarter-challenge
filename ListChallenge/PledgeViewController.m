//
//  PledgeViewController.m
//  ListChallenge
//
//  Created by Iris Zhang on 2/23/15.
//  Copyright (c) 2015 Kickstarter. All rights reserved.
//

#import "PledgeViewController.h"
#import "Constants.h"

@interface PledgeViewController ()

@property (strong, nonatomic) NSString* tempPledge;
@property (strong, nonatomic) NSString* tempBacker;
@property (strong, nonatomic) NSString* tempCcNum;
@property (strong, nonatomic) NSString* tempSCode;
@property (strong, nonatomic) NSString* tempMonth;
@property (strong, nonatomic) NSString* tempYear;

@property (strong, nonatomic) NSMutableString* errorMsg;
@property BOOL errorExists;

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
    
    //set keyboard types
    [self.pledgeAmount setKeyboardType: UIKeyboardTypeNumbersAndPunctuation];
    [self.ccNumber setKeyboardType: UIKeyboardTypeNumbersAndPunctuation];
    [self.secCode setKeyboardType: UIKeyboardTypeNumberPad];
    [self.expMonth setKeyboardType: UIKeyboardTypeNumberPad];
    [self.expYear setKeyboardType: UIKeyboardTypeNumberPad];
    
    NSLog(@"I am receiving %@", self.projectName.text);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void) initProjectName:(NSString *) projectName{
//    self.projectName.text = projectName;
//}

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
    if (![self pledgeCheck:self.tempPledge]){
        [self updateErrorMsg:@"Pledge value must be between 1 and 10000."];
    }
    
    if (![self stringNotEmpty:self.tempBacker]){
        [self updateErrorMsg:@"Name empty."];
    }
    
    if (![self luhnCheck:self.tempCcNum]){
        [self updateErrorMsg:@"Credit card number invalid."];
    }
    
    if (![self stringNotEmpty:self.tempSCode]){
        [self updateErrorMsg:@"Security code empty."];
    }
    
    if (![self dateCheckWithMonth:self.tempMonth Year:self.tempYear]) {
        [self updateErrorMsg:@"Card expiration invalid."];
    }
          
    if (self.errorExists){
        NSLog(@"sending alert");
        [self showUIAlertWithMsg:self.errorMsg];
    } else {
        [self showUIAlertWithMsg:@"Congrats on contributing to an amazing Kickstarter project!"];
        self.pledgeAmount.text = nil;
        self.backerName.text = nil;
        self.ccNumber.text = nil;
        self.secCode.text = nil;
        self.expMonth.text = nil;
        self.expYear.text = nil;
    }
    
}

-(BOOL) dateCheckWithMonth: (NSString *) mm Year: (NSString *)yyyy {
    if (([mm length] == 0) || ([yyyy length] == 0))  {
        return false;
    }
    NSInteger month = [mm intValue];
    NSInteger year = [yyyy intValue];
    
    if (!(month && year))
        return false;
    
    if ( month < kJan || month > kDec || year < kCurrYear )
        return false;
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:month];
    [comps setYear:year];
    
    NSDate *exp = [[NSCalendar currentCalendar] dateFromComponents:comps];
    NSDate *today = [NSDate date];
    
    return [exp laterDate:today] == exp;
}

-(BOOL) stringNotEmpty: (NSString*) string {
   return !([string length] == 0);
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
        NSInteger num = buffer[i] - '0'; //convert to numbers using ASCII representation of unichar codes
        if (num < 0 || num > 9){
            NSLog(@"ccNum not valid numbers");
            return false;
        }
        if (i % 2 == 0){ //for every odd number, multiply by 2
            num *= 2;
            if (num > 9) //if greater than 9, then sum the two digits
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
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterNoStyle;
    NSNumber *pledge = [formatter numberFromString: str];
    
    return ([pledge intValue] >= kMinPledge && [pledge intValue] <= kMaxPledge);
}

-(NSMutableString *)errorMsg{
    if (!_errorMsg) {
        _errorMsg = [[NSMutableString alloc]init];
        [self.errorMsg appendString: @"Please fix errors in your form:"];
    }
    return _errorMsg;
}

-(void)updateErrorMsg: (NSString *) str {
    self.errorExists=YES;
    [self.errorMsg appendFormat: @"\n%@", str];
}

-(void)showUIAlertWithMsg: (NSString *) msg{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Form Submission"  message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }];
    
    [alert addAction:defaultAction];
    //upon showing the error Alert, should nil out the errorMsg and return errorExists state to default (NO)
    [self presentViewController:alert animated:YES completion:^(void){
        self.errorMsg = nil;
        self.errorExists = NO;
    }];
}
@end
