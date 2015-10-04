//
//  LanguageManager.m
//  RACPractice
//
//  Created by Veracruz on 15/9/29.
//  Copyright © 2015年 Veracruz. All rights reserved.
//

#import "LanguageManager.h"
#import "ReactiveCocoa.h"
#import "EXTScope.h"

#define LocalizationFile @"Localizable"

@interface LanguageManager ()

@property (nonatomic, strong) NSDictionary *stringsFile;
@property (nonatomic, strong) RACSignal *languageChangedSignal;
@property (nonatomic, strong) NSString *currentLanguage;
@property (nonatomic, strong) NSDictionary *languagesInfo;

@end

@implementation LanguageManager

+ (LanguageManager *)sharedInstance {
    static LanguageManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LanguageManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        self.currentLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentLanguage"];
        if (!self.currentLanguage) {
            self.currentLanguage = [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
        }
        
        self.languagesInfo = @{@"English": @"en",
                               @"中文": @"zh",
                               @"日本語": @"ja"};
    }
    return self;
}

- (NSString *)localizedString:(NSString *)key {
    NSString *string = self.stringsFile[key];
    if (string) {
        return string;
    } else {
        return key;
    }
}

- (void)changeLanguageTo:(NSString *)language {
    if (self.languagesInfo[language]) {
        self.currentLanguage = self.languagesInfo[language];
    } else {
        self.currentLanguage = [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
    }
    
}

- (NSArray *)languages {
    return [@[@"跟随系统"] arrayByAddingObjectsFromArray:[_languagesInfo allKeys]];
}

- (RACSignal *)languageChangedSignal {
    if (!_languageChangedSignal) {
        @weakify(self);
        self.languageChangedSignal = [RACObserve(self, currentLanguage) doNext:^(NSString *currentLanguage) {
            @strongify(self);
            [[NSUserDefaults standardUserDefaults] setObject:currentLanguage forKey:@"currentLanguage"];
            NSBundle *localizeBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:self.currentLanguage ofType:@"lproj"]];
            self.stringsFile = [[NSDictionary alloc] initWithContentsOfFile:[localizeBundle pathForResource:LocalizationFile ofType:@"strings"]];
            if (!self.stringsFile) {
                NSBundle *baseBunble = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Base" ofType:@"lproj"]];
                self.stringsFile = [[NSDictionary alloc] initWithContentsOfFile:[baseBunble pathForResource:LocalizationFile ofType:@"strings"]];
            }
        }];
    }
    return _languageChangedSignal;
}

@end
