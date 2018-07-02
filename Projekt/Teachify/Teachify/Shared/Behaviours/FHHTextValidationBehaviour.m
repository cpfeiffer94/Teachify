//
//  NSObject+FHHTextValidationBehaviour.m
//  Teachify
//
//  Created by Bastian Kusserow on 18.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

#import "FHHTextValidationBehaviour.h"

@interface FHHTextValidationBehaviour ()
@property (nonatomic, strong) UIColor *validTextColor;
@end

@implementation FHHTextValidationBehaviour

#pragma mark - Class Constructor

+ (instancetype)behaviourWithRules:(NSArray *)rules
{
    NSParameterAssert(rules);
    
    FHHTextValidationBehaviour *behaviour = [[self alloc] init];
    behaviour.rules = rules;
    
    return behaviour;
}

#pragma mark - NSObject


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.validTextColor = self.textField.textColor;
    
    [self updateValidation];
}

#pragma mark - Properties

- (void)setTextField:(UITextField *)textField
{
    _textField = textField;
    
    [_textField addTarget:self action:@selector(updateValidation) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark -

- (void)updateValidation
{
    BOOL isValid = [self validateText];
    
    self.barButton.enabled = isValid;
    for (UIControl *control in self.controls) {
        control.enabled = isValid;
    }
    
    if (self.invalidTextColor) {
        self.textField.textColor = isValid ? self.validTextColor : self.invalidTextColor;
    }
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

#pragma mark - Public

- (BOOL)validateText
{
    NSString *text = self.textField.text;
    NSArray *failingRules = [self.rules filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id<FHHTextValidationRule> rule, NSDictionary *bindings) {
        return [rule evaluateWithString:text];
    }]];
    
    return (failingRules.count == 0);
}

@end

#pragma mark - Length Rule

@interface FHHLengthRule ()
@property (nonatomic, assign) NSRange range;
@end

@implementation FHHLengthRule

+ (instancetype)ruleWithRange:(NSRange)range
{
    FHHLengthRule *rule = [[self alloc] init];
    rule.range = range;
    
    return rule;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    NSAssert(self.minCharacterCount > 0, @"Minimum character count must be > 0");
    NSAssert(self.maxCharacterCount <= 255, @"Maximum character count must be <= 255");
    
    self.range = NSMakeRange(self.minCharacterCount, self.maxCharacterCount - self.minCharacterCount);
}

- (BOOL)evaluateWithString:(NSString *)string
{
    return !NSLocationInRange(string.length, self.range);
}

@end

#pragma mark - Allowed Character Rule

@interface FHHAllowedCharactersRule ()
@property (nonatomic, strong) NSCharacterSet *disallowedCharacters;
@end

@implementation FHHAllowedCharactersRule

+ (instancetype)ruleWithAllowedCharacters:(NSCharacterSet *)characterSet
{
    NSParameterAssert(characterSet);
    
    FHHAllowedCharactersRule *rule = [[self alloc] init];
    rule.disallowedCharacters = [characterSet invertedSet];
    
    return rule;
}

- (BOOL)evaluateWithString:(NSString *)string
{
    return ([string rangeOfCharacterFromSet:self.disallowedCharacters].location != NSNotFound);
}

@end

#pragma mark - Regular Expression Rule

@interface FHHRegularExpressionRule ()
@property (nonatomic, strong) NSRegularExpression *regularExpression;
@end

@implementation FHHRegularExpressionRule

+ (instancetype)ruleWithRegularExpression:(NSRegularExpression *)regularExpression;
{
    NSParameterAssert(regularExpression);
    
    FHHRegularExpressionRule *rule = [[self alloc] init];
    rule.regularExpression = regularExpression;
    
    return rule;
}

- (BOOL)evaluateWithString:(NSString *)string
{
    if (!self.regularExpression && self.regExPattern) {
        NSError *error = nil;
        NSRegularExpression *regEx = [NSRegularExpression regularExpressionWithPattern:self.regExPattern options:0 error:&error];
        NSAssert(regEx != nil, @"Error constructing regular expression pattern: %@", error);
        
        self.regularExpression = regEx;
    }
    
    return ([self.regularExpression numberOfMatchesInString:string options:0 range:NSMakeRange(0, string.length)] > 0);
}

@end

#pragma mark - Email Rule

@interface FHHEmailRule ()
@property (nonatomic, strong) NSDataDetector *dataDetector;
@end

@implementation FHHEmailRule

- (NSDataDetector *)dataDetector
{
    return _dataDetector ?: [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:NULL];
}

- (BOOL)evaluateWithString:(NSString *)string
{
    if (string.length == 0) {
        return YES;
    }
    
    NSRange stringRange = NSMakeRange(0, string.length);
    NSArray *matches = [self.dataDetector matchesInString:string options:0 range:stringRange];
    
    if (matches.count != 1) {
        return YES;
    }
    
    NSTextCheckingResult *result = matches.firstObject;
    
    if (result.resultType != NSTextCheckingTypeLink) {
        return YES;
    }
    
    static NSString * const emailPrefix = @"mailto";
    
    if (![result.URL.scheme isEqualToString:emailPrefix]) {
        return YES;
    }
    
    if (!NSEqualRanges(result.range, stringRange)) {
        return YES;
    }
    
    if ([string hasPrefix:emailPrefix]) {
        return YES;
    }
    
    return NO;
}

@end
