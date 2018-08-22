//
//  ObserverViewController.m
//  TimerCategory
//
//  Created by yite on 2018/8/20.
//  Copyright © 2018年 yite. All rights reserved.
//

#import "ObserverViewController.h"
#import "SharedObject.h"
@interface ObserverViewController ()

@end

@implementation ObserverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    SharedObject *object = [SharedObject sharedInstance];
    
    
    object.changeStr = @"ObserverViewController_before";
    
//    [object removeObserver:self forKeyPath:@"changeStr" context:nil];
//     [object removeObserver:self forKeyPath:@"changeStr" context:nil];
    [object addObserver:self forKeyPath:@"changeStr" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [object addObserver:self forKeyPath:@"changeStr" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];

    [object addObserver:self forKeyPath:@"changeStr" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];

    [object addObserver:self forKeyPath:@"changeStr" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];

    
//     [object addObserver:self forKeyPath:@"changeStr" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
//     [object addObserver:self forKeyPath:@"changeStr" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    object.changeStr = @"ObserverViewController_after";
    // Do any additional setup after loading the view from its nib.
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context  {

    NSLog(@"%@",NSStringFromSelector(_cmd));
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {

    NSLog(@"%s",__PRETTY_FUNCTION__);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
