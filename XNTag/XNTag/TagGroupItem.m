//
//  TagGroupItem.m
//  XNTag
//
//  Created by 娜 on 16/9/6.
//  Copyright © 2016年 XCN. All rights reserved.
//

#import "TagGroupItem.h"
#import "TagItems.h"
//tag的高度
CGFloat const itemHeight = 30;

@implementation TagGroupItem
+(instancetype)tagGroupItemWithDic:(NSDictionary *)dic
{
    TagGroupItem *tagGroupItem = [[self alloc]init];
    [tagGroupItem setValuesForKeysWithDictionary:dic];
    return tagGroupItem;
}

/**
 *  重写父类 dataArray 的 set 方法
*/
-(void)setData:(NSMutableArray *)data
{
    NSMutableArray *datas = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        TagItems *item = [TagItems tagWithDic:dic];
        [datas addObject:item];
    }
    _data = datas;
}

/**
 *  自适应cell的高度
 *
 *  @return  cell 的高度
 */
-(CGFloat)setCellHeight
{
    //最初的Y 值
    CGFloat beginY = 27;
    //行间距
    CGFloat margin = 10;
    //列数
    NSInteger cols = 4;
    //行数
    NSInteger rows = (self.data.count - 1) / cols + 1;
    return rows * (itemHeight + margin) + beginY;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
