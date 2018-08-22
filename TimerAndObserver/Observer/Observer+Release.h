//
//  Observer+Release.h
//  TimerCategory
//
//  Created by yite on 2018/8/14.
//  Copyright © 2018年 yite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KVODelegate.h"
#import "DeallocObject.h"
@interface NSObject(Observer)

@property (strong,nonatomic)KVODelegate *kvoDelegate;
@property (strong,nonatomic)DeallocObject *deallocObject;
@end
