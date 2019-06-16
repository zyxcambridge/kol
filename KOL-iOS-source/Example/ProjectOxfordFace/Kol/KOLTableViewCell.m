//
//  KOLTableViewCell.m
//  KOLDemo
//
//  Created by Kelvin on 2019/6/15.
//  Copyright © 2019 angelhack. All rights reserved.
//

#import "KOLTableViewCell.h"

@interface KOLTableViewCell()

@property (nonatomic, weak) UIImageView *headerIv;
@property (nonatomic, weak) UILabel *usernameLb;
@property (nonatomic, weak) UILabel *dateLb;
@property (nonatomic, weak) UIImageView *imageIv;
@property (nonatomic, weak) UILabel *favorLb;
@property (nonatomic, weak) UIImageView *favorIv;

@end

@implementation KOLTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"KOLTableViewCell";
    KOLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[KOLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        self.backgroundColor = RANDOM_COLOR;
        
        self.frame = CGRectMake(0, 0, WIDTH, CELL_HEIGHT);
        
        // 头像
        UIImageView *headerIcon = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN, MARGIN, 60, 60)];
//        headerIcon.backgroundColor = [UIColor magentaColor];
        headerIcon.layer.cornerRadius = headerIcon.width / 2;
        headerIcon.layer.masksToBounds = YES;
        [self.contentView addSubview:headerIcon];
        _headerIv = headerIcon;
        
        // 姓名
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(headerIcon.right + 20, MARGIN + 10, WIDTH - headerIcon.right, 20)];
        [self.contentView addSubview:nameLabel];
//        nameLabel.backgroundColor = [UIColor orangeColor];
        nameLabel.textColor = UIColorFromRGB(0x1b1b1b);
        nameLabel.font = MyFont(16);
        _usernameLb = nameLabel;
        
        // 日期
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(headerIcon.right + 20, nameLabel.bottom + 5, nameLabel.width, 14)];
        [self.contentView addSubview:dateLabel];
//        dateLabel.backgroundColor = [UIColor blueColor];
        dateLabel.textColor = UIColorFromRGB(0x989898);
        dateLabel.font = MyFont(11);
        _dateLb = dateLabel;
        
        // 图片
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN, headerIcon.bottom + 15, WIDTH - MARGIN * 2, 150)];
//        imageView.backgroundColor = [UIColor redColor];
        imageView.layer.cornerRadius = 5;
        imageView.layer.masksToBounds = YES;
        [self.contentView addSubview:imageView];
        _imageIv = imageView;
        
        // 点赞
        UIImageView *favorView = [[UIImageView alloc] initWithFrame:CGRectMake(headerIcon.x + 20, imageView.bottom + 10, 15, 15)];
//        favorView.backgroundColor = [UIColor magentaColor];
        favorView.image = [UIImage imageNamed:@"favor_inactive_icon"];
        [self.contentView addSubview:favorView];
        [favorView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(favorClickGesture)]];
        _favorIv = favorView;
        
        // favor
        UILabel *favorLabel = [[UILabel alloc] initWithFrame:CGRectMake(favorView.right + 8, imageView.bottom + 11, 100, 14)];
        [self.contentView addSubview:favorLabel];
//        favorLabel.backgroundColor = [UIColor whiteColor];
        favorLabel.textColor = UIColorFromRGB(0x7A8FA6);
        favorLabel.font = MyFont(12);
        favorLabel.text = @"Favorite";
        _favorLb = favorLabel;
    }
    
    return self;
}

- (void)setUserModel:(UserModel *)userModel {
    _userModel = userModel;
    
    if (_userModel) {
        self.headerIv.image = [UIImage imageNamed:userModel.headerIcon];
        self.usernameLb.text = userModel.username;
        self.dateLb.text = userModel.date;
        self.imageIv.image = [UIImage imageNamed:userModel.image];
    }
}

- (void)favorClickGesture {
    _favorIv.image = [UIImage imageNamed:@"favor_active_icon"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
