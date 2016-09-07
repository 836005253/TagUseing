//
//  TagItem.m
//  XNTag
//
//  Created by 娜 on 16/9/6.
//  Copyright © 2016年 XCN. All rights reserved.
//

#import "TagItems.h"

@implementation TagItems
+(instancetype)tagWithDic:(NSDictionary *)dic{
    TagItems *tagItem = [[self alloc]init];
    [tagItem setValuesForKeysWithDictionary:dic];
    return tagItem;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
