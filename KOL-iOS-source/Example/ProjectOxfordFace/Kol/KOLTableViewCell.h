//
//  KOLTableViewCell.h
//  KOLDemo
//
//  Created by Kelvin on 2019/6/15.
//  Copyright © 2019 angelhack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
#import "Constants.h"


NS_ASSUME_NONNULL_BEGIN

@interface KOLTableViewCell : UITableViewCell

/**
 *  @brief 模型
 */
@property (nonatomic, strong) UserModel *userModel;

@end

NS_ASSUME_NONNULL_END
