//
//  BetSupportStatusBar.m
//  LetsBet
//
//  Created by 张亦弛 on 14/8/15.
//  Copyright (c) 2014年 Larkin. All rights reserved.
//

#import "BetSupportStatusBar.h"

@implementation BetSupportStatusBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)drawStatusBar
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //设置颜色，仅填充4条边
    CGContextSetStrokeColorWithColor(ctx, [[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5] CGColor]);
    //设置线宽为1
    CGContextSetLineWidth(ctx, 1.0);
    //设置长方形4个顶点
    CGPoint poins[] = {CGPointMake(5, 5),CGPointMake(425, 5),CGPointMake(425, 125),CGPointMake(5, 125)};
    CGContextAddLines(ctx,poins,4);
    CGContextClosePath(ctx);
    CGContextStrokePath(ctx);
}

@end
