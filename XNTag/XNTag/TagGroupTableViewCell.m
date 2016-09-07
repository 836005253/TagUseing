//
//  TagGroupTableViewCell.m
//  XNTag
//
//  Created by 娜 on 16/9/6.
//  Copyright © 2016年 XCN. All rights reserved.
//

#import "TagGroupTableViewCell.h"
#import "TagCollectionViewCell.h"
#import "TagGroupItem.h"
#import "TagItems.h"
extern CGFloat const itemHeight;
static NSString *CELL = @"tagGroupCell";
@interface TagGroupTableViewCell ()<UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *tagGroupItemLable;

@end
@implementation TagGroupTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellAccessoryNone;
    UICollectionViewFlowLayout *flowLayout = self.tagGroupCollectionView.collectionViewLayout;
    CGFloat margin = 10;
    CGFloat cols = 4;
    CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width - (cols + 1) * margin) / cols;
    flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
    flowLayout.minimumLineSpacing = margin;
    flowLayout.minimumInteritemSpacing = margin;
    
    //设置 collectionView
    self.tagGroupCollectionView.dataSource = self;
    self.tagGroupCollectionView.scrollEnabled = NO;
    self.tagGroupCollectionView.backgroundColor = [UIColor whiteColor];
    [self.tagGroupCollectionView registerNib:[UINib nibWithNibName:@"TagCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CELL];
    
}

-(void)setTagGroupItem:(TagGroupItem *)tagGroupItem{
    _tagGroupItem = tagGroupItem;
    _tagGroupItemLable.text = tagGroupItem.name;
    [self.tagGroupCollectionView reloadData];
}

#pragma mark -- tagGroupCollectionView dataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _tagGroupItem.data.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TagCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL forIndexPath:indexPath];
    TagItems *item = _tagGroupItem.data[indexPath.row];
    cell.tagItem = item;
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
