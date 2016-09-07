//
//  TagCollectionViewCell.m
//  XNTag
//
//  Created by 娜 on 16/9/6.
//  Copyright © 2016年 XCN. All rights reserved.
//

#import "TagCollectionViewCell.h"
#import "TagItems.h"
@interface TagCollectionViewCell ()

@end

@implementation TagCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1;
}

-(void)setTagItem:(TagItems *)tagItem{
    _tagItem = tagItem;
    self.tagLable.text = tagItem.name;
    _tagLable.textColor = tagItem.isSelected ? [UIColor redColor] : [UIColor colorWithRed:136 / 255.0 green:136 / 255.0 blue:136 / 255.0 alpha:1];
}
@end
