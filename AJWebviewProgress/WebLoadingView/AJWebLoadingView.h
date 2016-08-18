//
//  WebLoadingView.h
//  TestPop
//
//  Created by Guoxb on 16/8/16.
//  Copyright © 2016年 guoxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AJWebLoadingView : UIView

@property (nonatomic, assign) CGFloat progress;
-(void)startAnimation;
-(void)stopAnimation;

@end
