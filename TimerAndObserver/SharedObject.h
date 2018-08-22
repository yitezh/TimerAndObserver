//
//  SharedObject.h
//  TimerCategory
//
//  Created by yite on 2018/8/20.
//  Copyright © 2018年 yite. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedObject : NSObject
+ (instancetype) sharedInstance;

@property (strong,nonatomic)NSString *changeStr;
@end
