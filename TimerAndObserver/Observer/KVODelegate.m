//
//  KVODelegate.m
//  TimerCategory
//
//  Created by yite on 2018/8/14.
//  Copyright © 2018年 yite. All rights reserved.
//

#import "KVODelegate.h"
#import "DeallocObject.h"
#import "Observer+Release.h"
@interface KVODelegate()
@property (strong,nonatomic) NSMutableDictionary  *kvoMaps;
@end

@implementation KVODelegate


- (BOOL)isAddActionWithObject:(id)object Observer:(id)observer forKeyPath:(NSString *)keyPath option:(NSKeyValueObservingOptions)options context:(void *)context {
    KVOInfo *info = [self getNewInfoWithObject:object observer:observer keyPath:keyPath context:context];
    NSMutableArray *infoArray = [self.kvoMaps objectForKey:keyPath];
    if(infoArray) {
        if([self isInfo:info ExistInArray:infoArray]) {
            NSLog(@"重复添加无效");
        } else {
            [infoArray addObject:info];
            [self.kvoMaps setObject:infoArray forKey:keyPath];
            NSLog(@"添加更新");
        }
        return YES;
    }
    else {
        NSMutableArray *infoArray = [NSMutableArray new];
        [infoArray addObject:info];
        [self.kvoMaps setObject:infoArray forKey:keyPath];
        
        return NO;
    }
}

- (void)removeOneObserver:(id)oneObserver {
    for (NSString *keyPath in self.kvoMaps.allKeys) {
        NSMutableArray *infoArray = [self.kvoMaps objectForKey:keyPath];
        NSMutableArray *tmpArray = infoArray.mutableCopy;
        for (KVOInfo *eachInfo in tmpArray) {
            if(eachInfo.observer == oneObserver || eachInfo.observer==nil) {
                [infoArray removeObject:eachInfo];
                NSLog(@"delloc 移除观察者");
            }
        }
        if(infoArray.count == 0)   {  //所有对象都删除了  才移除键
            [self.kvoMaps removeObjectForKey:keyPath];
            NSLog(@"移除keyPath：%@的监听",keyPath);
        }
    }
}

- (BOOL)isInfo:(KVOInfo *)info ExistInArray:(NSMutableArray *)infoArray {
    for (KVOInfo *eachInfo in infoArray) {
        if(eachInfo.observer== info.observer &&eachInfo.observeredObject==info.observeredObject) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isRemoveActionWithObject:(id)object Observer:(id)observer forKeyPath:(NSString *)keyPath context:(void *)context {
    BOOL isKeyRemoved = NO;
    NSMutableArray *infoArray = [self.kvoMaps objectForKey:keyPath];
    if(infoArray) {
        NSMutableArray *tmpArray = infoArray.mutableCopy;
        for (KVOInfo *eachInfo in tmpArray) {
            if(eachInfo.observer == observer || eachInfo.observer==nil) {
                [infoArray removeObject:eachInfo];
            }
        }
        if(infoArray.count == 0)   {  //所有对象都删除了  才移除键
            [self.kvoMaps removeObjectForKey:keyPath];
            isKeyRemoved = YES;
            NSLog(@"移除keyPath：%@的监听",keyPath);
        }
        return isKeyRemoved;
    }
    else {
        return isKeyRemoved;
    }

}


- (KVOInfo *)getNewInfoWithObject:(id)object observer:(id)observer keyPath:(NSString *)keyPath context:(void *)context {
    KVOInfo *info = [KVOInfo new];
    info.observer = observer;
    info.keyPath = keyPath;
    info.observeredObject = object;
    info.objectContext = context;
    return info;
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context {
    NSMutableArray *infoArray = [self.kvoMaps objectForKey:keyPath];
    NSMutableArray *tmpArray = infoArray.mutableCopy;
    for (KVOInfo *eachInfo in tmpArray) {
        if(eachInfo.observer==nil) {
           [infoArray removeObject:eachInfo];
            break;
        }
        if(eachInfo.observeredObject == object) {
          [eachInfo.observer observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
}

- (void)dealloc {
    NSLog(@"DelegateDelloc");
}


- (NSMutableDictionary *)kvoMaps{
    if(!_kvoMaps) {
       _kvoMaps =
        [[NSMutableDictionary alloc]init];
    }
    
    return _kvoMaps;
}


@end
