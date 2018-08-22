//
//  RuntimeManager.m
//  TimerCategory
//
//  Created by yite on 2018/8/13.
//  Copyright © 2018年 yite. All rights reserved.
//

#import "RuntimeManager.h"
#import <objc/runtime.h>
@implementation RuntimeManager

+ (void)swizzleClass:(Class)class OrigionMethod:(SEL)oriSel withNewMethod:(SEL)newSel {
    Method origionMethod = class_getClassMethod(class, oriSel);
    Method newMethod = class_getClassMethod(class, newSel);
    
    BOOL isAddSuc =  class_addMethod(class, oriSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if(isAddSuc) {
        class_replaceMethod(class, newSel, method_getImplementation(origionMethod), method_getTypeEncoding(origionMethod));
    }
    else {
        method_exchangeImplementations(newMethod, origionMethod);
    }
}

+ (void)swizzleInstance:(Class)class OrigionMethod:(SEL)oriSel withNewMethod:(SEL)newSel {
    Method origionMethod = class_getInstanceMethod(class, oriSel);
    Method newMethod = class_getInstanceMethod(class, newSel);
    
    BOOL isAddSuc =  class_addMethod(class, oriSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if(isAddSuc) {
        class_replaceMethod(class, newSel, method_getImplementation(origionMethod), method_getTypeEncoding(origionMethod));
    }
    else {
        method_exchangeImplementations(newMethod, origionMethod);
    }
}




@end
