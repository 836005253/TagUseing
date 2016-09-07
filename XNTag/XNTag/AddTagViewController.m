//
//  AddTagViewController.m
//  XNTag
//
//  Created by 娜 on 16/8/31.
//  Copyright © 2016年 XCN. All rights reserved.
//

#import "AddTagViewController.h"
#import "TagList.h"
static int count = 0;
@interface AddTagViewController ()
@property(nonatomic,strong) NSArray *titleArr;
@property (nonatomic,strong) TagList *tagList;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;


@end

@implementation AddTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArr = @[@"一个都不能少",@"beyond",@"真的爱你",@"周杰伦",@"红尘客栈"];
    //创建标签列表
    self.tagList = [[TagList alloc]init];
    self.tagList.backgroundColor = [UIColor lightGrayColor];
    //点击标签就会调用，然后删除按钮
    __weak typeof(self.tagList) weakSelf = self.tagList;
    self.tagList.clickTagBlock = ^(NSString *tag){
        [weakSelf deleteTag:tag];
    };
    //设置标签列表 frame，高度可为0，会自动跟随标题计算
    self.tagList.frame = CGRectMake(0, 64, self.view.frame.size.width, 0);
    //设置标签背景
    self.tagList.tagBgColor = [UIColor brownColor];
    //设置标签颜色
    self.tagList.tagColor = [UIColor whiteColor];
    //设置删除标签图片
    self.tagList.deleteTagImamge = [UIImage imageNamed:@"chose_tag_close_icon"];
    //设置缩放比例系数
    self.tagList.sortWithTagScale = 1.3;
    self.tagList.isSort = NO;
    self.tagList.isFitTagListHeight = YES;
    [self.view addSubview:self.tagList];
}


//添加标签
- (IBAction)AddTagToViewWithClick:(id)sender {
    
    NSString *tagStr = [NSString stringWithFormat:@"%@ (%d)",self.titleArr[arc4random_uniform(5)],count];
    [self.tagList addTag:tagStr];
    count++;
    
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
