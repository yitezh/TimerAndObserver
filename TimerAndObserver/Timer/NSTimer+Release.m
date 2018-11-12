//
//  NSTimer+Release.m
//  TimerCategory
//
//  Created by yite on 2018/8/13.
//  Copyright © 2018年 yite. All rights reserved.
//

#import "NSTimer+Release.h"
#import <objc/runtime.h>
#import "RuntimeManager.h"
const NSString *timerkey = @"timerkey";
@implementation NSTimer(Release)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *selNameArray = @[@"scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:",@"timerWithTimeInterval:target:selector:userInfo:repeats:"];
        for (NSString *name in selNameArray) {
            SEL oriSel = NSSelectorFromString(name);
            NSString *newSelString = [NSString stringWithFormat:@"YT_%@",NSStringFromSelector(oriSel)];
            SEL newSel = NSSelectorFromString(newSelString);
            Class class = object_getClass((id)self);
            [RuntimeManager swizzleClass:class OrigionMethod:oriSel withNewMethod:newSel];
        }
    });
}

+ (NSTimer *)YT_timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo {
    if(yesOrNo) {   //不重复的定时器不需要特殊处理
        return  [self transToTimerDelegateInterval:ti target:aTarget selector:aSelector userInfo:userInfo repeats:yesOrNo WithSwizzleSel:@selector(YT_timerWithTimeInterval:target:selector:userInfo:repeats:)] ;
    }
    else {
        return  [self YT_timerWithTimeInterval:ti target:aTarget selector:aSelector userInfo:userInfo repeats:yesOrNo];
    }
}


+ (NSTimer *)YT_scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo{
    if(yesOrNo) {
    return  [self transToTimerDelegateInterval:ti target:aTarget selector:aSelector userInfo:userInfo repeats:yesOrNo WithSwizzleSel:@selector(YT_scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:)];
    }
    else {
    return  [self YT_scheduledTimerWithTimeInterval:ti target:aTarget selector:aSelector userInfo:userInfo repeats:yesOrNo];
    }
}

+ (NSTimer *)transToTimerDelegateInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo WithSwizzleSel:(SEL)swizzleSel {
    
    TimerDelegate *timerDelegate = [[TimerDelegate alloc]init];;
    
    //将原目标对象和参数传递给delegate
    [timerDelegate handleTarget:aTarget selector:aSelector userInfo:userInfo];
    
    SEL sel = NSSelectorFromString(@"sub_timerClick:");
    
    //调用交换后的方法,此处将定时器对象设置delegate,
    IMP imp = [self methodForSelector:swizzleSel];
    NSTimer * (*func)(id, SEL, NSTimeInterval ,id,SEL,id,BOOL)= (void *)imp;
    return  func(self,swizzleSel,ti,timerDelegate,sel,userInfo,yesOrNo);
}




@end
