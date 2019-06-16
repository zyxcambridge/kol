//
//  Constants.h
//  KOLDemo
//
//  Created by Kelvin on 2019/6/15.
//  Copyright © 2019 angelhack. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#include "UIView+XTFrame.h"

// 屏幕的宽高
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

// 随机色
#define RANDOM_COLOR [UIColor colorWithRed:(arc4random()%256)/255.0 green:(arc4random()%256)/255.0 blue:(arc4random()%256)/255.0 alpha:1]

// cell高度
#define CELL_HEIGHT 270
#define MARGIN 20

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 字体
#define MyFont(x)     [UIFont fontWithName:@"HelveticaNeue-Light" size:x]

#endif /* Constants_h */
