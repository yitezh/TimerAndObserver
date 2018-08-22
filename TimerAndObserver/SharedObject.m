//
//  SharedObject.m
//  TimerCategory
//
//  Created by yite on 2018/8/20.
//  Copyright © 2018年 yite. All rights reserved.
//

#import "SharedObject.h"

@implementation SharedObject


+ (instancetype) sharedInstance {
    static SharedObject *sharedObject;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [SharedObject new];
    });
    return sharedObject;
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context  {
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
}
@end
