//
//  SecondViewController.m
//  TimerCategory
//
//  Created by yite on 2018/8/13.
//  Copyright © 2018年 yite. All rights reserved.
//

#import "TimerViewController.h"
#import "SharedObject.h"
@interface TimerViewController ()

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerClick1:) userInfo:@{@"userName":@"yite"} repeats:YES];
    
   
   NSTimer *timer =  [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(timerClick2:) userInfo:@{@"userName":@"yite"}repeats:YES];
   [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)timerClick1:(NSTimer *)timer {

    NSLog(@"timerClicked1");
}

- (void)timerClick2:(NSTimer *)timer {
 
    NSLog(@"timerClicked2");
}






- (void)dealloc {
    NSLog(@"delloc");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
