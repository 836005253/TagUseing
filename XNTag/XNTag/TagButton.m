//
//  TagButton.m
//  XNTag
//
//  Created by 娜 on 16/8/31.
//  Copyright © 2016年 XCN. All rights reserved.
//

#import "TagButton.h"
extern CGFloat const imageViewWh;
@implementation TagButton

-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.frame.size.width <= 0) return;
    
    CGFloat buttonW = self.bounds.size.width;
    CGFloat buttonH = self.bounds.size.height;
    self.titleLabel.frame = CGRectMake(self.margin, self.titleLabel.frame.origin.y, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
    
    CGFloat imageViewX = buttonW - self.imageView.frame.size.width - self.margin;
    self.imageView.frame = CGRectMake(imageViewX, (buttonH - imageViewWh) * 0.5, imageViewWh, imageViewWh);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
