//
//  ViewController.m
//  ArtTextLinkParse
//
//  Created by LeeWong on 2017/4/14.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

#import "ViewController.h"
#import "NSString+LinkParser.h"
#import "WebViewController.h"

@interface ViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.textView.delegate = self;
    self.textView.editable = NO;
    self.textView.text = @"这是一个链接https://console.qcloud.com/workorder/detail?ticketId=201703300143哈哈baidu.com我是fjaljfldsjflajs";
}

- (IBAction)parseText:(id)sender {
    self.textView.attributedText = [self.textView.text parserTextWithFont:[UIFont systemFontOfSize:20] textColor:[UIColor redColor] linkColor:[UIColor blueColor]];
}

//注意 UITextView 的
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction NS_AVAILABLE_IOS(10_0)
{
    if(URL.absoluteString.length > 0) {
        WebViewController *webVc = [[WebViewController alloc] init];
        webVc.urlString = URL.absoluteString;
        [self.navigationController pushViewController:webVc animated:YES];
        NSLog(@"%@",URL.absoluteString);
    }
        return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
