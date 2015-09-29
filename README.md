# RAC-International-Example

Example for the article http://veracruz.github.io/2015/09/27/RFP-RAC-Glance/

Use *Reactive Cocoa* make localized string like this

```objc
@weakify(self);
[LanguageChangedSignal subscribeNext:^(NSString *languageCode) {
    @strongify(self);
    self.languageButton.title = LocalizedString(@"Language");
    self.titleLabel.text = LocalizedString(@"Hello World");
    [self.button setTitle:LocalizedString(@"Button") forState:UIControlStateNormal];
    self.label.text = LocalizedString(@"Label");
    self.textView.text = LocalizedString(@"It's s pretty day.");
}];
```

These controls can response the change of language IN APP.

<image src="http://veracruz.github.io/images/2015_9/RAC-International-Example.gif" width=320></image>