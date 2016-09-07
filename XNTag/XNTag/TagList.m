//
//  TagList.m
//  XNTag
//
//  Created by 娜 on 16/8/31.
//  Copyright © 2016年 XCN. All rights reserved.
//

#import "TagList.h"
#import "TagButton.h"
CGFloat const imageViewWh = 20;
@interface TagList ()
/**
 *  标签文字数组
 */
@property(nonatomic,strong) NSMutableArray *tagArray;
/**
 * 存放标签的字典
 */
@property (nonatomic,strong) NSMutableDictionary *tagsDic;
/**
 *  添加上的标签按钮数组
 */
@property (nonatomic,strong) NSMutableArray *tagButtonArray;
/**
 *  需要移动的矩阵
 */
@property (nonatomic,assign) CGRect moveRect;
@property (nonatomic,assign) CGPoint originCenter;
@end

@implementation TagList

#pragma mark - lazy
-(NSMutableArray *)tagArray{
    if (_tagArray == nil) {
        _tagArray = [[NSMutableArray alloc]init];
    }
    return _tagArray;
}

-(NSMutableArray *)tagButtonArray{
    if (_tagButtonArray == nil) {
        _tagButtonArray = [[NSMutableArray alloc]init];
    }
    return _tagButtonArray;
}

-(NSMutableDictionary *)tagsDic{
    if (_tagsDic == nil) {
        _tagsDic = [NSMutableDictionary dictionary];
    }
    return _tagsDic;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

#pragma mark - 初始化
-(void)setup{
    self.tagMargin = 10;
    self.tagColor = [UIColor blueColor];
    self.tagFont = [UIFont systemFontOfSize:12];
    self.tagButtonMargin = 5;
    self.tagCornerRadius = 5;
    self.clipsToBounds = YES;
    self.borderWidth = 0;
    self.borderColor = [UIColor redColor];
    self.tagListCols = 4;
    _sortWithTagScale = 1;
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

/**
 *  tagListHeight的 get方法
 *
 *  @return 标签列表的高度
 */
-(CGFloat) tagListHeight{
    if (_tagButtonArray.count <= 0) return 0;
    return CGRectGetMaxY([_tagButtonArray.lastObject frame]) + _tagMargin;
}

/**
 *  sortWithTagScale的 set 方法
 *
 *  @param sortWithTagScale 缩放比例系数
 */
-(void)setSortWithTagScale:(CGFloat)sortWithTagScale{
    if (_sortWithTagScale < 1) {
        @throw [NSException exceptionWithName:@"YZError" reason:@"(scaleTagInSort)缩放比例必须大于1" userInfo:nil];
    }
    _sortWithTagScale = sortWithTagScale;
}

#pragma mark - 标签操作方法
//添加多个标签
-(void)addTags:(NSArray *)tagArr{
    if (self.frame.size.width == 0) {
        @throw [NSException exceptionWithName:@"Error" reason:@"先设置标签列表的 frame" userInfo:nil];
    }
    for (NSString *tag in tagArr) {
        [self addTag:tag];
    }
}

//添加标签
-(void)addTag:(NSString *)tagText{
    Class tagClass = self.tagClass ? self.tagClass : [TagButton class];
    //创建标签按钮
    TagButton *button = [tagClass buttonWithType:UIButtonTypeCustom];
    if (_tagClass == nil) {
        button.margin = _tagButtonMargin;
    }
    button.layer.cornerRadius = self.tagCornerRadius;
    button.layer.borderColor = (__bridge CGColorRef _Nullable)(self.borderColor);
    button.layer.borderWidth = self.borderWidth;
    button.clipsToBounds = YES;
    button.tag = self.tagButtonArray.count;
    [button setImage:self.deleteTagImamge forState:UIControlStateNormal];
    [button setTitle:tagText forState:UIControlStateNormal];
    [button setBackgroundImage:self.tagBgImage forState:UIControlStateNormal];
    [button setBackgroundColor:self.tagBgColor];
    [button setTitleColor:self.tagColor forState:UIControlStateNormal];
    button.titleLabel.font = self.tagFont;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.isSort) {
        //给标签难处添加拖动手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        [button addGestureRecognizer:pan];
    }
    [self addSubview:button];
    //保存到数组中
    [self.tagButtonArray addObject:button];
    //保存到字典中
    [self.tagsDic setValue:button forKey:tagText];
    [self.tagArray addObject:tagText];
    //设置标签按钮的位置
    [self setTagButtonFrame:button.tag extreMargin:YES];
    
    //更新自己的高度
    if (_isFitTagListHeight) {
        CGRect frame = self.frame;
        frame.size.height = self.tagListHeight;
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = frame;
        }];
    }
}

