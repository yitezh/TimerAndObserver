//
//  ViewController.m
//  TimerCategory
//
//  Created by yite on 2018/8/13.
//  Copyright © 2018年 yite. All rights reserved.
//

#import "ViewController.h"
#import "TimerViewController.h"
#import "ObserverViewController.h"
#import "SharedObject.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[SharedObject sharedInstance] addObserver:self forKeyPath:@"changeStr" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)buttonClicked:(id)sender {
    TimerViewController *view = [[TimerViewController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
}

- (IBAction)observerButtonClicked:(id)sender {
    ObserverViewController *view = [[ObserverViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
    
}

- (IBAction)changeButtonClicked:(id)sender {
    [SharedObject sharedInstance].changeStr = @"viewController";
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    NSLog(@"%s",__PRETTY_FUNCTION__);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
