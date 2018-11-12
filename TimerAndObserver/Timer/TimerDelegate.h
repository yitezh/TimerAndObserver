//
//  TimerDelegate.h
//  TimerCategory
//
//  Created by yite on 2018/8/13.
//  Copyright © 2018年 yite. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimerDelegate : NSObject

- (void)handleTarget:(id)aTarget  selector:(SEL)aSel  userInfo:(id)userInfo;


@property (weak,nonatomic)id desTarget;   //弱引用
@property (assign,nonatomic)SEL selector;
@property (strong,nonatomic)id userInfo;


@end