/**
 *  设置标签按钮的位置
 */
-(void)setTagButtonFrame:(NSInteger)tag extreMargin:(BOOL)extreMargin{
    //获取上一个按钮
    NSInteger lastI = tag - 1;
    //定义上一个按钮
    UIButton *lastButton;
    //判断上一个按钮的角标
    if (lastI >= 0) {
        lastButton = self.tagButtonArray[lastI];
    }
    //获取当前按钮
    TagButton *currentButton = self.tagButtonArray[tag];
    //判断是否设置了标签尺寸
    if (self.customTagSize.width == 0) {
        //设置标签尺寸 frame （自适应的）
        [self setCustomCurrentButtonTagWithFrame:currentButton lastButton:lastButton extreMargin:extreMargin];
    }else{
        //计算标签按钮 frame，按规律排列
        [self setRegularTagButtonWithFrame:currentButton];
    }
    
}

//设置自适应的标签按钮的 frame
-(void)setCustomCurrentButtonTagWithFrame:(UIButton *)currentButton lastButton:(UIButton *)lastButton extreMargin:(BOOL)extreMargin{
    //当前标签按钮的 X 等于上一个标签按钮的最大 X+间距
    CGFloat buttonX = CGRectGetMaxX(lastButton.frame) + self.tagMargin;
    //当前标签按钮的 Y 等于上一个标签的Y，如果没有就等于标签间距
    CGFloat buttonY = lastButton ? lastButton.frame.origin.y : self.tagMargin;
    //获取按钮的宽度
    // 获取按钮宽度
    CGFloat titleW = [currentButton.titleLabel.text sizeWithFont:_tagFont].width;
    CGFloat titleH = [currentButton.titleLabel.text sizeWithFont:_tagFont].height;
    CGFloat btnW = extreMargin?titleW + 2 * _tagButtonMargin : currentButton.bounds.size.width ;
    if (self.deleteTagImamge && extreMargin == YES) {
        btnW += imageViewWh;
        btnW += _tagButtonMargin;
    }
    
    // 获取按钮高度
    CGFloat btnH = extreMargin? titleH + 2 * _tagButtonMargin:currentButton.bounds.size.height;
    if (self.deleteTagImamge && extreMargin == YES) {
        CGFloat height = imageViewWh > titleH ? imageViewWh : titleH;
        btnH = height + 2 * _tagButtonMargin;
    }
    //判断当前标签按钮是否能够完全显示
    CGFloat lastWidth = self.bounds.size.width - buttonX;
    if (lastWidth < btnW) {
        //不够显示，到下一行显示
        buttonX = self.tagMargin;
        buttonY = CGRectGetMaxY(lastButton.frame) + self.tagMargin;
    }
    currentButton.frame = CGRectMake(buttonX, buttonY, btnW, btnH);

}

-(void)setRegularTagButtonWithFrame:(UIButton *)currentButton{
    //获取角标
    NSInteger i = currentButton.tag;
    NSInteger col = i % self.tagListCols;
    NSInteger row = i / self.tagListCols;
    CGFloat buttonW = self.customTagSize.width;
    CGFloat buttonH = self.customTagSize.height;
    //标签之间的距离
    NSInteger margin = (self.frame.size.width - self.tagListCols * buttonW - self.tagMargin * 2) / (self.tagListCols - 1);
    CGFloat buttonX = self.tagMargin + (buttonW + margin) * col;
    CGFloat buttonY = self.tagMargin + (buttonH + margin) * row;
    currentButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
}

//标签按钮的点击事件
-(void)buttonClick:(UIButton *)sender{
    if (_clickTagBlock) {
        self.clickTagBlock(sender.currentTitle);
    }
}

