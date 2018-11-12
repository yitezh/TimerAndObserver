//
//  TimerDelegate.m
//  TimerCategory
//
//  Created by yite on 2018/8/13.
//  Copyright © 2018年 yite. All rights reserved.
//

#import "TimerDelegate.h"
#import <objc/runtime.h>
@implementation TimerDelegate

- (void)sub_timerClick:(NSTimer *)timer {
    if(!_desTarget) {   //判断原对象是否已经释放
        [timer invalidate];
        timer = nil;
        return ;
    }
    
    if([_desTarget respondsToSelector:self.selector]) {
       //调用原对象的方法,因为selector无法确定，用performSelector有警告
        IMP imp = [_desTarget methodForSelector:_selector];
         void (*func)(id, SEL, NSTimer *) = (void *)imp;
         func(_desTarget, _selector, timer);
        
    }
}


- (void)handleTarget:(id)aTarget  selector:(SEL)aSel  userInfo:(id)userInfo {
    self.desTarget = aTarget;
    self.selector = aSel;
    self.userInfo = userInfo;
}


@end
