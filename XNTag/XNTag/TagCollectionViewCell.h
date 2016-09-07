//
//  TagCollectionViewCell.h
//  XNTag
//
//  Created by 娜 on 16/9/6.
//  Copyright © 2016年 XCN. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TagItems;
@interface TagCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *tagLable;
@property (nonatomic,strong) TagItems *tagItem;

@end