//pan 的事件处理
-(void)pan:(UIPanGestureRecognizer *)pan{
    //获取偏移量
    CGPoint transP = [pan translationInView:self];
    UIButton *currentButton = (UIButton *)pan.view;

    //开始
    if (pan.state == UIGestureRecognizerStateBegan) {//拖动状态为开始
        _originCenter = currentButton.center;
        [UIView animateWithDuration:-0.25 animations:^{
            currentButton.transform = CGAffineTransformMakeScale(_sortWithTagScale, _sortWithTagScale);
        }];
        [self addSubview:currentButton];
    }
    CGPoint center = currentButton.center;
    center.x += transP.x;
    center.y += transP.y;
    currentButton.center = center;
    
    //改变
    if (pan.state == UIGestureRecognizerStateChanged) {//拖动
        //获取当前按钮的中心点在哪个按钮上
        UIButton * otherButton = [self setCurrentButtonWithCenter:currentButton];
        if (otherButton) {//插入到这个按钮的位子
            //获取要插入的位置的按钮的角标
            NSInteger i = otherButton.tag;
            //获取到被拖动的按钮的角标
            NSInteger currentI = currentButton.tag;
            //移动后的 frame
            self.moveRect = otherButton.frame;
            
            //排序
            //移除之前的，插入到所要移动到的位置上
            [self.tagButtonArray removeObject:currentButton];
            [self.tagButtonArray insertObject:currentButton atIndex:i];
            
            [self.tagArray removeObject:currentButton.currentTitle];
            [self.tagArray insertObject:currentButton.currentTitle atIndex:i];
            //更新标签角标
            [self updateTag];
            
            if (currentI > i) {//插入到前面
                //更新之后的标签 frame
                [UIView animateWithDuration:0.25 animations:^{
                    [self updateLaterTagButtonWithFrame:i-1];
                }];
            }else{//插入到后面
                //更新前面的按钮的 frame
                [UIView animateWithDuration:0.25 animations:^{
                    [self updateBeforeTagButtonWithFrame:i];
                }];
            }
        }
    }
    //结束
    if (pan.state == UIGestureRecognizerStateEnded) {//结束
        
        [UIView animateWithDuration:0.25 animations:^{
            currentButton.transform = CGAffineTransformIdentity;
            if (_moveRect.size.width <= 0) {
                currentButton.center = _originCenter;
            }else{
                currentButton.frame = _moveRect;
            }
        }completion:^(BOOL finished) {
            _moveRect = CGRectZero;
        }];
    }
    
    [pan setTranslation:CGPointZero inView:self];
}

/**
 *  判断当前标签按钮在那个按钮的位置上
 *
 *  @param currentButton 当前
 *
 *  @return 返回所在位置的按钮
 */
-(UIButton *)setCurrentButtonWithCenter:(UIButton *)currentButton{
    for (UIButton *button in self.tagButtonArray) {
        if (currentButton == button) continue;
        if (CGRectContainsPoint(button.frame, currentButton.center)) {
            return button;
        }
    }
    return nil;
}

/**
 *  更新标签角标
 */
-(void)updateTag{
    NSInteger count = self.tagButtonArray.count;
    for (int i = 0; i < count; i++) {
        UIButton *button = self.tagButtonArray[i];
        button.tag = i;
    }
}


/**
 *  更新后面的标签按钮
 *
 *  @param LaterI 后面按钮的角标
 */
-(void)updateLaterTagButtonWithFrame:(NSInteger)LaterI{
    NSInteger count = self.tagButtonArray.count;
    for (NSInteger i = LaterI; i < count; i++) {
        //更新按钮
        [self setTagButtonFrame:i extreMargin:NO];
    }
}

/**
 *  更新之前的所有按钮的 frame
 *
 *  @param beforeI  前面按钮的角标
 */
-(void)updateBeforeTagButtonWithFrame:(NSInteger)beforeI{
    for (int i = 0; i < beforeI; i++) {
        //更新按钮
        [self setTagButtonFrame:i extreMargin:NO];
    }
}


/**
 *  删除标签
 *
 *  @param tagText 标签文字
 */
-(void)deleteTag:(NSString *)tagText{
    //获取对应标签按钮
    TagButton *tagButton = self.tagsDic[tagText];
    //移除按钮
    [tagButton removeFromSuperview];
    //移除数组
    [self.tagButtonArray removeObject:tagButton];
    //移除字典
    [self.tagsDic removeObjectForKey:tagText];
    //移除数组
    [self.tagArray removeObject:tagText];
    //更新标签
    [self updateTag];
    //更新后面按钮的 frame
    [UIView animateWithDuration:0.25 animations:^{
        [self updateLaterTagButtonWithFrame:tagButton.tag];
    }];
    //更新自己的 frame
    if (_isFitTagListHeight) {
        CGRect frame = self.frame;
        frame.size.height = self.tagListHeight;
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = frame;
        }];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
