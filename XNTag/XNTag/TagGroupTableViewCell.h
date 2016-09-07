//
//  TagGroupTableViewCell.h
//  XNTag
//
//  Created by 娜 on 16/9/6.
//  Copyright © 2016年 XCN. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TagGroupItem;
@interface TagGroupTableViewCell : UITableViewCell
@property (nonatomic,strong) TagGroupItem *tagGroupItem;
@property (weak, nonatomic) IBOutlet UICollectionView *tagGroupCollectionView;

@end
