//
//  ViewController.m
//  NineGridGame
//
//  Created by Tim (Xinyin) Liu on 27/9/17.
//  Copyright © 2017年 Timliu. All rights reserved.
//

#import "ViewController.h"
#import "NineViewController.h"
#import "NRandomViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textF;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
}

- (IBAction)x3:(id)sender {
    NineViewController *nineVC = [[NineViewController alloc]init];
    [self.navigationController pushViewController:nineVC animated:YES];
    
}
- (IBAction)x4:(id)sender {
    NRandomViewController *randVC = [[NRandomViewController alloc]init];
    if ([self.textF.text intValue]>1&&[self.textF.text intValue]<8) {
        randVC.row = [self.textF.text intValue];
        randVC.line = [self.textF.text intValue];
        [self.navigationController pushViewController:randVC animated:YES];
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


@end
