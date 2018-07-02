//
//  FHHTextValidationBehaviour.h
//  Teachify
//
//  Created by Bastian Kusserow on 18.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

#ifndef FHHTextValidationBehaviour_h
#define FHHTextValidationBehaviour_h

#import "FHHBehaviour.h"

@protocol FHHTextValidationRule;

@interface FHHTextValidationBehaviour : FHHBehaviour

+ (instancetype) behaviourWithRules:(NSArray<id<FHHTextValidationRule>> *)rules;

@property (nonatomic, strong) IBOutletCollection(id) NSArray *rules;

@property (nonatomic, weak, nullable) IBOutlet UITextField *textField;

@property (nonatomic, strong, nullable) IBOutletCollection(UIControl) NSArray *controls;
@property (nonatomic, weak, nullable) IBOutlet UIBarButtonItem *barButton;

@property (nonatomic, strong, nullable) IBInspectable UIColor *invalidTextColor;

- (BOOL)validateText;




@end

@protocol FHHTextValidationRule <NSObject>

- (BOOL)evaluateWithString:(NSString *)string;

@end


@interface FHHLengthRule : NSObject <FHHTextValidationRule>

+ (instancetype)ruleWithRange:(NSRange)range;

@property (nonatomic, assign) IBInspectable NSUInteger minCharacterCount;
@property (nonatomic, assign) IBInspectable NSUInteger maxCharacterCount;

@end


@interface FHHAllowedCharactersRule : NSObject <FHHTextValidationRule>

+ (instancetype)ruleWithAllowedCharacters:(NSCharacterSet *)characterSet;

@end


@interface FHHRegularExpressionRule : NSObject <FHHTextValidationRule>

+ (instancetype)ruleWithRegularExpression:(NSRegularExpression *)regularExpression;

@property (nonatomic, copy) IBInspectable NSString *regExPattern;

@end

@interface FHHEmailRule : NSObject <FHHTextValidationRule>

@end

#endif /* FHHTextValidationBehaviour_h */
