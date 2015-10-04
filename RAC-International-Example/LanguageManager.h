//
//  LanguageManager.h
//  RACPractice
//
//  Created by Veracruz on 15/9/29.
//  Copyright © 2015年 Veracruz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

@interface LanguageManager : NSObject

+ (LanguageManager *)sharedInstance;

- (RACSignal *)languageChangedSignal;
- (NSString *)localizedString:(NSString *)key;

- (NSArray *)languages;
- (void)changeLanguageTo:(NSString *)language;

@end

#define LanguageViewModel [LanguageManager sharedInstance]
#define LocalizedString(key) [LanguageViewModel localizedString:(key)]
#define LanguageChangedSignal [LanguageViewModel languageChangedSignal]
