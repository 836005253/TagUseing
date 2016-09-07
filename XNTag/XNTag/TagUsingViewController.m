//
//  TagUsingViewController.m
//  XNTag
//
//  Created by 娜 on 16/8/31.
//  Copyright © 2016年 XCN. All rights reserved.
//

#import "TagUsingViewController.h"
#import "GroupItem.h"
#import "TagGroupItem.h"
#import "HobbyTableViewCell.h"
#import "TagList.h"
#import "TagGroupTableViewCell.h"
#import "GroupHeaderView.h"
#import "TagCollectionViewCell.h"
#import "TagItems.h"
static NSString * const HobbyCell = @"hobbycell";
static NSString * const TagGroupCell = @"taggroupcell";
@interface TagUsingViewController ()<UICollectionViewDelegate>
//分组数组
@property(nonatomic,strong) NSMutableArray *groupsArray;
@property (nonatomic,strong) TagList *tagList;
@property (nonatomic,strong) NSMutableDictionary *selectidDic;
@end

@implementation TagUsingViewController
#pragma marks - lazy
-(NSMutableArray *)groupsArray{
    if (_groupsArray == nil) {
        _groupsArray = [NSMutableArray array];
    }
    return _groupsArray;
}

-(TagList *)tagList{
    if (_tagList == nil) {
        _tagList = [[TagList alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
        _tagList.tagBgColor = [UIColor brownColor];
        _tagList.tagCornerRadius = 6;
        __weak typeof(self) weakSelf = self;
        _tagList.clickTagBlock = ^(NSString *tag){
            [weakSelf clickTag:tag];
        };
        _tagList.tagColor = [UIColor whiteColor];
        _tagList.isFitTagListHeight = YES;
    }
    return _tagList;
}

-(NSMutableDictionary *)selectidDic{
    if (_selectidDic == nil) {
        _selectidDic = [NSMutableDictionary dictionary];
    }
    return _selectidDic;
}

-(void)clickTag:(NSString *)tag{
    //删除标签
    [self.tagList deleteTag:tag];
    //刷新第0组
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:(UITableViewRowAnimationNone)];
    
    // 更新cell标题
    TagCollectionViewCell *cell = self.selectidDic[tag];
    TagItems *item = cell.tagItem;
    item.isSelected = !item.isSelected;
    cell.tagItem = item;
    
    // 移除选中的cell
    [self.selectidDic removeObjectForKey:tag];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建第一组
    GroupItem *group = [[GroupItem alloc]init];
    group.name = @"兴趣项目";
    group.data = [NSMutableArray array];
    [self.groupsArray addObject:group];
    
    TagGroupItem *tagGroupItem = [[TagGroupItem alloc]init];
    tagGroupItem.data = [NSMutableArray array];
    [group.data addObject:tagGroupItem];
    
    
    //剩余组的数据
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"hobby" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    for (NSDictionary *dic in array) {
        GroupItem *groupItem = [GroupItem groupWithDic:dic];
        [self.groupsArray addObject:groupItem];
    }
    
    
    //注册hobbycell
    [self.tableView registerClass:[HobbyTableViewCell class] forCellReuseIdentifier:HobbyCell];
    //注册标签组 cell
    [self.tableView registerNib:[UINib nibWithNibName:@"TagGroupTableViewCell" bundle:nil] forCellReuseIdentifier:TagGroupCell];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}


#pragma marks - tableView delegate and dataSource
//返回共多少个组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.groupsArray.count;
}

//返回每组有多少个标签组
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    TagGroupItem *tagG = self.groupsArray[section];
    return tagG.data.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HobbyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HobbyCell];
        cell.tagList = self.tagList;
        return cell;
    }
    
    TagGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TagGroupCell forIndexPath:indexPath];
    GroupItem *group = self.groupsArray[indexPath.section];
    TagGroupItem *tagGroup = group.data[indexPath.row];
    cell.tagGroupCollectionView.delegate = self;
    cell.tagGroupItem = tagGroup;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return self.tagList.tagListHeight;
    }
    //获取标签组模型
    GroupItem *group = self.groupsArray[indexPath.section];
    TagGroupItem *tagGroup = group.data[indexPath.row];
    return tagGroup.setCellHeight;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    GroupHeaderView *headerView = [GroupHeaderView groupHeaderView];
    headerView.groupItem = self.groupsArray[section];
    return headerView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}


#pragma mark -- collectionView Delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TagCollectionViewCell *cell = (TagCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    TagItems *item = cell.tagItem;
    item.isSelected = !item.isSelected;
    cell.tagItem = item;
    NSString *strTag = [NSString stringWithFormat:@"%@ x",cell.tagLable.text];
    if (item.isSelected) {
        //添加标签
        [self.tagList addTag:strTag];
        [self.selectidDic setValue:cell forKey:strTag];
    }else{
        [self.tagList deleteTag:strTag];
    }
    //刷新第0组
    NSIndexSet *index = [NSIndexSet indexSetWithIndex:0];
    [self.tableView reloadSections:index withRowAnimation:(UITableViewRowAnimationNone)];
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
