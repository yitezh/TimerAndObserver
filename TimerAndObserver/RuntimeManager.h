//
//  RuntimeManager.h
//  TimerCategory
//
//  Created by yite on 2018/8/13.
//  Copyright © 2018年 yite. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RuntimeManager : NSObject
//
+ (void)swizzleClass:(Class)class OrigionMethod:(SEL)oriSel withNewMethod:(SEL)newSel;
+ (void)swizzleInstance:(Class)class OrigionMethod:(SEL)oriSel withNewMethod:(SEL)newSel;
@end
