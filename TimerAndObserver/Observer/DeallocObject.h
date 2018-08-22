//
//  DeallocObject.h
//  TimerCategory
//
//  Created by yite on 2018/8/22.
//  Copyright © 2018年 yite. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^ReleaseBlock) (id obj);
@interface DeallocObject : NSObject

@property (weak,nonatomic) id TObject;
@property (copy,nonatomic) ReleaseBlock reBlock;

@end
