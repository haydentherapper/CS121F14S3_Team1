//
//  BGKVCrackerControl.m
//  SecurityGame
//
//  Created by Guest User on 12/1/14.
//  Copyright (c) 2014 BGKV. All rights reserved.
//

#import "BGKVCrackerControl.h"
#import "BGKVCrackerKeyboard.h"

@implementation BGKVCrackerControl {
    NSString *_passwordTemplate;
}

- (void)setPassword:(NSString *)password
{
    _passwordTemplate = [BGKVCrackerControl templateFromString:password];
    super.password = password;
}

- (void)setup
{
    [super setup];
    
    BGKVCrackerKeyboard *keyboard = [[BGKVCrackerKeyboard alloc] initDefault];//WithFrame:CGRectMake(0, 0, 1024, 352)];
    keyboard.textField = self.passwordField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *template = textField.text;
    NSNumber *correctTemplate = [NSNumber numberWithBool:[template isEqualToString:_passwordTemplate]];
    
    double  crackTime = 2.0;
    int guesses = 100;
    
    for (int i=0; i<guesses; i++) {
        [textField performSelector:@selector(setText:) withObject:[BGKVCrackerControl randomFromTemplate:template] afterDelay:i*crackTime/guesses];
    }
    [self performSelector:@selector(finallyCheckPasswordAndReturn:) withObject:correctTemplate afterDelay:crackTime+0.1];
    
    NSLog(@"%@",[@YES class]);
    
    return NO;
}

- (void)finallyCheckPasswordAndReturn:(NSNumber *)correctTemplate
{
    BOOL correct = [correctTemplate boolValue];
    
    if (correct) {
        self.passwordField.text = self.password;
    }
    
    [super textFieldShouldReturn:self.passwordField];
}

- (void)spinThroughGuessesThenCheckPassword
{
    UITextField *textField = self.passwordField;
    NSString* template = textField.text;
    BOOL correctTemplate = [template isEqualToString:_passwordTemplate];
    
    for (int i=0; i<10000; i++) {
        textField.text = [BGKVCrackerControl randomFromTemplate:template];
        [textField setNeedsDisplay];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (correctTemplate) {
            textField.text = self.password;
        }
        [super textFieldShouldReturn:textField];
    });
}


+ (NSString *)templateFromString:(NSString *)string
{
    NSMutableString *template = [[NSMutableString alloc] init];
    
    NSUInteger len = [string length];
    unichar buffer[len+1];
    
    [string getCharacters:buffer range:NSMakeRange(0, len)];
    
    for(int i = 0; i < len; i++) {
        NSString *repChar = [[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:buffer[i]] ? @"a"
        : [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:buffer[i]] ? @"A"
        : [[NSCharacterSet decimalDigitCharacterSet] characterIsMember:buffer[i]] ? @"1"
        : [[NSCharacterSet symbolCharacterSet] characterIsMember:buffer[i]] ? @"!"
        : @"?";
        
        [template appendString:repChar];
    }
    
    return template;
}

+ (NSString *)randomFromTemplate:(NSString *)template
{
    NSMutableString *random = [[NSMutableString alloc] init];
    
    NSUInteger len = [template length];
    unichar buffer[len+1];
    
    [template getCharacters:buffer range:NSMakeRange(0, len)];
    
    for(int i = 0; i < len; i++) {
        NSString *charSet = [[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:buffer[i]] ? @"abcdefghijklmnopqrstuvwxyz"
        : [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:buffer[i]] ? @"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        : [[NSCharacterSet decimalDigitCharacterSet] characterIsMember:buffer[i]] ? @"1234567890"
        : [[NSCharacterSet symbolCharacterSet] characterIsMember:buffer[i]] ? @"!@#$%^&*?~+=-_/"
        : [NSString stringWithFormat:@"%C", buffer[i]];
        
        NSUInteger rand = arc4random_uniform([charSet length]);
        NSString *repChar = [NSString stringWithFormat:@"%C", [charSet characterAtIndex:rand]];
        [random appendString:repChar];
    }
    
    return random;
}

@end
