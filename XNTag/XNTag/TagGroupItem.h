//
//  TagGroupItem.h
//  XNTag
//
//  Created by 娜 on 16/9/6.
//  Copyright © 2016年 XCN. All rights reserved.
//

#import "GroupItem.h"
#import <UIKit/UIKit.h>
@interface TagGroupItem : GroupItem
+(instancetype)tagGroupItemWithDic:(NSDictionary *)dic;
-(CGFloat)setCellHeight;
@end
