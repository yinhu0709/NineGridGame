//
//  NineViewController.m
//  NineGridGame
//
//  Created by Tim (Xinyin) Liu on 27/9/17.
//  Copyright © 2017年 nextlabs. All rights reserved.
//

#import "NineViewController.h"

@interface NineViewController ()

@end

@implementation NineViewController {
    int whiteNum;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //随机产生一个空格
     whiteNum = arc4random()%9;
    // 产生九个无序的并且是偶排列
    NSArray *dataArray = [NSArray arrayWithObjects:@1,@2,@3,@4,@5,@6,@7,@8, nil];
//   dataArray = [self randamArray:dataArray];
    // 对数组乱序并且组成偶排列
    __block NSArray *newArray = [NSArray array];
    newArray = [dataArray sortedArrayUsingComparator:^NSComparisonResult(NSNumber  * obj1, NSNumber  * obj2) {
        int seed = arc4random_uniform(2);
        if (seed) {
            return [obj1 compare:obj2];
        }else {
            return [obj2 compare:obj1];
        }
    }];
    while ([self isOddQueueWSithArray:newArray]) {
        newArray = [dataArray sortedArrayUsingComparator:^NSComparisonResult(NSNumber  * obj1, NSNumber  * obj2) {
            int seed = arc4random_uniform(2);
            if (seed) {
                return [obj1 compare:obj2];
            }else {
                return [obj2 compare:obj1];
            }
        }];
    }
    NSMutableArray *btnArray = [NSMutableArray array];
    // 创建九宫格
       for (int i = 0; i<9; i++) {
        int row = i/3;
        int line = i%3;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(50+line*(100+5), 100+row*105, 100, 100);
        btn.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:btn];
        btn.tag = 100 + i;
        btn.tag = whiteNum + 100;
        if (i!= whiteNum) {
            [btnArray addObject:btn];
            btn.tag = 100 +i;
        }
    }
    // 给其中八个赋值
    for (int i = 0;i<btnArray.count;i++) {
        UIButton *btn = btnArray[i];
        [btn setTitle:[(NSNumber*)newArray[i] stringValue] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:20];
        btn.backgroundColor = [UIColor cyanColor];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)btnClick:(UIButton *)sender {
    UIButton *btn = (UIButton *)[self.view viewWithTag:100 + whiteNum];
    CGFloat whiteBtnX = btn.frame.origin.x;
    CGFloat whiteBtnY = btn.frame.origin.y;
    CGFloat moveBtnX = sender.frame.origin.x;
    CGFloat moveBtnY = sender.frame.origin.y;
    
    if ((whiteBtnX == moveBtnX && fabs(whiteBtnY-moveBtnY) == 105) ||((whiteBtnY == moveBtnY && fabs(whiteBtnX-moveBtnX) == 105))) {
        CGRect frame = btn.frame;
        btn.frame = sender.frame;
        sender.frame = frame;
    }
}
#pragma mark ------> 判断是否为奇排列
- (BOOL)isOddQueueWSithArray:(NSArray *)array{
    int inverseNum = 0;
    if (!array) {
        return nil;
    }
    for (int a = 0; a<array.count; a++) {
        NSNumber *frontNum = array[a];
        for (int b = a; b<array.count; b++) {
            NSNumber *backNum = array[b];
            if ([frontNum compare:backNum] == NSOrderedDescending) {
                inverseNum++;
            }
        }
    }
    if (inverseNum%2 == 1) {
        return YES;
    }
    return NO;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
