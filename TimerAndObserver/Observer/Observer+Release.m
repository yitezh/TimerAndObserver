//
//  Observer+Release.m
//  TimerCategory
//
//  Created by yite on 2018/8/14.
//  Copyright © 2018年 yite. All rights reserved.
//

#import "Observer+Release.h"
#import "RuntimeManager.h"
#import <objc/runtime.h>
#import "KVODelegate.h"
#import "KVOInfo.h"

const NSString *kvoDelegateKey = @"kvoDelegateKey";
const NSString *isObserveredKey = @"isObserveredKey";
const NSString *deallocObjectKey = @"deallocObjectKey";
@implementation NSObject(Observer)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *selNameArray = @[NSStringFromSelector(@selector(addObserver:forKeyPath:options:context:)),
                                  NSStringFromSelector(@selector(removeObserver:forKeyPath:context:)),
                                  ];
        for (NSString *name in selNameArray) {
            SEL oriSel = NSSelectorFromString(name);
            NSString *newSelString = [NSString stringWithFormat:@"YT_%@",NSStringFromSelector(oriSel)];
            SEL newSel = NSSelectorFromString(newSelString);
            Class class = [self class];
            [RuntimeManager swizzleInstance:class OrigionMethod:oriSel withNewMethod:newSel];
        }
    });
    
}


- (void)YT_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    KVODelegate *kvoDelegate = self.kvoDelegate;
    //绑定一个对象检测对象释放
    [self bindDeallocObjectForObserver:observer keyPath:keyPath context:context];
    
    if([kvoDelegate shouldAddTargetWithObject:self Observer:observer forKeyPath:keyPath option:options context:context])
    {
        [self YT_addObserver:self.kvoDelegate forKeyPath:keyPath options:options context:context];
    }
}

- (void)bindDeallocObjectForObserver:(id)observer keyPath:(NSString *)keyPath context:(void *)context{
    if([observer deallocObject]) return;
    
    DeallocObject *deaObj = [[DeallocObject alloc] init];
    __weak typeof(self) weakSelf = self;
    
    deaObj.bindObject= observer;
    [observer setDeallocObject:deaObj];
    
    deaObj.reBlock = ^(id obj) {
        [weakSelf.kvoDelegate removeOneObserver:obj];
        [weakSelf removeObserver:obj forKeyPath:keyPath context:context];
    };
}

- (void)YT_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(nullable void *)context{
    KVODelegate *kvoDelegate = self.kvoDelegate;
    if([kvoDelegate shouldRemoveTargetWithObject:self Observer:observer forKeyPath:keyPath context:context]) {
        [self YT_removeObserver:self.kvoDelegate forKeyPath:keyPath context:context];
    }
}


- (KVODelegate *)kvoDelegate {
    KVODelegate *delegate = objc_getAssociatedObject(self,&kvoDelegateKey);
    if(!delegate) {
        delegate = [[KVODelegate alloc]init];
        self.kvoDelegate = delegate;
    }
    return delegate;
}

- (void)setKvoDelegate:(KVODelegate *)kvoDelegate {
    objc_setAssociatedObject(self, &kvoDelegateKey, kvoDelegate, OBJC_ASSOCIATION_RETAIN);
}

- (DeallocObject *)deallocObject {
    DeallocObject *deaObj = objc_getAssociatedObject(self,&deallocObjectKey);
    return deaObj;
}

- (void)setDeallocObject:(DeallocObject *)deallocObject {
    objc_setAssociatedObject(self, &deallocObjectKey, deallocObject, OBJC_ASSOCIATION_RETAIN);
}


@end
