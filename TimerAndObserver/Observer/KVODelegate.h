//
//  KVODelegate.h
//  TimerCategory
//
//  Created by yite on 2018/8/14.
//  Copyright © 2018年 yite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KVOInfo.h"
@interface KVODelegate : NSObject


- (BOOL)isAddActionWithObject:(id)object Observer:(id)observer forKeyPath:(NSString *)keyPath option:(NSKeyValueObservingOptions)options context:(void *)context;

- (BOOL)isRemoveActionWithObject:(id)object Observer:(id)observer forKeyPath:(NSString *)keyPath context:(void *)context;

- (void)removeOneObserver:(id)oneObserver;
@end
