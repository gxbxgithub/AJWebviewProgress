//
//  ViewController.m
//  AJWebviewProgress
//
//  Created by Guoxb on 16/8/17.
//  Copyright © 2016年 guoxb. All rights reserved.
//

#import "ViewController.h"
#import "AJWebViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tf_url;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)enter:(UIButton *)sender {
    AJWebViewController *ajWebVC = [[AJWebViewController alloc] init];
    ajWebVC.url = _tf_url.text.length > 0 ? _tf_url.text : @"http://www.baidu.com";
    [self.navigationController pushViewController:ajWebVC animated:YES];
}

@end
