//
//  BetInfo.h
//  LetsBet
//
//  Created by 张亦弛 on 14-5-25.
//  Copyright (c) 2014年 Larkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BetInfo : NSObject

@property (atomic, strong) NSString *betName, *intro, *voteA, *voteB, *starter;
@property (atomic) NSInteger sumA, sumB;

@end
