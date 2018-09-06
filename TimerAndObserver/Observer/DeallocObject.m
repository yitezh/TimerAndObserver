//
//  DeallocObject.m
//  TimerCategory
//
//  Created by yite on 2018/8/22.
//  Copyright © 2018年 yite. All rights reserved.
//

#import "DeallocObject.h"

@implementation DeallocObject


-(void)dealloc {
    NSLog(@"DeallocObject");
    if(_reBlock) {
        _reBlock(_bindObject);
    }
}


@end
