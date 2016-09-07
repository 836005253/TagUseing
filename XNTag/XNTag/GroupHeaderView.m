//
//  GroupHeaderView.m
//  XNTag
//
//  Created by 娜 on 16/9/7.
//  Copyright © 2016年 XCN. All rights reserved.
//

#import "GroupHeaderView.h"

@interface GroupHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *groupLable;

@end

@implementation GroupHeaderView

+(instancetype)groupHeaderView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

-(void)setGroupItem:(GroupItem *)groupItem{
    _groupItem = groupItem;
    _groupLable.text = groupItem.name;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
