//
//  GroupHeaderView.h
//  XNTag
//
//  Created by 娜 on 16/9/7.
//  Copyright © 2016年 XCN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupItem.h"
@interface GroupHeaderView : UIView
@property (nonatomic,strong) GroupItem *groupItem;
+(instancetype)groupHeaderView;
@end
