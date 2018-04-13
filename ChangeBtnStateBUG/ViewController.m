//
//  ViewController.m
//  ChangeBtnStateBUG
//
//  Created by 杜文亮 on 2018/4/13.
//  Copyright © 2018年 心动文学. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //无论是UIButtonTypeSystem还是UIButtonTypeCustom类型，都会有此问题
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(0, 0, 300, 100);
    btn.center = self.view.center;
    [btn setTitle:@"nomal" forState:UIControlStateNormal];
    [btn setTitle:@"selected" forState:UIControlStateSelected];
    [btn setTitle:@"disable" forState:UIControlStateDisabled];
    [btn addTarget:self action:@selector(log) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    /*
        1,从nomal状态切换至其他状态这是肯定没问题的。
        2,但是打开下面注释，从select状态切换至disable状态会出现，按钮的确是不可点击了，但是显示的却是nomal状态的文字。
        3,图片暂时没测试，不知道是否存在此问题
     */
    btn.selected = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
       {
           //解决办法：先还原至nomal状态
//           btn.selected = NO;
           
           btn.enabled = NO;
       });
}

-(void)log
{
    NSLog(@"111111");
}


@end
