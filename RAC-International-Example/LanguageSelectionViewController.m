//
//  LanguageSelectionViewController.m
//  RAC-International-Example
//
//  Created by Veracruz on 15/9/29.
//  Copyright © 2015年 Veracruz. All rights reserved.
//

#import "LanguageSelectionViewController.h"
#import "LanguageManager.h"

@interface LanguageSelectionViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *languages;

@end

@implementation LanguageSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = LocalizedString(@"Language");
    self.languages = [LanguageViewModel languages];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.languages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.languages[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [LanguageViewModel changeLanguageTo:self.languages[indexPath.row]];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
