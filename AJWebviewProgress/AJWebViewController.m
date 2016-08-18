//
//  AJWebViewController.m
//  AJWebviewProgress
//
//  Created by Guoxb on 16/8/17.
//  Copyright © 2016年 guoxb. All rights reserved.
//

#import "AJWebViewController.h"
#import "AJWebLoadingView.h"

@interface AJWebViewController ()<UIWebViewDelegate>
{
    NSInteger _maxLoadCount, _loadingCount;
    UIButton *_closeButton;
    NSMutableSet *_shouldMainUrlSet;
    NSMutableSet *_startMainUrlSet;
}
@property (nonatomic, strong) UIWebView *myWebView;
@property (nonatomic, strong) AJWebLoadingView *loadingView;

@end

@implementation AJWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLeftButtonItems];
    [self.view addSubview:self.myWebView];
    [self.view addSubview:self.loadingView];
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
}

#pragma mark - private

-(void)setupLeftButtonItems{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 0, 44, 44);
    [backButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    closeButton.frame = CGRectMake(0, 0, 44, 44);
    [closeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    _closeButton = closeButton;
    closeButton.hidden = YES;
    
    
    [self.navigationItem setLeftBarButtonItems:@[[[UIBarButtonItem alloc] initWithCustomView:backButton], [[UIBarButtonItem alloc] initWithCustomView:closeButton]]];
    
}

-(void)back:(UIButton *)button{
    if ([_startMainUrlSet containsObject:self.myWebView.request.mainDocumentURL]) {
        [_startMainUrlSet removeObject:self.myWebView.request.mainDocumentURL];
    }
    if ([self.myWebView canGoBack]) {
        [self.myWebView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)close:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - lazyLoad

-(UIWebView *)myWebView{
    if (!_myWebView) {
        _myWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _myWebView.delegate = self;
    }
    return _myWebView;
}

-(AJWebLoadingView *)loadingView{
    if (!_loadingView) {
        _loadingView = [[AJWebLoadingView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 2)];
    }
    return _loadingView;
}

#pragma mark - UIWebViewDelegate

-(void)webViewDidStartLoad:(UIWebView *)webView{
    _loadingCount++;
    _maxLoadCount = fmax(_maxLoadCount, _loadingCount);
    [self.loadingView startAnimation];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    _loadingCount--;
    if (_maxLoadCount - _loadingCount == _maxLoadCount || !webView.isLoading) {
        [self.loadingView stopAnimation];
    }
    _closeButton.hidden = ![self.myWebView canGoBack];
    
    if (!_startMainUrlSet) {
        _startMainUrlSet = [NSMutableSet set];
    }else{
    }
    if ([_startMainUrlSet containsObject:webView.request.mainDocumentURL]) {
        [self.loadingView stopAnimation];
    }
    if (webView.request.mainDocumentURL) {
        [_startMainUrlSet addObject:webView.request.mainDocumentURL];
    }
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    _loadingCount --;
    if (_loadingCount == 0) {
        [self.loadingView stopAnimation];
    }
}

@end
