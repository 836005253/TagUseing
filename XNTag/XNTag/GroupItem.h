//
//  GroupItem.h
//  XNTag
//
//  Created by 娜 on 16/9/6.
//  Copyright © 2016年 XCN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupItem : NSObject{
@protected NSMutableArray *_data;
}
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSMutableArray *data;
+(instancetype)groupWithDic:(NSDictionary *)dic;
@end
