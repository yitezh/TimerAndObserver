//
//  KVOInfo.h
//  TimerCategory
//
//  Created by yite on 2018/8/15.
//  Copyright © 2018年 yite. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVOInfo : NSObject

@property (weak,nonatomic)NSObject *observer;
@property (weak,nonatomic)NSObject *observeredObject;
@property (strong,nonatomic)NSString *keyPath;
@property (assign,nonatomic)void *objectContext;

@end
