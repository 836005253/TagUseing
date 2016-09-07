//
//  TagItem.h
//  XNTag
//
//  Created by 娜 on 16/9/6.
//  Copyright © 2016年 XCN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TagItems : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,assign) BOOL isSelected;
+(instancetype)tagWithDic:(NSDictionary *)dic;
@end
