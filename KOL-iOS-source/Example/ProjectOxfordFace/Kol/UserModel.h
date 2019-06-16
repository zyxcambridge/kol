//
//  UserModel.h
//  KOLDemo
//
//  Created by Kelvin on 2019/6/15.
//  Copyright © 2019 angelhack. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

/**
 *  @brief 头像
 */
@property (nonatomic, strong) NSString *headerIcon;
/**
 *  @brief 名字
 */
@property (nonatomic, strong) NSString *username;
/**
 *  @brief 日期
 */
@property (nonatomic, strong) NSString *date;
/**
 *  @brief 图片
 */
@property (nonatomic, strong) NSString *image;
/**
 *  @brief 点赞数
 */
@property (nonatomic, strong) NSString *favorCount;


@end

NS_ASSUME_NONNULL_END
