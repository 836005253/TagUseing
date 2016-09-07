//
//  TagList.h
//  XNTag
//
//  Created by 娜 on 16/8/31.
//  Copyright © 2016年 XCN. All rights reserved.
//标签能够自动计算宽度

#import <UIKit/UIKit.h>

@interface TagList : UIView
/**
 *  删除标签图片
 */
@property (nonatomic,strong) UIImage *deleteTagImamge;
/**
 *  标签间距。距离左、上、右默认为10
 */
@property (nonatomic,assign) CGFloat tagMargin;
/**
 *  标签颜色，默认蓝色
 */
@property (nonatomic,strong) UIColor *tagColor;
/**
 *  标签背景颜色
 */
@property (nonatomic,strong) UIColor *tagBgColor;
/**
 *  标签背景图片
 */
@property (nonatomic,strong) UIImage *tagBgImage;
/**
 *  标签字体，默认12
 */
@property (nonatomic,strong) UIFont *tagFont;
/**
 *  标签内容间距。上下左右均默认为5
 */
@property (nonatomic,assign) CGFloat tagButtonMargin;
/**
 *  标签圆角半径，默认5
 */
@property (nonatomic,assign) CGFloat tagCornerRadius;
/**
 *  标签列表的高度
 */
@property (nonatomic,assign) CGFloat tagListHeight;
/**
 *  边框的宽度
 */
@property (nonatomic, assign) CGFloat borderWidth;
/**
 *  边框的颜色
 */
@property (nonatomic,strong) UIColor *borderColor;
/**
 *  获取所有标签
 */
@property (nonatomic,strong) NSMutableArray *tagAllArray;
/**
 *  是否需要自适应 tagList高度，默认为 YES
 */
@property (nonatomic,assign) BOOL isFitTagListHeight;
/**
 *  是否需要排序功能
 */
@property (nonatomic,assign) BOOL isSort;
/**
 *  排序时标签放大比例，必须大于1
 */
@property (nonatomic,assign) CGFloat sortWithTagScale;
/**
 *  自定义标签必须是按钮类
 */
@property (nonatomic,assign) Class tagClass;
/**
 *  自定义标签尺寸
 */
@property (nonatomic,assign) CGSize customTagSize;
/**
 *  自定义标签列表列数，默认为4列---会自动计算标签间距
 */
@property (nonatomic,assign) NSInteger tagListCols;



/**
 *  添加标签
 *
 *  @param tagText 标签文字
 */
-(void)addTag:(NSString *)tagText;

/**
 *  添加多个标签
 *
 *  @param tagArr 标签数组，数组里是（NSString *）
 */
-(void)addTags:(NSArray *)tagArr;

/**
 *  删除标签
 *
 *  @param tagText 标签文字
 */
-(void)deleteTag:(NSString *)tagText;

/**
 *  点击标签执行 block
 */
@property (nonatomic,copy) void(^clickTagBlock) (NSString *tag);


@end
