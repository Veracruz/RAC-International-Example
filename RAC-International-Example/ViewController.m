//
//  ViewController.m
//  RACPractice
//
//  Created by Veracruz on 15/9/25.
//  Copyright © 2015年 Veracruz. All rights reserved.

#import "ViewController.h"
#import "LanguageManager.h"
#import "ReactiveCocoa.h"
#import "EXTScope.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *languageButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    @weakify(self);
    [LanguageChangedSignal subscribeNext:^(NSString *languageCode) {
        @strongify(self);
        self.languageButton.title = LocalizedString(@"Language");
        self.titleLabel.text = LocalizedString(@"Hello World");
        [self.button setTitle:LocalizedString(@"Button") forState:UIControlStateNormal];
        self.label.text = LocalizedString(@"Label");
        self.textView.text = LocalizedString(@"It's s pretty day.");
    }];
}

@end
