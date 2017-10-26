//
//  NRandomViewController.m
//  NineGridGame
//
//  Created by Tim (Xinyin) Liu on 28/9/17.
//  Copyright © 2017年 Timliu. All rights reserved.
//
#define NSWidth 50
#define NSSpace 5
#import "NRandomViewController.h"

@interface NRandomViewController () {
    int _whiteNum;
    int _whiteRow;
    int _whiteLine;
    int _rowTotal;
    int _lineTotal;
    int _inverseNum;
    int _totalNum;
}

@end

@implementation NRandomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _rowTotal = self.row;
    _lineTotal = self.line;
    int total = _rowTotal *_lineTotal;
    NSArray *titleArray = [self titleArraywithTotalCount:total];
    NSLog(@"-=----%d----",[self isCanFinishedWithArray:titleArray]);
    NSMutableArray *btnArray = [NSMutableArray array];
    for (int i = 0; i<total; i++) {
        int row = i/_rowTotal;
        int line = i%_rowTotal;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(20+line*(NSWidth+NSSpace), 100+(NSWidth+NSSpace)*row, NSWidth, NSWidth);
        btn.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:btn];
        [btnArray addObject:btn];

    }

    for (int i = 0;i<titleArray.count;i++ ) {
        UIButton *btn = (UIButton *)btnArray[i];
        NSNumber *currentNum = titleArray[i];
        btn.tag = 100 + i;
        if ([currentNum isEqualToNumber:@0]) {
//            _whiteNum = i;
            btn.backgroundColor = [UIColor whiteColor];
        }else {
            btn.backgroundColor = [UIColor cyanColor];
            [btn setTitle:[currentNum stringValue]  forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
}

- (void)buttonClick:(UIButton *)sender {
    UIButton *btn = (UIButton *)[self.view viewWithTag:100+_whiteNum];
    CGFloat whiteBtnX = btn.frame.origin.x;
    CGFloat whiteBtnY = btn.frame.origin.y;
    CGFloat moveBtnX = sender.frame.origin.x;
    CGFloat moveBtnY = sender.frame.origin.y;
    
    if ((whiteBtnX == moveBtnX && fabs(whiteBtnY-moveBtnY) == NSWidth+NSSpace) ||((whiteBtnY == moveBtnY && fabs(whiteBtnX-moveBtnX) == NSWidth+NSSpace))) {
        CGRect frame = btn.frame;
        btn.frame = sender.frame;
        sender.frame = frame;
}
}



- (NSMutableArray *)titleArraywithTotalCount:(int)totalCount {
    
    NSMutableArray *array = [NSMutableArray array];
    while (array.count < totalCount) {
        int num = arc4random()%totalCount;
        if (![array containsObject:[NSNumber numberWithInt:num]]) {
            [array addObject:[NSNumber numberWithInt:num]];
        }
    }
  _whiteNum = (int)[array indexOfObject:@0];
    if (![self isCanFinishedWithArray:array]) {
        [array removeAllObjects];
       return  [self titleArraywithTotalCount:totalCount];
    }else {
    return array;
}
}
//#pragma mark ------> 判断是否为奇排列
//- (BOOL)isOddQueueWSithArray:(NSArray *)array{
//    int inverseNum = 0;
//    if (!array) {
//        return nil;
//    }
//    for (int a = 0; a<array.count; a++) {
//        NSNumber *frontNum = array[a];
//        for (int b = a; b<array.count; b++) {
//            NSNumber *backNum = array[b];
//            if ([frontNum compare:backNum] == NSOrderedDescending) {
//                inverseNum++;
//            }
//        }
//    }
//    _inverseNum = inverseNum;
//    if (inverseNum%2 == 1) {
//        return YES;
//    }
//    return NO;
//}
//#pragma mark -----> 获取队列的逆序数
//- (int)getQueueInerseNumberWithArray:(NSArray *)array {
//    int inverseNum = 0;
//        for (int a = 0; a<array.count; a++) {
//        NSNumber *frontNum = array[a];
//        for (int b = a; b<array.count; b++) {
//            NSNumber *backNum = array[b];
//            if ([frontNum compare:backNum] == NSOrderedDescending) {
//                inverseNum++;
//            }
//        }
//    }
//    _inverseNum = inverseNum;
//    
//    return _inverseNum;
//}
//#pragma mark ------> 获取空格曼哈顿距离
//- (int)whiteGridManHattanDistance {
//    _whiteRow = _whiteNum/_rowTotal;
//    _whiteLine = _whiteNum%_lineTotal;
//    int distance = _rowTotal + _lineTotal - _whiteRow - _whiteLine-2;
//    
//    return distance;
//}
//#pragma mark -------> 获取总状态数的奇偶性
//- (BOOL)isOddTotalStateWithQueueArray:(NSArray *)array {
//    int totalStateNum = [self getQueueInerseNumberWithArray:array] + [self whiteGridManHattanDistance];
//    if (totalStateNum %2 == 1) {
//        return YES;
//    } else {
//        return NO;
//    }
//}
//#pragma mark -------> 判断矩阵的奇偶性
//- (BOOL)isOddMatrix {
//    int matrix = _rowTotal *_lineTotal - 1;
//    if (matrix%2 == 1) {
//        return YES;
//    }
//    return NO;
//}
//
//#pragma mark ------>是否可复原 (队列总状态数的奇偶性与矩阵的奇偶性相同时，可以复原)
//- (BOOL)isCanFinishedOfTheMatrixWithArray:(NSArray *)array{
//    BOOL isOddMatrix = [self isOddMatrix];
//    BOOL isOddTotalState = [self isOddTotalStateWithQueueArray:array];
//    
//    if ([[NSNumber numberWithBool:isOddMatrix] isEqualToNumber:[NSNumber numberWithBool:isOddTotalState]]) {
//        return YES;
//    }else {
//        return NO;
//    }
//}

#pragma mark ----> 判断是否可以复原
- (BOOL)isCanFinishedWithArray:(NSArray *)array {
    // 获取队列的逆序数
    NSLog(@"++++++%@++++",array);
    int inverseNum = 0;
    for (int a = 0; a<array.count; a++) {
        NSNumber *frontNum = array[a];
        for (int b = a; b<array.count; b++) {
            NSNumber *backNum = array[b];
            if ([frontNum compare:backNum] == NSOrderedDescending) {
                inverseNum++;
            }
        }
    }
    _inverseNum = inverseNum;
    // 获取矩阵的曼哈顿距离
    _whiteRow = _whiteNum/_rowTotal;
    _whiteLine = _whiteNum%_lineTotal;
    int distance = _rowTotal + _lineTotal - _whiteRow - _whiteLine-2;
    NSLog(@"空格数%d,第几行%d,第几列%d",_whiteNum,_whiteRow,_whiteLine);
    // 获取矩阵的奇偶性
    int matrix = _rowTotal *_lineTotal - 1;
    
    int total = _inverseNum + distance + matrix;
    NSLog(@"逆序数%d,曼哈顿距离%d,矩阵数%d,总数%d",_inverseNum,distance,matrix,total);
    if (total%2==1) {
        return NO;
    } else {
        return YES;
    }
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
