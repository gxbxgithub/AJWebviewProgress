//
//  WebLoadingView.m
//  TestPop
//
//  Created by Guoxb on 16/8/16.
//  Copyright © 2016年 guoxb. All rights reserved.
//

#import "AJWebLoadingView.h"

@interface AJWebLoadingView ()
{
    CGFloat _width;
    CGFloat _height;
    BOOL _hasAnimation;
}
@property (nonatomic, strong) UIView *progressView;

@end

@implementation AJWebLoadingView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _width = frame.size.width;
        _height = frame.size.height;
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews{
    [self addSubview:self.progressView];
}

-(void)setProgress:(CGFloat)progress{
    _hasAnimation = YES;
    _progress = progress;
    if (progress == 0.8) {
        [UIView animateWithDuration:3 animations:^{
            self.progressView.frame = CGRectMake(0, 0, _width * progress, _height);
        }];
        
    }else if (progress == 1){
        [self.progressView.layer removeAllAnimations];
        [UIView animateWithDuration:0.4 animations:^{
            self.progressView.frame = CGRectMake(0, 0, _width * progress, _height);
        } completion:^(BOOL finished) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.alpha = 0;
                self.progressView.frame = CGRectMake(0, 0, 0, _height);
                _hasAnimation = NO;
            });
        }];
    }else{
        self.alpha = 1;
        [UIView animateWithDuration:0.1 animations:^{
            self.progressView.frame = CGRectMake(0, 0, _width * progress, _height);
        } completion:^(BOOL finished) {
            [self setProgress:0.8];
        }];
    }
}

-(void)startAnimation{
    if (!_hasAnimation) {
        self.progress = 0.2;
    }
}

-(void)stopAnimation{
    self.progress = 1;
}

#pragma mark - lazyLoad

-(UIView *)progressView{
    if (!_progressView) {
        _progressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, _height)];
        _progressView.backgroundColor = [UIColor redColor];
    }
    return _progressView;
}

@end
