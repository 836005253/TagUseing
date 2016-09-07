//
//  DragTagViewController.m
//  XNTag
//
//  Created by 娜 on 16/9/1.
//  Copyright © 2016年 XCN. All rights reserved.
//

#import "DragTagViewController.h"
#import "TagList.h"
@interface DragTagViewController ()

@end

@implementation DragTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array = @[@"一头牛",@"两匹马",@"三条鱼",@"四只鸭",@"五朵花",@"六个梨",@"七个球",@"八个🍎",@"九个➕",@"十个🍊",@"是一家",@"棒棒哒"];
    //创建标签列表
    TagList *tagList = [[TagList alloc]init];
    tagList.backgroundColor = [UIColor lightGrayColor];
    //设置标签列表 frame，高度可为0，会自动跟随标题计算
    tagList.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64);
    //设置标签背景
    tagList.tagBgColor = [UIColor brownColor];
    //设置标签颜色
    tagList.tagColor = [UIColor whiteColor];
    //设置缩放比例系数
    tagList.sortWithTagScale = 1.3;
    tagList.customTagSize = CGSizeMake(80, 30);
    tagList.isSort = YES;
    tagList.isFitTagListHeight = NO;
    [self.view addSubview:tagList];
    [tagList addTags:array];

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
