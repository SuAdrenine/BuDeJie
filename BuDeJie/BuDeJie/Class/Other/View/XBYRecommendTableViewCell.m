//
//  XBYRecommendTableViewCell.m
//  BuDeJie
//
//  Created by xby on 2017/7/7.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "XBYRecommendTableViewCell.h"
#import <Masonry.h>

@interface XBYRecommendTableViewCell()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLB;
@property (nonatomic, strong) UILabel *perpleAttentionLB;
@property (nonatomic, strong) UIButton *button;
@end

@implementation XBYRecommendTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubViews];
    }
    
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [self setupSubViewsLayout];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setupSubViews {
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.iconImageView];
    [self.bgView addSubview:self.nameLB];
    [self.bgView addSubview:self.perpleAttentionLB];
    [self.bgView addSubview:self.button];
}

-(void)setupSubViewsLayout {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgView);
        make.left.equalTo(self.bgView).offset(10);
        make.size.mas_equalTo(CGSizeMake(48, 48));
    }];
    
    [self.nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView);
        make.bottom.equalTo(self.iconImageView.mas_centerY).offset(3);
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
    }];
    
    [self.perpleAttentionLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.iconImageView);
        make.top.equalTo(self.nameLB.mas_bottom);
        make.left.equalTo(self.nameLB);
    }];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgView);
        make.size.mas_equalTo(CGSizeMake(60, 24));
        make.right.equalTo(self.bgView).offset(-10);
    }];
}

-(void)clickAction:(UIButton *)button {
    XBYLogFunc
}

#pragma mark - Setter
-(void)setModel:(XBYRecommendModel *)model {
    if (_model == model) {
        return ;
    }
    _model = model;
    
    [self.iconImageView setHeader:model.image_list];
    
    self.nameLB.text = model.theme_name;
    
    NSString *subnumber = @"";
    if ([model.sub_number integerValue] >=10000) {
        subnumber = [NSString stringWithFormat:@"%.2f万人关注",[model.sub_number integerValue]/10000.0];
    } else if([model.sub_number integerValue] >=1000) {
        subnumber = [NSString stringWithFormat:@"%.2f千人关注",[model.sub_number integerValue]/1000.0];
    } else {
        subnumber = [NSString stringWithFormat:@"%ld人关注",[model.sub_number integerValue]];
    }
    
    self.perpleAttentionLB.text = subnumber;
}

#pragma mark - Getter
ViewGetter(bgView, [UIColor whiteColor])
ImageViewGetter(iconImageView, @"")
LabelGetter(nameLB, NSTextAlignmentLeft, ColorFromRGB(0x010101), [UIFont systemFontOfSize:CalcFont(14.5)])
LabelGetter(perpleAttentionLB, NSTextAlignmentLeft,ColorFromRGB(0xaaaaaa), [UIFont systemFontOfSize:CalcFont(12.5)])

-(UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"+ 订阅" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _button;
}

@end
