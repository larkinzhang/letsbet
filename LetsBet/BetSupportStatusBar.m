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

+ (UIImage *)drawStatusBar:(NSInteger)numA and:(NSInteger)numB
{
    CGFloat width = 280, height = 35;
    UIImage *red = [UIImage imageNamed:@"red"];
    UIImage *blue = [UIImage imageNamed:@"blue"];
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    CGFloat partition = width * numA / (numA + numB);
    [red drawInRect:CGRectMake(0, 0, partition, height)];
    [blue drawInRect:CGRectMake(partition, 0, width - partition, height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
