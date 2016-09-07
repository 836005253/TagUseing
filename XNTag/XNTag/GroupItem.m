//
//  GroupItem.m
//  XNTag
//
//  Created by 娜 on 16/9/6.
//  Copyright © 2016年 XCN. All rights reserved.
//

#import "GroupItem.h"
#import "TagGroupItem.h"
@implementation GroupItem
+(instancetype)groupWithDic:(NSDictionary *)dic
{
    GroupItem *groupItem = [[self alloc]init];
    [groupItem setValuesForKeysWithDictionary:dic];
    return groupItem;
}
/**
 *  dataArray的 set 方法
 *
 *  @param dataArray 标签数组
 */
-(void)setData:(NSMutableArray *)data
{
    NSMutableArray *datas = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        TagGroupItem *item = [TagGroupItem tagGroupItemWithDic:dic];
        [datas addObject:item];
    }
    _data = datas;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
